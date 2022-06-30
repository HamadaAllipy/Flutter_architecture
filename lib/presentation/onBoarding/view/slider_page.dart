import 'package:flutter/material.dart';
import 'package:flutter_architecture/domain/models.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
