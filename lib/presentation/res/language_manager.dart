const String arabic = 'ar';
const String english = 'en';

enum LanguageTypes { arabic, english }

extension LanguageTypesExtension on LanguageTypes {
  String getLang() {
    switch (this) {
      case LanguageTypes.arabic:
        return arabic;
      case LanguageTypes.english:
        return english;
    }
  }
}
