// ignore_for_file: constant_identifier_names

import 'package:drag_drop_editor_poc/utils/custom_colors.dart';
import 'package:flutter/material.dart';

enum FontFamily {
  MONOSPACE,
  SLAB,
  SCRIPT,
  SANS_SERIF,
  SERIF,
  DISPLAY,
}

// enum FontWeight {
//   FONTWEIGHT_100,
//   FONTWEIGHT_200,
//   FONTWEIGHT_300,
//   FONTWEIGHT_500,
//   FONTWEIGHT_800,
//   FONTWEIGHT_900,
// }

enum TextFontStyle {
  REGULAR,
  BOLD,
  ITALIC,
  UNDERLINE,
  LINETHROUGH,
}

enum TextAlignment {
  LEFT,
  RIGHT,
  CENTER,
  JUSTIFY,
}

Color getTextColorForBackground(Color backgroundColor) {
  if (ThemeData.estimateBrightnessForColor(backgroundColor) ==
      Brightness.dark) {
    return Colors.white;
  }

  return Colors.black;
}

const backgroundFillColorArray = [
  CustomColors.bluishPurple,
  CustomColors.turquoiseCyan,
  CustomColors.lightMustard,
  CustomColors.violetPink,
  CustomColors.darkSlateGrey,
  CustomColors.salmonPink,
  CustomColors.darkSkyBlue,
  CustomColors.persianGreen,
  CustomColors.regentGrey,
  CustomColors.sandBrown,
];
