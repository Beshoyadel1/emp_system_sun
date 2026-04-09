import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/formate.dart';
import '../../../../../core/theming/text_styles.dart';

OverlayEntry? overlayEntry;

void showTooltipOverlay(
    BuildContext context, Offset globalPosition, LineBarSpot spot) {
  removeOverlay();
  final overlay = Overlay.of(context);
  if (overlay == null) return;

  const double tooltipWidth = 120;
  const double tooltipHeight = 56;
  final left = globalPosition.dx - (tooltipWidth / 2);
  final top = globalPosition.dy - tooltipHeight - 12;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      left: left.clamp(
          8.0, MediaQuery.of(context).size.width - tooltipWidth - 8.0),
      top: top.clamp(
          8.0, MediaQuery.of(context).size.height - tooltipHeight - 8.0),
      width: tooltipWidth,
      height: tooltipHeight,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: 66,
          width: 119,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 12,
                spreadRadius: 0.5,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextInAppWidget(
                  text:
                      '${spot.x.toInt() > 0 ? formatDateFromMilliseconds(spot.x.toInt()) : ''}',
                  textColor: AppColors.darkColor,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textSize: 14,
                ),
                const SizedBox(height: 4),
                TextInAppWidget(
                  text: '${spot.y.toInt()} ريال',
                  textColor: AppColors.seaBlueColor,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textSize: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry!);
}

void removeOverlay() {
  if (overlayEntry != null) {
    overlayEntry!.remove();
    overlayEntry = null;
  }
}

String formatDateFromMilliseconds(int ms) {
  final date = DateTime.fromMillisecondsSinceEpoch(ms);
  return '${date.day} ${getMonthName(date.month)}';
}
