import 'dart:async';

import 'package:flutter_architecture/domain/models/models.dart';
import 'package:flutter_architecture/presentation/base/base_view_model.dart';

import '../../res/res.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInput, OnBoardingViewModelOutput {
  final StreamController<SliderViewObject> _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _sliders;
  int _currentIndex = 0;

  void _postDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(
        sliderObject: _sliders[_currentIndex],
        currentIndex: _currentIndex,
        numOfSlider: _sliders.length,
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _sliders = getSliders();
    _postDataToView();
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outSliderViewObject => _streamController.stream;

  @override
  int goNextIndex() {
    int index = ++_currentIndex;
    if (index == _sliders.length) {
      index = 0;
    }
    return index;
  }

  @override
  int goPreviousIndex() {
    int index = --_currentIndex;
    if (index == -1) {
      index = _sliders.length - 1;
    }
    return index;
  }


  // section private methods
  List<SliderObject> getSliders() => [
    SliderObject(
      AppStrings.titleOnBoarding1,
      AppStrings.supTitleOnBoarding1,
      ImagesManager.imageOnBoarding1,
    ),
    SliderObject(
      AppStrings.titleOnBoarding2,
      AppStrings.supTitleOnBoarding2,
      ImagesManager.imageOnBoarding2,
    ),
    SliderObject(
      AppStrings.titleOnBoarding3,
      AppStrings.supTitleOnBoarding3,
      ImagesManager.imageOnBoarding3,
    ),
    SliderObject(
      AppStrings.titleOnBoarding4,
      AppStrings.supTitleOnBoarding4,
      ImagesManager.imageOnBoarding4,
    ),
  ];
}

abstract class OnBoardingViewModelInput {
  int goNextIndex();

  int goPreviousIndex();

  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutput {
  Stream<SliderViewObject> get outSliderViewObject;
}
