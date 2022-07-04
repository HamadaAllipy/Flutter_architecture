import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/domain/models/models.dart';
import 'package:flutter_architecture/presentation/onBoarding/view/slider_page.dart';
import 'package:flutter_architecture/presentation/onBoarding/viewModel/on_boarding_view_model.dart';
import 'package:flutter_architecture/presentation/res/app_constants.dart';
import 'package:flutter_architecture/presentation/res/res.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outSliderViewObject,
      builder: (context, snapshot) => _getContentWidget(snapshot.data),
    );
  }

  void _skipButton() {}

  void _goNextPageBtn() {
    setState((){
      _pageController.animateToPage(_viewModel.goNextIndex(), duration: const Duration(milliseconds: AppConstants.sliderTime), curve: Curves.linear);
    }); 
  }

  void _goPreviousPage() {
    setState((){
      _pageController.animateToPage(_viewModel.goPreviousIndex(), duration: const Duration(milliseconds: AppConstants.sliderTime), curve: Curves.linear);
    });
  }


  Widget indicatorWidget(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(
        IconsManager.circleSolid,
        width: AppSize.s12,
        height: AppSize.s12,
        color: ColorsManager.white,
      );
    }
    else{

    }
    return SvgPicture.asset(
      IconsManager.circleHollow,
      width: AppSize.s12,
      height: AppSize.s12,
      color: ColorsManager.white,
    );
  }

  void _bind(){
    _viewModel.start();
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    log('LOG ${sliderViewObject}');
    if(sliderViewObject == null){
      return Container();
    }
    else{
      return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: ColorsManager.white,
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          itemBuilder: (context, index) {
            return SliderPage(slider: sliderViewObject.sliderObject);
          },
          itemCount: sliderViewObject.numOfSlider,
          onPageChanged: (value) {
            _viewModel.onPageChanged(value);
          },
        ),
        bottomSheet: Container(
          color: ColorsManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: _skipButton,
                  child: Text(
                    AppStrings.skip,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
              Container(
                color: ColorsManager.primary,
                height: AppSize.s50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: _goPreviousPage,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: ColorsManager.white,
                      ),
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < sliderViewObject.numOfSlider; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: indicatorWidget(i, sliderViewObject.currentIndex),
                          ),
                      ],
                    ),
                    IconButton(
                      onPressed: _goNextPageBtn,
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: ColorsManager.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

}




