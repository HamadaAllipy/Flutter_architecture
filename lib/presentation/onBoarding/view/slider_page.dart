import 'package:flutter/material.dart';
import 'package:flutter_architecture/domain/models.dart';
import 'package:flutter_architecture/presentation/res/res.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliderPage extends StatelessWidget {
  final SliderObject sliderObject;
  const SliderPage({Key? key, required this.sliderObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          sliderObject.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(
          height: AppSize.s7,
        ),
        Text(
          sliderObject.supTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: AppSize.s35,
        ),
        SvgPicture.asset(sliderObject.image),
      ],
    );
  }
}
