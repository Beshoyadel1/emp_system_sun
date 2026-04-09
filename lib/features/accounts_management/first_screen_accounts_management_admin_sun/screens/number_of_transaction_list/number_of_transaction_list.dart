import 'package:flutter/cupertino.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../features/accounts_management/custom_widget/container_details_of_the_process.dart';
import '../../../../../features/accounts_management/custom_widget/title_with_sub_title.dart';
import '../../../../../features/accounts_management/details_accounts_management_admin_sun/details_accounts_management_admin_sun.dart';
import '../../../../../features/internal_services/internal_orders/custom_widget/text_with_container_status.dart';

class NumberOfTransactionList extends StatelessWidget {
  const NumberOfTransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> items = List.generate(5, (index) => index);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        const TextInAppWidget(
          text: AppLanguageKeys.payBill,
          textSize: 18,
          fontWeightIndex: FontSelectionData.semiBoldFontFamily,
          textColor: AppColors.blackColor,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: AppColors.greyColor.withOpacity(0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkColor.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              return CustomContainer(
                isSelected: false,
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                typeWidget: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    const TitleWithSubTitle(
                      title: AppLanguageKeys.transactionNumber,
                      textSizeTitle: 13,
                      titleColor: AppColors.greyColor,
                      subTitle: '#66555555',
                      textSizeSubTitle: 12,
                    ),
                    const TitleWithSubTitle(
                      title: AppLanguageKeys.total,
                      textSizeTitle: 13,
                      titleColor: AppColors.greyColor,
                      subTitle: '250.00',
                      textSizeSubTitle: 12,
                    ),
                    const TitleWithSubTitle(
                      title: AppLanguageKeys.invoiceDate,
                      textSizeTitle: 13,
                      titleColor: AppColors.greyColor,
                      subTitle: '1/1/2025',
                      textSizeSubTitle: 12,
                    ),
                    const TextWithContainerStatus(
                      text: AppLanguageKeys.orderStatusKey,
                      status: OrderStatus.orderCompleted,
                    ),
                    ContainerDetailsOfTheProcess(
                      status: 5,
                      onTap: () {
                        Navigator.push(
                          context,
                          NavigateToPageWidget(
                              const DetailsAccountsManagementAdminSun()
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
