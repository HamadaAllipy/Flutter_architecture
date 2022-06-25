import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late PageController _pageController;
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  indicatorWidget(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
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

  Widget indicatorWidget(){
    return SvgPicture.asset(
      IconsManager.circleSolid,
      width: AppSize.s12,
      height: AppSize.s12,
    );
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
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
