import 'package:flutter/cupertino.dart';
import '../../../../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../../features/internal_services/internal_orders/custom_widget/select_time_profit_service_widget.dart';

class FirstRowInDataInContainerProfitsFromMinistryOfInteriorServices
    extends StatelessWidget {
  const FirstRowInDataInContainerProfitsFromMinistryOfInteriorServices(
      {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    bool isTabletCustom = size.width > ValuesOfAllApp.mobileWidth &&
        size.width <= ValuesOfAllApp.customTabWidth;
    bool isTab = size.width > ValuesOfAllApp.tabWidth;
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Expanded(
          child: TextInAppWidget(
            text: AppLanguageKeys.internalServicesStats,
            textSize: 15,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.blackColor,
          ),
        ),
        // SelectTimeProfitServiceWidget(
        //   hint: AppLanguageKeys.selectTime,
        //   options: [
        //     AppLanguageKeys.daily,
        //     AppLanguageKeys.weekly,
        //     AppLanguageKeys.monthly,
        //   ],
        // )
      ],
    );
  }
}
