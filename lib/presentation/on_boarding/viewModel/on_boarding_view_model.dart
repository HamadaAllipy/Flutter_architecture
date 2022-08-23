import 'dart:async';

import 'package:flutter_architecture/domain/models/models.dart';
import 'package:flutter_architecture/presentation/base/base_view_model.dart';
import 'package:flutter_architecture/presentation/res/Strings_manager.dart';
import 'package:flutter_architecture/presentation/res/assets_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInput , OnBoardingViewModelOutput{


  final StreamController<SliderViewObject> _streamController = StreamController<SliderViewObject>();

  late final List<SliderObject> _slider = _getAllSlider();

  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    postDataToView();
  }

  void postDataToView(){
    inputSlider.add(SliderViewObject(_slider[_currentIndex], _slider.length, _currentIndex));
  }


  List<SliderObject> _getAllSlider()=>[
        SliderObject(
          StringsManager.titleOnBoarding1,
          StringsManager.supTitleOnBoarding1,
          ImagesManager.onBoardingLogo1,
        ),
        SliderObject(
          StringsManager.titleOnBoarding2,
          StringsManager.supTitleOnBoarding2,
          ImagesManager.onBoardingLogo2,
        ),
        SliderObject(
          StringsManager.titleOnBoarding3,
          StringsManager.supTitleOnBoarding3,
          ImagesManager.onBoardingLogo3,
        ),
        SliderObject(
          StringsManager.titleOnBoarding4,
          StringsManager.supTitleOnBoarding4,
          ImagesManager.onBoardingLogo4,
        ),
      ];

  @override
  Sink<SliderViewObject> get inputSlider => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSlider => _streamController.stream;

  @override
  void onPageChanged(int value) {
    _currentIndex = value;
    postDataToView();
  }

  @override
  int getNextIndex() {
    if (_currentIndex == _slider.length - 1) {
      return 0;
    } else {
      return ++_currentIndex;
    }
  }

  @override
  int getPreviousIndex() {
    if(_currentIndex == 0){
      return _slider.length - 1;
    }
    else{
      return --_currentIndex;
    }
  }
}


abstract class OnBoardingViewModelInput {

  Sink<SliderViewObject> get inputSlider ;

  void onPageChanged(int value);


  int getNextIndex();

  int getPreviousIndex();

}

abstract class OnBoardingViewModelOutput {

  Stream<SliderViewObject> get outputSlider ;
}


class SliderViewObject {
  final SliderObject sliderObject;
  final int slidersLength;
  final int currentIndex;

  SliderViewObject(this.sliderObject, this.slidersLength, this.currentIndex);
}