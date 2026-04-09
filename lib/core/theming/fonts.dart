import 'package:flutter/cupertino.dart';

class AppFonts {
  static const String readexProFontFamily = 'ReadexPro';
}

class FontSelectionData {
  static const int boldFontFamily = 1;
  static const int semiBoldFontFamily = 2;
  static const int mediumFontFamily = 3;
  static const int regularFontFamily = 4;
}

String fontSelection() {
  return AppFonts.readexProFontFamily;
}

FontWeight fontWeightSelection({int? fontWeightIndex}) {
  switch (fontWeightIndex) {
    case FontSelectionData.boldFontFamily:
      return FontWeight.bold;
    case FontSelectionData.semiBoldFontFamily:
      return FontWeight.w600;
    case FontSelectionData.mediumFontFamily:
      return FontWeight.w500;
    case FontSelectionData.regularFontFamily:
    default:
      return FontWeight.normal;
  }
}
