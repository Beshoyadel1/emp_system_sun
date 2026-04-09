import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../features/order_status_design/order_details_new_order_emp/sub/dialog_reject_order/screens/first_part_of_data_dialog_reject_order.dart';
import '../../../../../../../features/order_status_design/order_details_new_order_emp/sub/dialog_reject_order/screens/last_two_button_in_dialog_reject_order.dart';
import '../../../../../../../features/permissions/custom_widget/text_with_text_form_field_as_column_widget.dart';
import '../../../../../../../core/theming/colors.dart';

class DialogRejectOrder extends StatelessWidget {
  const DialogRejectOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: 400,
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 20,
            children: [
              const FirstPartOfDataDialogRejectOrder(),
              TextWithTextFormFieldAsColumnWidget(
                  text: AppLanguageKeys.rejectionReason,
                  hint: '',
                  maxLines: 5,
              ),
              const LastTwoButtonInDialogRejectOrder(),
            ],
          ),
        ),
      ),
    );
  }
}