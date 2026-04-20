import 'package:flutter/material.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';

class TitleWithSubTitleInOrderDetailsEmp extends StatelessWidget {
  const TitleWithSubTitleInOrderDetailsEmp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TextInAppWidget(
        //   text:'تفاصيل الطلب رقم #452',
        //   textSize: 18,
        //   fontWeightIndex: FontSelectionData.semiBoldFontFamily,
        //   textColor:AppColors.blackColor,
        // ),
        TextInAppWidget(
          text:AppLanguageKeys.viewAllOrderDetails,
          textSize: 17,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor:AppColors.blackColor44,
        ),
      ],
    );
  }
}
