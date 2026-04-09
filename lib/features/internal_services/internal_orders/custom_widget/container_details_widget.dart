import 'package:emp_system_sun/core/api_functions/order/get_provider_orders_model/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../../../features/order_status_design/order_details_cancel_order_emp/order_details_cancel_order_emp.dart';
import '../../../../../../../features/order_status_design/order_details_new_order_emp/order_details_new_order_emp.dart';
import '../../../../../../../features/order_status_design/order_details_on_the_way_emp/order_details_on_the_way_emp.dart';
import '../../../../../../../features/order_status_design/order_details_order_received_emp/order_details_order_received_emp.dart';
import '../../../../../../../features/order_status_design/order_details_reject_by_company_order_emp/order_details_reject_by_company_order_emp.dart';
import '../../../../../../../features/order_status_design/order_details_reject_by_provider_order_emp/order_details_reject_by_provider_order_emp.dart';
import '../../../../../../../features/order_status_design/order_details_under_service_emp/order_details_under_service_emp.dart';
import '../../../../../../../features/order_status_design/order_details_waiting_emp/order_details_waiting_emp.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../core/api/dio_function/api_constants.dart';

class ContainerDetailsWidget extends StatelessWidget {
  final String? title;
  final int status;
  final Color? backGroundColor, textColor, borderColor;
  final OrderModel order;

  const ContainerDetailsWidget({
    super.key,
    required this.status,
    this.title,
    this.textColor,
    this.borderColor,
    this.backGroundColor,
    required this.order,
  });

  void _handleNavigation(BuildContext context) {
    switch (status) {
      case OrderStatus.newOrderForProvider:
        Navigator.push(
          context,
          NavigateToPageWidget(
            OrderDetailsNewOrderEmp(
              order: order,
            ),
          ),
        );
        break;
      case OrderStatus.newOrderForCompany:
        Navigator.push(
          context,
          NavigateToPageWidget(
            OrderDetailsNewOrderEmp(order: order),
          ),
        );
        break;

      case OrderStatus.orderCompleted:
        Navigator.push(
          context,
          NavigateToPageWidget(
             OrderDetailsOrderReceivedEmp(
              order: order,
            ),
          ),
        );
        break;

      case OrderStatus.employeeInRoad:
        Navigator.push(
          context,
          NavigateToPageWidget(
            OrderDetailsOnTheWayEmp(
              order: order,
            ),
          ),
        );
        break;

      case OrderStatus.workInProgress:
        Navigator.push(
          context,
          NavigateToPageWidget(
             OrderDetailsUnderServiceEmp(
                order:order
            ),
          ),
        );
        break;

      case OrderStatus.rejectedByProvider:
        Navigator.push(
          context,
          NavigateToPageWidget(
             OrderDetailsRejectByProviderOrderEmp(
              order: order,
            ),
          ),
        );
        break;
      case OrderStatus.rejectedByCompany:
        Navigator.push(
          context,
          NavigateToPageWidget(
             OrderDetailsRejectByCompanyOrderEmp(
              order: order,
            ),
          ),
        );
        break;
      case OrderStatus.cancelledByUser:
        Navigator.push(
          context,
          NavigateToPageWidget(
            OrderDetailsCancelOrderEmp(
              order: order,
            ),
          ),
        );
        break;
      case OrderStatus.waitingAppointment:
        Navigator.push(
          context,
          NavigateToPageWidget(
             OrderDetailsWaitingEmp(
                order:order
            ),
          ),
        );
        break;
      default:
        break;
    }
  }

  bool get _isEnabled {
    return status == OrderStatus.newOrderForProvider ||
        status == OrderStatus.newOrderForCompany ||
        status == OrderStatus.orderCompleted ||
        status == OrderStatus.employeeInRoad ||
        status == OrderStatus.rejectedByProvider ||
        status == OrderStatus.rejectedByCompany ||
        status == OrderStatus.cancelledByUser ||
        status == OrderStatus.waitingAppointment ||
        status == OrderStatus.workInProgress;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isEnabled ? () => _handleNavigation(context) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: (backGroundColor ?? AppColors.whiteColor),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: _isEnabled
                ? (borderColor ?? AppColors.orangeColor)
                : AppColors.greyColor,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkColor.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: TextInAppWidget(
            text: title ?? AppLanguageKeys.details,
            textSize: 12,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: _isEnabled
                ? (textColor ?? AppColors.orangeColor)
                : AppColors.greyColor,
          ),
        ),
      ),
    );
  }
}
