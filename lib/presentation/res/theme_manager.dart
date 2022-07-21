import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/res/res.dart';

ThemeData getLightTheme() {
  return ThemeData(

    appBarTheme: const AppBarTheme(
      backgroundColor: ColorsManager.white,
      elevation: AppSize.s0,
    ),
    scaffoldBackgroundColor: ColorsManager.white,
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
        fontSize: FontSizes.s16,
      ),
      // label small
      labelSmall: getRegularStyle(
        color: ColorsManager.primary,
        fontSize: FontSizes.s12,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ColorsManager.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: ColorsManager.primary,
      )
    ),
  );
}
