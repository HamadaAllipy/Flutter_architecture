import 'dart:async';

import 'package:flutter_architecture/domain/models.dart';
import 'package:flutter_architecture/presentation/base/base_view_model.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInput, OnBoardingViewModelOutput {

  final StreamController _streamController = StreamController<SliderViewObject>();

  @override
  void dispose() {}

  @override
  void start() {}

  @override
  void goNextSlider() {}

  @override
  void goPreviousSlider() {}

  @override
  int onPageChanged(int index) {
    throw UnimplementedError();
  }

  @override
  void skip() {}

  @override
  // TODO: implement sink
  Sink get inputSliderViewObject => throw UnimplementedError();

  @override
  // TODO: implement stream
  Stream get outSliderViewObject => throw UnimplementedError();
}

abstract class OnBoardingViewModelInput {
  void skip();

  void goNextSlider();

  void goPreviousSlider();

  int onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutput {
  Stream get outSliderViewObject;
}
