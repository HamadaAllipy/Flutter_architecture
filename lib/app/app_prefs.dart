import 'package:flutter_architecture/presentation/res/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String languageKeyPref = 'language';

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
}
