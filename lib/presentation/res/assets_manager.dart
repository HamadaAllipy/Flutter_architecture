
const String _imagesPath = 'assets/images';
const String _iconPath = 'assets/icons';
const String _jsonPath = 'assets/json';
class ImagesManager{
  ImagesManager._();

  static const String splashLogo = '$_imagesPath/splash_logo.png';
  static const String imageOnBoarding1 = '$_imagesPath/image_onBoarding_1.svg';
  static const String imageOnBoarding2 = '$_imagesPath/image_onBoarding_2.svg';
  static const String imageOnBoarding3 = '$_imagesPath/image_onBoarding_3.svg';
  static const String imageOnBoarding4 = '$_imagesPath/image_onBoarding_4.svg';
}
class IconsManager{
  IconsManager._();

  static const String circleHollow = '$_iconPath/circle_hollow.svg';
  static const String circleSolid = '$_iconPath/circle_solid.svg';
}

class JsonManager{
  static const String errorAnimation = '$_jsonPath/error.json';
  static const String loadingAnimation = '$_jsonPath/loading.json';
  static const String emptyAnimation = '$_jsonPath/empty.json';
}