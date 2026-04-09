import 'package:flutter/cupertino.dart';
import '../../../../../features/internal_services/internal_orders/custom_widget/select_time_profit_service_widget.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';

class ColumnTextWithSelectTimeInNotificationWidget extends StatelessWidget {
  final String text;

  const ColumnTextWithSelectTimeInNotificationWidget(
      {super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextInAppWidget(
          text: AppLanguageKeys.searchFrom,
          textSize: 13,
          fontWeightIndex: FontSelectionData.regularFontFamily,
          textColor: AppColors.blackColor,
        ),
         SelectTimeProfitServiceWidget(
          hint: '00/00/0000',
          isTime: true,
          backGroundColor: AppColors.whiteColor,
          textColor: AppColors.greyColor,
          borderColor: AppColors.greyColor,
          width: 250,
        ),
      ],
    );
  }
}
