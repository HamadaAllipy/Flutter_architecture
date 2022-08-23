import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/on_boarding/view/slider_view.dart';
import 'package:flutter_architecture/presentation/on_boarding/viewModel/on_boarding_view_model.dart';
import 'package:flutter_architecture/presentation/res/Strings_manager.dart';
import 'package:flutter_architecture/presentation/res/assets_manager.dart';
import 'package:flutter_architecture/presentation/res/colors_manager.dart';
import 'package:flutter_architecture/presentation/res/constants_manager.dart';
import 'package:flutter_architecture/presentation/res/route_manager.dart';
import 'package:flutter_architecture/presentation/res/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final PageController _pageController = PageController(initialPage: ConstantsManager.initialPageOnBoarding);

  @override
  void initState() {
    bind();
    super.initState();
  }

  void bind(){
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSlider,
      builder: (context, snapshot){
        return _getContentView(snapshot.data);
      },
    );
  }

  Widget _getContentView(SliderViewObject? sliderViewObject) {
    if(sliderViewObject == null){
      return const Scaffold();
    }
    else{
      return _getBodyWidget(sliderViewObject);
    }
  }



  Widget _getBodyWidget(SliderViewObject sliderViewObject){
    return Scaffold(
      appBar: AppBar(),
      body: PageView.builder(
        itemCount: sliderViewObject.slidersLength,
        controller: _pageController,
        onPageChanged: (value){
          _viewModel.onPageChanged(value);
        },
        itemBuilder: (_, index) {
          return SliderView(sliderObject: sliderViewObject.sliderObject);
        },
      ),
      bottomNavigationBar: _getBottomWidget(sliderViewObject.slidersLength,sliderViewObject.currentIndex),
    );
  }


  Widget _getBottomWidget(int sliderLength,int currentIndex){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
          },
          child: const Text(StringsManager.skip),
        ),
        Container(
          color: ColorsManager.primary,
          height: AppSizes.s60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  _movePage(_viewModel.getPreviousIndex());
                },
                icon: SvgPicture.asset(
                  IconsManager.leftArrow,
                ),
              ),
              Row(
                children: [
                  for(int i = 0 ; i < sliderLength; i++)...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: getIndicator(currentIndex,i),
                    ),
                  ],
                ],
              ),
              IconButton(
                onPressed: () {
                  _movePage(_viewModel.getNextIndex());
                },
                icon: SvgPicture.asset(
                  IconsManager.rightArrow,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getIndicator(int currentIndex , int i){
    if(currentIndex == i){
      return SvgPicture.asset(IconsManager.solidCircle);
    }
    else{
      return SvgPicture.asset(IconsManager.hollowCircle);
    }

  }

  void _movePage(int pageNumber) {
    _pageController.animateToPage(
      pageNumber,
      duration: const Duration(milliseconds: ConstantsManager.onBoardingPeriod),
      curve: Curves.linear,
    );
  }
}
