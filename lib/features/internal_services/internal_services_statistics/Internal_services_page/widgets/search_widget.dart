import 'package:flutter/material.dart';
import '../../../../../features/store_page/store_widgets/car_model_widget/widgets/select_date_widget.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        spacing: 15,
        runSpacing: 5,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          Wrap(
            spacing: 15,
            runSpacing: 5,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              const SelectDateWidget(),
              CustomContainer(
                containerHeight: 35,
                containerWidth: 131,
                isSelected: true,
                onTap: () {},
                containerColor: AppColors.darkGreyColor,
                padding: EdgeInsets.zero,
                border: const Border(),
                typeWidget: const Center(
                  child: TextInAppWidget(
                    text: AppLanguageKeys.searchKey,
                    textSize: 16,
                    textColor: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
          CustomContainer(
            containerHeight: 35,
            containerWidth: 107,
            isSelected: true,
            onTap: () {},
            containerColor: AppColors.lightGreyColor,
            padding: EdgeInsets.zero,
            border: const Border(),
            typeWidget: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImageKeys.filter,
                    height: 24,
                    width: 24,
                  ),
                  const TextInAppWidget(
                    text: AppLanguageKeys.filterKey,
                    textSize: 16,
                    textColor: AppColors.darkColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
