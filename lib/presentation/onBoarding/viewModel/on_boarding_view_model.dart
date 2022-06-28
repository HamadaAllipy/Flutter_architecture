import 'dart:async';

import 'package:flutter_architecture/domain/models.dart';
import 'package:flutter_architecture/presentation/base/base_view_model.dart';

import '../../res/res.dart';

class OnBoardingViewModel extends BaseViewModel with _OnBoardingViewModelInput, _OnBoardingViewModelOutput{

  late final List<SliderObject> _sliders;
  final int _currentIndex = 0;
  final StreamController<SliderViewObject> _streamController = StreamController<SliderViewObject>();

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    _sliders = _getAllSlider();
    _postDataToView();
  }


  // Section private methods

  void _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(sliderObject: _sliders[_currentIndex], currentIndex: _currentIndex, slidersLength: _sliders.length));
  }

  List<SliderObject> _getAllSlider()=>[
    SliderObject(
      title: AppStrings.titleOnBoarding1,
      supTitle: AppStrings.supTitleOnBoarding1,
      image: ImagesManager.imageOnBoarding1,
    ),
    SliderObject(
      title: AppStrings.titleOnBoarding2,
      supTitle: AppStrings.supTitleOnBoarding2,
      image: ImagesManager.imageOnBoarding2,
    ),
    SliderObject(
      title: AppStrings.titleOnBoarding3,
      supTitle: AppStrings.supTitleOnBoarding3,
      image: ImagesManager.imageOnBoarding3,
    ),
    SliderObject(
      title: AppStrings.titleOnBoarding4,
      supTitle: AppStrings.supTitleOnBoarding4,
      image: ImagesManager.imageOnBoarding4,
    ),
  ];

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream;
}


// input view model
abstract class _OnBoardingViewModelInput{


  Sink get inputSliderViewObject;
}
// output view model
abstract class _OnBoardingViewModelOutput{
  Stream<SliderViewObject> get outputSliderViewObject;
}