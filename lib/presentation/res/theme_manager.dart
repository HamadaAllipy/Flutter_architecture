import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/res/colors_manager.dart';
import 'package:flutter_architecture/presentation/res/fonts_manager.dart';
import 'package:flutter_architecture/presentation/res/styles_manager.dart';

ThemeData getLightTheme() {
  return ThemeData(
    textTheme: TextTheme(
      // headline large
      headlineLarge: getSemiBoldStyle(
        color: ColorsManager.darkGray,
        fontSize: FontSizes.s16,
      ),
      // headline medium
      headlineMedium: getRegularStyle(
        color: ColorsManager.darkGray,
        fontSize: FontSizes.s14,
      ),
      // label medium
      labelMedium: getMediumStyle(
        color: ColorsManager.primary,
        fontSize: FontSizes.s14,
      ),
      // label medium
      labelSmall: getRegularStyle(
        color: ColorsManager.primary,
        fontSize: FontSizes.s12,
      ),
    ),
  );
}
