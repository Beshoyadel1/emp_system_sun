import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../features/order_status_design/presentation/custom_widget/design_view_other_service_widget.dart';
import '../../../../../../../../features/order_status_design/presentation/custom_widget/design_view_type_service_widget.dart';

class ViewListDataOrderWidget extends StatelessWidget {
  final String? totalPrice,date,appointment;
  final List<String>? serviceTypes;
  const ViewListDataOrderWidget({super.key,this.serviceTypes,this.totalPrice,this.appointment,this.date});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int count = 4;

        if (constraints.maxWidth < 500) {
          count = 1;
        } else if (constraints.maxWidth < 700) {
          count = 2;
        } else if (constraints.maxWidth < 1000) {
          count = 3;
        }

        final width = (constraints.maxWidth - ((count - 1) * 10)) / count;

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            SizedBox(
              width: width,
              child:  DesignViewTypeServiceWidget(
                serviceTypes: serviceTypes??[
                ],
              )
            ),
            SizedBox(
              width: width,
              child:  DesignViewOtherServiceWidget(
                title: AppLanguageKeys.servicePrice,
                iconData: Icons.payments_outlined,
                subTitle: totalPrice??"1910",
                subTitleColor: AppColors.orangeColor,
                isMoney: true,
              ),
            ),
            SizedBox(
              width: width,
              child:  DesignViewOtherServiceWidget(
                title: AppLanguageKeys.orderDate,
                iconData: Icons.calendar_month_outlined,
                iconDataColor: AppColors.blueColor,
                iconDataBackGroundColor: AppColors.lightGreenColor,
                subTitle: date??"3/11/2000",
              ),
            ),
            SizedBox(
              width: width,
              child:  DesignViewOtherServiceWidget(
                title: AppLanguageKeys.expectedDeliveryDate,
                iconData: Icons.access_time,
                iconDataColor: AppColors.greenColor,
                iconDataBackGroundColor: const Color(0xffe8f5e9),
                subTitle:appointment?? "3/11/2000",
              ),
            ),
          ],
        );
      },
    );
  }
}