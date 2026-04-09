import 'package:flutter/material.dart';

import '../../../core/theming/fonts.dart';

String? fontSelection() {
  return AppFonts.readexProFontFamily;
}

FontWeight? fontWeightSelection({int? fontWeightIndex}) {
  if (fontWeightIndex == FontSelectionData.boldFontFamily) {
    return FontWeight.w700;
  } else if (fontWeightIndex == FontSelectionData.semiBoldFontFamily) {
    return FontWeight.w600;
  } else if (fontWeightIndex == FontSelectionData.mediumFontFamily) {
    return FontWeight.w500;
  } else if (fontWeightIndex == FontSelectionData.regularFontFamily) {
    return FontWeight.w400;
  }

  return null;
}
