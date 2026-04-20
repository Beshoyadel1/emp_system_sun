import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../features/order_status_design/calling_in_service_request/ui/screens/container_call_in_data_calling_design.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';

class ContainerContactWithCustomerOrderDetailsCancelOrderEmp extends StatelessWidget {
  const ContainerContactWithCustomerOrderDetailsCancelOrderEmp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
            color: AppColors.greyColor.withOpacity(0.3)
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextInAppWidget(
            text:AppLanguageKeys.contactCustomer,
            textSize: 14,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor:AppColors.greyColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  Image.asset(AppImageKeys.person22),
                  const TextInAppWidget(
                    text:AppLanguageKeys.contactCustomer,
                    textSize: 14,
                    fontWeightIndex: FontSelectionData.regularFontFamily,
                    textColor:AppColors.blackColor,
                  ),

                ],
              ),
              const Row(
                spacing: 15,
                children: [
                  ContainerCallInDataCallingDesign(
                    imagePath: AppImageKeys.call_contact,
                    width: 40,
                  ),
                  ContainerCallInDataCallingDesign(
                    imagePath: AppImageKeys.message_contact,
                    width: 40,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
