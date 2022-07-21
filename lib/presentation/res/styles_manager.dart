// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:flutter_architecture/presentation/res/fonts_manager.dart';

TextStyle _getTextStyle({
  required Color color,
  required FontWeight fontWeight,
  required double fontSize,
}) {
  return TextStyle(
    color: color,
    fontWeight: fontWeight,
    fontFamily: FontFamilies.montserrat,
    fontSize: fontSize,
  );
}

// light
getLightStyle({
  required Color color,
  required double fontSize,
}) {
  return _getTextStyle(
    color: color,
    fontWeight: FontsWeightsManager.light,
    fontSize: fontSize,
  );
}

// regular
getRegularStyle({
  required Color color,
  required double fontSize,
}) {
  return _getTextStyle(
    color: color,
    fontWeight: FontsWeightsManager.regular,
    fontSize: fontSize,
  );
}

// medium
getMediumStyle({
  required Color color,
  required double fontSize,
}) {
  return _getTextStyle(
    color: color,
    fontWeight: FontsWeightsManager.medium,
    fontSize: fontSize,
  );
}

// SemiBold
getSemiBoldStyle({
  required Color color,
  required double fontSize,
}) {
  return _getTextStyle(
    color: color,
    fontWeight: FontsWeightsManager.semiBold,
    fontSize: fontSize,
  );
}

// Bold
getBoldStyle({
  required Color color,
  required double fontSize,
}) {
  return _getTextStyle(
    color: color,
    fontWeight: FontsWeightsManager.bold,
    fontSize: fontSize,
  );
}
