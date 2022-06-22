import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/res/res.dart';

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
