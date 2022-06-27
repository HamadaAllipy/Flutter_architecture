class SliderObject {
  final String title;
  final String supTitle;
  final String image;

  SliderObject(this.title, this.supTitle, this.image);
}

class SliderViewObject {
  final SliderObject sliderObject;
  final int numOfSlider;
  final int currentIndex;

  SliderViewObject({
    required this.sliderObject,
    required this.currentIndex,
    required this.numOfSlider,
  });
}
void test(){}