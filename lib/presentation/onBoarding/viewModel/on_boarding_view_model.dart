import 'package:flutter_architecture/presentation/base/base_view_model.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInput, OnBoardingViewModelOutput {
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
}

abstract class OnBoardingViewModelInput {
  void skip();

  void goNextSlider();

  void goPreviousSlider();

  int onPageChanged(int index);
}

abstract class OnBoardingViewModelOutput {}
