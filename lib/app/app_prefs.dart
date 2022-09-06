import 'package:flutter_architecture/presentation/res/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String languageKeyPref = 'language';
const String prefKeyOnBoardingViewed = 'prefKeyOnBoardingViewed';
const String prefKeyIsUserLoggedIn = 'prefKeyIsUserLoggedIn';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  String getLang() {
    String? lang = _sharedPreferences.getString(languageKeyPref);
    if (lang == null) {
      return LanguageType.arabic.getLang();
    } else {
      return lang;
    }
  }

  // onBoarding

  Future<void> setOnBoardingViewed() async {
    _sharedPreferences.setBool(prefKeyOnBoardingViewed, true);
  }

  Future<bool> isOnBoardingViewed() async {
    return _sharedPreferences.getBool(prefKeyOnBoardingViewed) ?? false;
  }

  // Login

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(prefKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefKeyIsUserLoggedIn) ?? false;
  }
}
