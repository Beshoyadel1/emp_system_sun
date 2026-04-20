
import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';

class CarModel extends StatelessWidget {
  final String? releaseDate, addresstext;
  final Uint8List? imageBytes;

  const CarModel({
    super.key,
    this.releaseDate,
    this.addresstext,
    this.imageBytes,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: [
        imageBytes != null
            ? Image.memory(
          imageBytes!,
          width: 65,
          height: 40,
          fit: BoxFit.contain,
        )
            : Image.asset(
          AppImageKeys.carHaraj,
          width: 65,
          height: 40,
          fit: BoxFit.contain,
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInAppWidget(
              text: releaseDate ?? '2025',
              textSize: 14,
              textColor: AppColors.orangeColor,
            ),
            TextInAppWidget(
              text: addresstext ?? 'BYD Electric',
              textSize: 14,
              textColor: AppColors.darkColor,
            ),
          ],
        )
      ],
    );
  }
}