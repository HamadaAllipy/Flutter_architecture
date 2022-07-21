import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_architecture/domain/models/models.dart';
import 'package:flutter_architecture/presentation/onBoarding/viewModel/on_boarding_view_model.dart';
import 'package:flutter_architecture/presentation/res/app_constants.dart';
import 'package:flutter_architecture/presentation/res/res.dart';
import 'package:flutter_svg/svg.dart';

part 'slider_page.dart';

part 'widgets/indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final OnBoardingViewModel _viewModel;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _viewModel = OnBoardingViewModel();
    _viewModel.start();
    super.initState();
  }


  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _viewModel.outputSliderViewObject,
      builder: (_, AsyncSnapshot<SliderViewObject> snapshot) =>
          getContentWidget(snapshot.data),
    );
  }

  Widget getContentWidget(SliderViewObject? sliderViewObject) {
    if(sliderViewObject == null)return const SizedBox();
    return Scaffold(
      body: bodyWidget(sliderViewObject),
      bottomNavigationBar: bottomWidget(sliderViewObject.currentIndex),
    );
  }

  Widget bodyWidget(SliderViewObject sliderViewObject) {
    return SafeArea(
      child: PageView.builder(
        controller: _pageController,
        itemCount: sliderViewObject.numOfSliders,
        itemBuilder: (_, __) => SliderPage(
          sliderObject: sliderViewObject.sliderObject,
        ),
        onPageChanged: (index) {
          _viewModel.onPageChanged(index);
        },
      ),
    );
  }

  Widget bottomWidget(int currentIndex) {
    return Container(
      color: ColorsManager.white,
      height: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            style: TextButton.styleFrom(
              primary: ColorsManager.primary,
            ),
            onPressed: _skipButton,
            child: Text(
              AppString.skip,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          Expanded(
            child: Container(
              color: ColorsManager.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    padding: const EdgeInsetsDirectional.only(
                      start: AppPadding.p12,
                    ),
                    onPressed: onLeftArrowButton,
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: ColorsManager.white,
                    ),
                  ),
                  const Spacer(),
                  for (int i = 0; i < _viewModel.slider.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p8,
                      ),
                      child: getCircleIndicator(i,currentIndex),
                    ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsetsDirectional.only(
                      start: AppPadding.p12,
                    ),
                    onPressed: onRightArrowButton,
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: ColorsManager.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _skipButton() {}

  Widget getCircleIndicator(int index, int currentIndex) {
    if (index == currentIndex) {
      return const CircleIndicator(isSelected: false);
    } else {
      return const CircleIndicator(isSelected: true);
    }
  }

  void onLeftArrowButton() {
    setState((){
      _pageController.animateToPage(_viewModel.getPreviousIndex(), duration: const Duration(milliseconds: AppConstants.sliderTime), curve: Curves.linear);

    });
  }

  void onRightArrowButton() {
    setState((){
      _pageController.animateToPage(_viewModel.getNextIndex(), duration: const Duration(milliseconds: AppConstants.sliderTime), curve: Curves.linear);
    });
  }


}
