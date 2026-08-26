import 'package:flutter/cupertino.dart';
import '../../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../features/order_status_design/presentation/custom_widget/time_line_tile_widget.dart';
import '../../../../../../../core/theming/colors.dart';
import 'package:flutter/material.dart';

class DataTimeLineTileOrderDetailsWidget extends StatelessWidget {
  final int? orderStatus;

  const DataTimeLineTileOrderDetailsWidget({
    super.key,
    this.orderStatus,
  });

  bool get _isRejected =>
      orderStatus == OrderStatus.rejectedByCompany ||
          orderStatus == OrderStatus.rejectedByProvider ||
          orderStatus == OrderStatus.cancelledByUser;

  int get _currentStep {
    switch (orderStatus) {
      case OrderStatus.newOrderForCompany:
      case OrderStatus.newOrderForProvider:
        return 0;

      case OrderStatus.waitingAppointment:
        return 1;

      case OrderStatus.employeeInRoad:
        return 2;

      case OrderStatus.workInProgress:
        return 3;

      case OrderStatus.orderCompleted:
        return 4;

      default:
        return -1;
    }
  }

  Color _stepColor(int step) {
    if (_isRejected) {
      return AppColors.greyColor;
    }

    return _currentStep >= step
        ? AppColors.orangeColor
        : AppColors.greyColor;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: AppColors.orangeColor.withOpacity(0.3),
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
        children: [
          TimeLineTileWidget(
            isFirst: true,
            title: AppLanguageKeys.createNewOrderKey,
            colorAfterLine: _stepColor(0),
            colorBorder: _stepColor(0),
            textColor: _stepColor(0),
            textColorTitle: _stepColor(0),
          ),

          TimeLineTileWidget(
            text: '2',
            title: AppLanguageKeys.waitingAppointment,
            colorBeforeLine: _stepColor(0),
            colorAfterLine: _stepColor(1),
            colorBorder: _stepColor(1),
            textColor: _stepColor(1),
            textColorTitle: _stepColor(1),
          ),

          TimeLineTileWidget(
            text: '3',
            title: AppLanguageKeys.onTheWay,
            colorBeforeLine: _stepColor(1),
            colorAfterLine: _stepColor(2),
            colorBorder: _stepColor(2),
            textColor: _stepColor(2),
            textColorTitle: _stepColor(2),
          ),

          TimeLineTileWidget(
            text: '4',
            title: AppLanguageKeys.workInProgress,
            colorBeforeLine: _stepColor(2),
            colorAfterLine: _stepColor(3),
            colorBorder: _stepColor(3),
            textColor: _stepColor(3),
            textColorTitle: _stepColor(3),
          ),

          TimeLineTileWidget(
            isLast: true,
            text: '5',
            title: AppLanguageKeys.orderCompleted,
            colorBeforeLine: _stepColor(3),
            colorBorder: _stepColor(4),
            textColor: _stepColor(4),
            textColorTitle: _stepColor(4),
          ),
        ],
      )
    );
  }
}
