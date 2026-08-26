import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../../features/order_status_design/presentation/pages/calling_in_service_request/ui/screens/container_call_in_data_calling_design.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/assets.dart';
import '../../../../../../../core/theming/colors.dart';

class ContainerContactWithCustomerOrderDetailsWidget extends StatelessWidget {
  final String? nameCustomer;
  final Uint8List? imageUser;

  const ContainerContactWithCustomerOrderDetailsWidget(
      {super.key, this.imageUser, this.nameCustomer});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {},
      isSelected: true,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.orangeColor.withOpacity(0.4)),
      typeWidget: Column(
        spacing: 10,
        children: [
          const TextInAppWidget(
            text: AppLanguageKeys.contactCustomer,
            textSize: 15,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.blackColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 10,
                children: [
                  imageUser != null
                      ? CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    backgroundImage: MemoryImage(imageUser!),
                  )
                      : const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    backgroundImage: const AssetImage(AppImageKeys.person22),
                  ),
                  TextInAppWidget(
                    text: nameCustomer ?? "user",
                    textSize: 14,
                    fontWeightIndex: FontSelectionData.regularFontFamily,
                    textColor: AppColors.blackColor,
                  ),
                ],
              ),
              const Row(
                spacing: 15,
                children: [
                  ContainerCallInDataCallingDesign(
                    icon: Icons.call,
                    width: 40,
                  ),
                  ContainerCallInDataCallingDesign(
                    icon: Icons.message_outlined,
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
