import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/presentation/res/app_constants.dart';
import 'package:flutter_architecture/presentation/res/res.dart';
import 'package:flutter_architecture/presentation/screens.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _sliders = getSliders();
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

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

  @override
  Widget build(BuildContext context) {
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
          return SliderPage(slider: _sliders[index]);
        },
        itemCount: _sliders.length,
        onPageChanged: (value) {
          setState(() {
            _currentPage = value;
          });
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
                      for (int i = 0; i < _sliders.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: indicatorWidget(i),
                        ),
                    ],
                  ),
                  IconButton(
                    onPressed: _goNextPage,
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

  void _skipButton() {}

  void _goNextPage() {
    setState((){
      _pageController.animateToPage(getNextIndex(), duration: const Duration(milliseconds: AppConstants.sliderTime), curve: Curves.linear);

    });
  }

  void _goPreviousPage() {
    setState((){
      _pageController.animateToPage(getPreviousIndex(), duration: const Duration(milliseconds: AppConstants.sliderTime), curve: Curves.linear);
    });
  }

  int getNextIndex(){
    int nextIndex = ++_currentPage;
    if(_currentPage == _sliders.length){
      nextIndex = 0;
    }
    return nextIndex;
  }

  Widget indicatorWidget(int index) {
    if (index == _currentPage) {
      return SvgPicture.asset(
        IconsManager.circleSolid,
        width: AppSize.s12,
        height: AppSize.s12,
        color: ColorsManager.white,
      );
    }
    return SvgPicture.asset(
      IconsManager.circleHollow,
      width: AppSize.s12,
      height: AppSize.s12,
      color: ColorsManager.white,
    );
  }

  @override
  void initState() {

    super.initState();
  }

  int getPreviousIndex() {
    int previousIndex = --_currentPage;
    if(_currentPage == -1){
      previousIndex = _sliders.length - 1;
    }
    return previousIndex;
  }
}


class SliderPage extends StatelessWidget {
  final SliderObject slider;

  const SliderPage({Key? key, required this.slider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          slider.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          slider.supTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 50,
        ),
        SvgPicture.asset(slider.image),
      ],
    );
  }
}

class SliderObject {
  final String title;
  final String supTitle;
  final String image;

  SliderObject(this.title, this.supTitle, this.image);
}
