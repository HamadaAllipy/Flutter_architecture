import 'package:flutter/material.dart';
import 'package:flutter_architecture/domain/models/models.dart';
import 'package:flutter_architecture/presentation/res/assets_manager.dart';
import 'package:flutter_architecture/presentation/res/colors_manager.dart';
import 'package:flutter_architecture/presentation/res/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliderView extends StatelessWidget {
  final SliderObject _sliderObject;

  const SliderView({
    Key? key,
    required SliderObject sliderObject,
  })  : _sliderObject = sliderObject,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSizes.s40,
        ),
        Text(
          _sliderObject.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: AppSizes.s20,
        ),
        Text(
          _sliderObject.supTitle,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: AppSizes.s60,
        ),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}
