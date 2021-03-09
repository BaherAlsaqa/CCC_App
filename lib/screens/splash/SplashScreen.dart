import 'dart:async';
import 'package:ccc_app/constants/colors.dart';
import 'package:ccc_app/constants/constants.dart';
import 'package:ccc_app/custom_widgets/CustomText.dart';
import 'package:ccc_app/screens/auth/LoginScreen.dart';
import 'package:ccc_app/screens/home/HomeScreen.dart';
import 'package:ccc_app/singleton/AppSharedPreference.dart';
import 'package:ccc_app/singleton/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    !getIt<AppSharedPreferences>().getOpenIntro()?
    systemChrome(darkMode: true, navBrightness: Brightness.dark,
        navBarColor: primaryColor):
    systemChrome(darkMode: false, navBrightness: Brightness.light,
        navBarColor: white);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => getIt<AppSharedPreferences>().getOpenIntro()
                ? LoginScreen()/*HomeScreen(0)*/
                : LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812));
    systemChrome(darkMode: false);
    return Container(
      color: customGray,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: white,
            body: Stack(
              children: [
                // SvgPicture.asset(
                //   "assets/images/splash_background.svg",
                //   fit: BoxFit.cover,
                // ),
                Center(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      // SvgPicture.asset(
                      //   "assets/images/app_logo.svg",
                      // ),
                      // SizedBox(height: 15),
                      CustomText(
                        "App_name",
                        fontSize: 33,
                        primaryFont: PRIMARY_FONT_BOLD,
                        fontWeight: FontWeight.bold,
                        textColor: titleColor,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
