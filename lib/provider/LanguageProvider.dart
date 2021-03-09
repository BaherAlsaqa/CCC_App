import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagesProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  LanguagesProvider({@required this.sharedPreferences});

  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");

  fetchLocale() async {
    sharedPreferences.reload();
    if (sharedPreferences.getString('language_code') == null) {
      _appLocale = Locale('en');
      print("APPLocal null");

      return Null;
    }
    _appLocale = Locale(sharedPreferences.getString('language_code'));
    this._appLocale = _appLocale;
    notifyListeners();
    print("APPLocal $_appLocale");

    return _appLocale;
  }

  void changeLanguage(
      BuildContext context, Locale type, String lang, Function onDone) async {
    print("changeLanguage");
    _appLocale = type;
    print("no user");

    if (type.languageCode.toLowerCase() == "ar") {
      _appLocale = Locale("ar");
      sharedPreferences.setString('language_code', 'ar');
      sharedPreferences.setString('countryCode', 'SA');
    } else {
      _appLocale = Locale("en");
      sharedPreferences.setString('language_code', 'en');
      sharedPreferences.setString('countryCode', 'US');
    }
    print(
        "language_code aaa--- ${sharedPreferences.getString("language_code")}");
    print("language_code aaa--- ${sharedPreferences.getString("countryCode")}");
    sharedPreferences.reload();
    notifyListeners();
  }
}
