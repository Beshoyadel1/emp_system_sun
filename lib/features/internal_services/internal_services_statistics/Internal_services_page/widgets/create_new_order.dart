import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/internal_services/internal_services_statistics/Internal_services_page/model/new_order_steps_model/new_order_steps_model.dart';
import '../../../../../core/cubit/new_orders_cubit/new_orders_cubit.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import 'details_order.dart';
import 'payment_widget.dart';

class CreateNewOrder extends StatelessWidget {
  const CreateNewOrder(
      {super.key,
      this.textButton,
      this.isProcessingRequest,
      this.isWaitingPayment});

  final String? textButton;
  final bool? isProcessingRequest;
  final bool? isWaitingPayment;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailsOrder(isProcessingRequest: isProcessingRequest),
        isWaitingPayment == true
            ? const PaymentWidget()
            : CustomContainer(
                isSelected: false,
                onTap: () {
                  final cubit = context.read<NewOrdersCubit>();
                  if (cubit.selectedIndex < steps.length - 1) {
                    cubit.selectTab(cubit.selectedIndex + 1);
                  }
                },
                containerHeight: 40,
                containerWidth: 140,
                border: const Border(),
                borderRadius: BorderRadius.circular(20),
                containerColor: AppColors.orangeColor,
                typeWidget: Center(
                  child: TextInAppWidget(
                    text: textButton ?? AppLanguageKeys.executeOrderKey,
                    textSize: 14,
                    textColor: AppColors.whiteColor,
                  ),
                ),
              )
      ],
    );
  }
}
