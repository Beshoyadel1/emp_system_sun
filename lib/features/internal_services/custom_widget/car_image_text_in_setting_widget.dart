import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class CarImageTextInSettingWidget extends StatefulWidget {
  final String text;
  final int modelId;
  final int brandId;
  final Uint8List? imageMemory;
  final TextEditingController controller;

  const CarImageTextInSettingWidget({
    super.key,
    required this.text,
    required this.modelId,
    required this.brandId,
    required this.controller,
    this.imageMemory,
  });

  @override
  State<CarImageTextInSettingWidget> createState() =>
      _CarImageTextInSettingWidgetState();
}

class _CarImageTextInSettingWidgetState
    extends State<CarImageTextInSettingWidget> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(),
            const SizedBox(height: 2),
            TextInAppWidget(
              text: widget.text,
              textSize: 9,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor: AppColors.darkColor,
            ),
          ],
        ),

        const SizedBox(width: 8),

        Expanded(
          child: SizedBox(
            height: 50,
            child: TextFormFieldWidget(
              hintText: AppLanguageKeys.sar,
              textFormController: widget.controller,
              fillColor: AppColors.transparent,
              borderColor: AppColors.darkColor.withOpacity(0.2),
              hintTextSize: 12,
              hintTextColor: AppColors.orangeColor,
              textSize: 15,
              isDigit: true,

              /// ✅ VALIDATION
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLanguageKeys.addAllRequiredFieldsKey;
                }

                if (double.tryParse(value) == null) {
                  return "Enter valid number";
                }

                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (widget.imageMemory != null && widget.imageMemory!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.memory(
          widget.imageMemory!,
          width: 50,
          height: 30,
          fit: BoxFit.cover,
        ),
      );
    }

    return const Icon(Icons.directions_car, size: 28, color: Colors.grey);
  }
}
