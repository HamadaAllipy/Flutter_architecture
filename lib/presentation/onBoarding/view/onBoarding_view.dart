import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/domain/models.dart';
import 'package:flutter_architecture/presentation/onBoarding/view/slider_page.dart';
import 'package:flutter_architecture/presentation/onBoarding/viewModel/on_boarding_view_model.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (_, snapshot) {
        log('DATA ${snapshot.data}');
        return _getContentWidget(snapshot.data);
      },
    );
  }

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject){
    if(sliderViewObject == null){
      return Container(color: Colors.red,);
    }
    return Scaffold(
      appBar: AppBar(),
      body: PageView.builder(
        itemCount: sliderViewObject.slidersLength,
        onPageChanged: (newIndex){
        },
        itemBuilder: (context, index) {
          return SliderPage(sliderObject: sliderViewObject.sliderObject);
        },
      ),
    );
  }

}
