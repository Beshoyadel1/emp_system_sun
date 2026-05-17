import 'package:flutter/cupertino.dart';
import '../../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../../core/theming/text_styles.dart';

class FirstRowInDataInContainerMobileServicesOrdersStatistics
    extends StatelessWidget {
  const FirstRowInDataInContainerMobileServicesOrdersStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
         Expanded(
          child: TextInAppWidget(
            text: AppLanguageKeys.internalServicesProfit,
            textSize: 15,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.blackColor,
          ),
        ),
        // RowNumberCoinWidget(
        //     numberText: '450' ,
        //     sizeText: 15,
        //     imageSrc: AppImageKeys.coin
        // ),
      ],
    );
  }
}
