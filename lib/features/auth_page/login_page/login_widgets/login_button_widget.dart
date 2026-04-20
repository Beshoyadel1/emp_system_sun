import 'package:flutter/material.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/text_styles.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,

      child: Container(
        width: 500,
        height: 50,
        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: AppColors.orangeColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkColor.withAlpha(40),
              blurRadius: 22,
              offset: const Offset(0, 16),
            ),
          ],
        ),

        child: isLoading
            ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : TextInAppWidget(
          text: text,
          textSize: 17,
          textColor: AppColors.whiteColor,
          fontWeightIndex: FontSelectionData.boldFontFamily,
        ),
      ),
    );
  }
}
