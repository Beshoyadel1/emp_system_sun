import 'package:flutter/cupertino.dart';
import '../../../../../core/theming/colors.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';

class ContainerWhiteImageTextWidget extends StatelessWidget {
  final String imagePath, text;

  const ContainerWhiteImageTextWidget({
    super.key,
    required this.text,
    required this.imagePath
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        spacing: 5,
        children: [
          Image.asset(imagePath, width: 50,),
          TextInAppWidget(
            text: text,
            textSize: 13,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.blackColor,
          ),
        ],
      ),
    );
  }
}
