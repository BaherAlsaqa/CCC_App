
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  final SharedPreferences sharedPreferences;

  AppSharedPreferences({@required this.sharedPreferences});

  static const OPEN_FIRST_INTRO = 'open_first_intro';
  // static const FIRST_CART_AFTER_CLEAN = 'first_cart_after_clean';
  // static const USER = 'user';
  // static const SETTINGS = 'settings';
  // static const CART_LIST = 'cartList';
  // static const CART_DATE = 'cartDate';
  // static const CURRENT_ORDER_ID = 'currentOrderId';

  Future<void> clear() {
    sharedPreferences.remove('open_first_intro');

  }
  Future<void> setOpenIntro(bool open) async {
    return await sharedPreferences.setBool(OPEN_FIRST_INTRO, open);
  }

  bool getOpenIntro() {
    return sharedPreferences.getBool(OPEN_FIRST_INTRO) ?? false;
  }
}
