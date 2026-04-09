import 'package:flutter/cupertino.dart';
import '../../../../../features/internal_services/internal_orders/custom_widget/container_of_column_request_status_widget.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/theming/text_styles.dart';

class RowListNotificationDesignDashboardWidget extends StatelessWidget {
  final String imagePath, textOrange, textBlack, numberRequest;
  final bool? isAccept, isReject, isNewOrder;

  const RowListNotificationDesignDashboardWidget({
    super.key,
    this.isAccept = false,
    this.isReject = false,
    this.isNewOrder = false,
    required this.imagePath,
    required this.textBlack,
    required this.textOrange,
    required this.numberRequest,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              Image.asset(imagePath, width: 35),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInAppWidget(
                      text: textOrange,
                      textSize: 12,
                      fontWeightIndex: FontSelectionData.regularFontFamily,
                      textColor: AppColors.orangeColor,
                    ),
                    TextInAppWidget(
                      text: textBlack,
                      textSize: 12,
                      fontWeightIndex: FontSelectionData.regularFontFamily,
                      textColor: AppColors.blackColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextInAppWidget(
              text: numberRequest,
              textSize: 12,
              fontWeightIndex: FontSelectionData.regularFontFamily,
              textColor: AppColors.blackColor,
            ),
            ContainerOfColumnRequestStatusWidget(
              isNewOrder: isNewOrder,
              isAccept: isAccept,
              isReject: isReject,
            ),
          ],
        ),
      ],
    );
  }
}
