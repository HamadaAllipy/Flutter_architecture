enum LanguageType {
  arabic,
  english,
}

const String english = 'en';
const String arabic = 'ar';

extension LanguageTypeExtension on LanguageType {
  String getLang() {
    switch (this) {
      case LanguageType.arabic:
        return arabic;
      case LanguageType.english:
        return english;
    }
  }
}
