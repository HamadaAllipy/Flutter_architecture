// onBoarding
class SliderObject {
  final String title;
  final String supTitle;
  final String image;

  SliderObject({
    required this.image,
    required this.supTitle,
    required this.title,
  });
}

class SliderViewObject {
  final SliderObject sliderObject;
  final int slidersLength;
  final int currentIndex;

  SliderViewObject({
    required this.sliderObject,
    required this.currentIndex,
    required this.slidersLength,
  });
}
