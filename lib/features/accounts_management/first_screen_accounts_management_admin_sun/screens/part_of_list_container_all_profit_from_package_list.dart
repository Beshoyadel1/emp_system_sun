import 'package:flutter/cupertino.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../features/accounts_management/custom_widget/design_container_image_with_two_text_widget.dart';
import '../../../../../features/accounts_management/custom_widget/design_container_text_with_image_or_icon.dart';
import '../../../../../../core/theming/assets.dart';

class PartOfListContainerInFirstScreenAccountsManagementAdminSun extends StatelessWidget {
  const PartOfListContainerInFirstScreenAccountsManagementAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> items = List.generate(5, (index) => index);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        const TextInAppWidget(
          text:AppLanguageKeys.accountBalanceKey,
          textSize: 18,
          fontWeightIndex: FontSelectionData.semiBoldFontFamily,
          textColor:AppColors.blackColor,
        ),
        SizedBox(
          height: 120,
          child: ListView.separated(
            shrinkWrap: true,
            //physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return CustomContainer(
                isSelected: false,
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                typeWidget: const DesignContainerImageWithTwoTextWidget(
                  imagePath: AppImageKeys.account_sun2,
                  title: 'رصيد المدفوعات الالكترونية',
                  subTitle: '500',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
