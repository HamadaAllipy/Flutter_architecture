// Package imports:
// Project imports:
import 'package:flutter_architecture/presentation/res/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String keyLanguage = 'language';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getLanguage() async {
    String? lang = _sharedPreferences.getString(keyLanguage);

    if (lang != null && lang.isNotEmpty) {
      return lang;
    } else {
      return LanguageTypes.arabic.getLang();
    }
  }
}
