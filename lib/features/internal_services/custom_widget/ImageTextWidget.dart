import 'dart:typed_data';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/core/theming/colors.dart';
import 'package:emp_system_sun/core/theming/fonts.dart';
import 'package:emp_system_sun/core/theming/text_styles.dart';
import 'package:flutter/material.dart';


class ImageTextWidget extends StatelessWidget {
  final Uint8List? image;
  final String? text;

  const ImageTextWidget({
    super.key,
     this.text,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 🔥 Image or Icon
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100,
          ),
          child: image != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(
              image!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return _buildIcon();
              },
            ),
          )
              : _buildIcon(),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: TextInAppWidget(
            text: text?? AppLanguageKeys.carModel,
            textSize: 12,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.blackColor,
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    return const Icon(
      Icons.directions_car,
      color:  Colors.grey,
      size: 20,
    );
  }
}