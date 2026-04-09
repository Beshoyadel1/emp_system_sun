import 'package:flutter/cupertino.dart';
import '../../../../../../../../features/order_status_design/custom_widget/time_line_tile_widget.dart';
import '../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';

class DataTimeLineTileOrderDetailsOrderReceivedEmp extends StatelessWidget{
  const DataTimeLineTileOrderDetailsOrderReceivedEmp({super.key});

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
      child: const Column(
        children: [
          TimeLineTileWidget(
            isFirst: true,
            isIcon: true,
            title: AppLanguageKeys.createNewOrderKey,
          ),
          TimeLineTileWidget(
            isIcon: true,
            title: AppLanguageKeys.orderInProgress,
          ),
          TimeLineTileWidget(
            isIcon: true,
            title: AppLanguageKeys.waitingForInvoicePayment,
          ),
          TimeLineTileWidget(
            isLast: true,
            isIcon: true,
            title: AppLanguageKeys.orderArrived,
          ),
        ],
      ),
    );
  }
}
