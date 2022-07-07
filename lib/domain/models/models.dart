// onBoarding

class SliderObject {
  final String title, supTitle, imagePath;

  SliderObject(
    this.title,
    this.supTitle,
    this.imagePath,
  );
}

class SliderViewObject{

  final SliderObject sliderObject;
  final int currentIndex;
  final int numOfSliders;

  SliderViewObject(this.sliderObject, this.currentIndex, this.numOfSliders);
}