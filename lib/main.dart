import 'package:ccc_app/provider/LanguageProvider.dart';
import 'package:ccc_app/screens/splash/SplashScreen.dart';
import 'package:ccc_app/singleton/dio.dart';
import 'package:ccc_app/utils/AppLocalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:ccc_app/singleton/dio.dart' as dio;
import 'constants/colors.dart';
import 'constants/constants.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dio.init();
  dio.getIt<LanguagesProvider>().fetchLocale();

  systemChrome(darkMode: false);

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => dio.getIt<LanguagesProvider>(),),
      ],
      child: Consumer<LanguagesProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
              title: 'CCC',
              navigatorKey: navigatorKey,
              locale: languageProvider.appLocal,
              theme: ThemeData(
                  primarySwatch: blueColor, fontFamily: PRIMARY_FONT_LIGHT),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                AppLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate
              ],
              supportedLocales: [
                Locale('en'),
                Locale('ar'),
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              home: SplashScreen());
        },
      ),
    ),
  );
}
