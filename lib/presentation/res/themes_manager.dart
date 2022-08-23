import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/presentation/res/colors_manager.dart';
import 'package:flutter_architecture/presentation/res/fonts_manager.dart';
import 'package:flutter_architecture/presentation/res/styles_manager.dart';
import 'package:flutter_architecture/presentation/res/values_manager.dart';

ThemeData getLightTheme() {
  return ThemeData(
    // app bar
    scaffoldBackgroundColor: ColorsManager.white,
    appBarTheme: const AppBarTheme(
      elevation: AppSizes.s0,
      color: ColorsManager.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: ColorsManager.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),

    /// text theme
    // semi bold
    textTheme: TextTheme(
        headlineMedium:
            getSemiBold(fontSize: FontSizes.s16, color: ColorsManager.darkGrey),
        // regular
        headlineSmall:
            getRegular(fontSize: FontSizes.s14, color: ColorsManager.darkGrey),
        // medium
        labelMedium:
            getMediumStyle(fontSize: FontSizes.s16, color: ColorsManager.primary)),


    // buttons
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: ColorsManager.primary,
        textStyle: getMediumStyle(fontSize: FontSizes.s16, color: ColorsManager.primary),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ColorsManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s12),
        ),
        textStyle: getRegular(fontSize: FontSizes.s16, color: ColorsManager.white),
      ),
    ),

    // text form field
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: getRegular(fontSize: FontSizes.s16, color: ColorsManager.grey),
      labelStyle: getRegular(fontSize: FontSizes.s16, color: ColorsManager.primary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.s12),
        borderSide: const BorderSide(color: ColorsManager.primary)
      ),
    ),

  );
}
