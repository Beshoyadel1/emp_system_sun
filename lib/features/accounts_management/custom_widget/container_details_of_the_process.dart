import '../../../../core/language/language_constant.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/fonts.dart';
import '../../../../core/theming/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ContainerDetailsOfTheProcess extends StatelessWidget {
  final String? title;
  final int status;
  final Color? backGroundColor, textColor, borderColor;
  final IconData? icon;
  final void Function()? onTap;
  const ContainerDetailsOfTheProcess({
    super.key,
    required this.status,
    this.title,
    this.textColor,
    this.borderColor,
    this.backGroundColor,
    this.icon,
    this.onTap
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: (backGroundColor ?? AppColors.orangeColor),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: (borderColor ?? AppColors.orangeColor),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkColor.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Wrap(
          spacing: 10,
         // mainAxisAlignment: MainAxisAlignment.center,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(icon??Icons.file_copy,color: AppColors.whiteColor,size: 12,),
            TextInAppWidget(
              text: title ?? AppLanguageKeys.transactionDetails,
              textSize: 14,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor: (textColor ?? AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
