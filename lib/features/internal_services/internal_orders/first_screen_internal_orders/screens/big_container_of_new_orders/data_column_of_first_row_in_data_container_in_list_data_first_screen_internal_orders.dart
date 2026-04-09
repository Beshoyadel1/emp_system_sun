import 'package:flutter/cupertino.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class DataColumnOfFirstRowInDataContainerInListDataFirstScreenInternalOrders
    extends StatelessWidget {
  const DataColumnOfFirstRowInDataContainerInListDataFirstScreenInternalOrders(
      {super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInAppWidget(
            text: AppLanguageKeys.newRequests,
            textSize: 15,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.blackColor,
          ),
          TextInAppWidget(
            text: AppLanguageKeys.newRequestsList,
            textSize: 13,
            fontWeightIndex: FontSelectionData.mediumFontFamily,
            textColor: AppColors.greyColor,
          )
        ],
      ),
    );
  }
}
