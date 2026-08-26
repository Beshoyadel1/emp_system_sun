import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';

class ButtonWithTextIcon extends StatelessWidget {
  final String? text;
  final IconData? iconData;
  const ButtonWithTextIcon({super.key,this.text,this.iconData});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isSelected: false,
      containerColor: AppColors.blackColor,
      borderRadius: BorderRadius.circular(15),
      onTap: () {},
      typeWidget: Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Icon(
            iconData??Icons.download,
            color: AppColors.whiteColor,
            size: 24,
          ),
          TextInAppWidget(
            text: text??'sss',
            textSize: 15,
            textColor: AppColors.whiteColor,
            fontWeightIndex: FontSelectionData.semiBoldFontFamily,
            isTextCenter: true,
          ),
        ],
      ),
    );
  }
}
