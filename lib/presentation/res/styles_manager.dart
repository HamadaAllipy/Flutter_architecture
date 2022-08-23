import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/res/fonts_manager.dart';

_getTextStyle({
  required FontWeight fontWeight,
  required double fontSize,
  required Color color,
}) {
  return TextStyle(
    fontWeight: fontWeight,
    fontFamily: FontsFamilies.montserrat,
    fontSize: fontSize,
    color: color,
  );
}

// regular

TextStyle getRegular({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontWeight: FontWeightManager.regular,
    fontSize: fontSize,
    color: color,
  );
}


// medium
TextStyle getMediumStyle({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontWeight: FontWeightManager.medium,
    fontSize: fontSize,
    color: color,
  );
}


// semiBold
TextStyle getSemiBold({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontWeight: FontWeightManager.semiBold,
    fontSize: fontSize,
    color: color,
  );
}
