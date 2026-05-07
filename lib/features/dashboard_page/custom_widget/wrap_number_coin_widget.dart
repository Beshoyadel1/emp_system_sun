import 'package:flutter/cupertino.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class WrapNumberCoinWidget extends StatelessWidget {
  final String numberText, imageSrc;
  final double sizeText;
  final WrapAlignment? runAlignment;
  final Color? textColor, imageColor;

  const WrapNumberCoinWidget({
    super.key,
    required this.numberText,
    required this.sizeText,
    required this.imageSrc,
    this.runAlignment,
    this.textColor,
    this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 60),
          child: TextInAppWidget(
            text: numberText,
            textSize: sizeText,
            fontWeightIndex: FontSelectionData.mediumFontFamily,
            textColor: textColor ?? AppColors.orangeColor,
            maxLines: 1,
          ),
        ),

        SizedBox(
          width: 16,
          height: 16,
          child: Image.asset(
            imageSrc,
            color: imageColor ?? AppColors.orangeColor,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}