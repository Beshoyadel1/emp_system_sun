import 'package:flutter/material.dart';
import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';

class ContainerStatus extends StatelessWidget {
  final int? status;
  final double? textSize;

  const ContainerStatus({
    super.key,
    this.status,
    this.textSize,
  });

  String get statusText {
    switch (status) {
      case OrderStatus.newOrderForCompany:
        return AppLanguageKeys.newOrderForCompany;

      case OrderStatus.rejectedByCompany:
        return AppLanguageKeys.rejectedByCompany;

      case OrderStatus.newOrderForProvider:
        return AppLanguageKeys.newOrderForProvider;

      case OrderStatus.waitingAppointment:
        return AppLanguageKeys.waitingAppointment;

      case OrderStatus.employeeInRoad:
        return AppLanguageKeys.employeeInRound;

      case OrderStatus.workInProgress:
        return AppLanguageKeys.workInProgress;

      case OrderStatus.orderCompleted:
        return AppLanguageKeys.orderCompleted;

      case OrderStatus.rejectedByProvider:
        return AppLanguageKeys.rejectedByProvider;

      case OrderStatus.cancelledByUser:
        return AppLanguageKeys.cancelledByUser;

      default:
        return 'Error Type';
    }
  }


  bool get isNewOrder =>
      status == OrderStatus.newOrderForCompany ||
          status == OrderStatus.newOrderForProvider;

  bool get isReject =>
      status == OrderStatus.rejectedByCompany ||
          status == OrderStatus.rejectedByProvider ||
          status == OrderStatus.cancelledByUser;

  bool get isWaitingForApproval =>
      status == OrderStatus.waitingAppointment;

  bool get isOnTheWay =>
      status == OrderStatus.employeeInRoad;

  bool get isAccept =>
      status == OrderStatus.orderCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding:
      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: isNewOrder
            ? AppColors.blackColor25
            : isReject
            ? AppColors.partPinkMixColor.withOpacity(0.1)
            : isAccept
            ? AppColors.partGreenMixColor.withOpacity(0.1)
            : isWaitingForApproval
            ? AppColors.yelloContainerLoadingColor
            .withOpacity(0.2)
            : isOnTheWay
            ? AppColors.lightGreenColor
            : AppColors.pinkColor,
        borderRadius:
        const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Icon(
            isNewOrder
                ? Icons.file_open_outlined
                : isReject
                ? Icons.close
                : isAccept
                ? Icons.done
                : isWaitingForApproval
                ? Icons.autorenew
                : isOnTheWay
                ? Icons.airport_shuttle_outlined
                : Icons.settings,
            size: 15,
            color: isNewOrder
                ? AppColors.blackColor44
                : isReject
                ? AppColors.redColor
                : isAccept
                ? AppColors.greenColor
                : isWaitingForApproval
                ? AppColors.yelloIconLoadingColor
                : isOnTheWay
                ? AppColors.blueColor
                : AppColors.orangeColor,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextInAppWidget(
              text: statusText,
              textSize: textSize ?? 9,
              fontWeightIndex:
              FontSelectionData.regularFontFamily,
              textColor: isNewOrder
                  ? AppColors.blackColor44
                  : isReject
                  ? AppColors.redColor
                  : isAccept
                  ? AppColors.greenColor
                  : isWaitingForApproval
                  ? AppColors.yelloTextLoadingColor
                  : isOnTheWay
                  ? AppColors.blueColor
                  : AppColors.orangeColor,
            ),
          ),
        ],
      ),
    );
  }
}