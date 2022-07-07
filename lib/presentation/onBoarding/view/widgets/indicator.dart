part of '../on_boarding_view.dart';

class CircleIndicator extends StatelessWidget {
  final bool isSelected;

  const CircleIndicator({Key? key, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (isSelected) {
      widget = SvgPicture.asset(
        IconsManager.circleHollow,
        height: AppSize.s9,
        width: AppSize.s9,
        color: ColorsManager.white,
      );
    } else {
      widget = SvgPicture.asset(
        IconsManager.circleSolid,
        height: AppSize.s9,
        width: AppSize.s9,
        color: ColorsManager.white,
      );
    }

    return widget;
  }
}
