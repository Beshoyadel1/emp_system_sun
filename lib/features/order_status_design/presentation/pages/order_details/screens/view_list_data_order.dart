import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../features/internal_services/data/model/get_provider_orders_model/order_details_model.dart';
import '../../../../../internal_services/presentation/cubit/order_funcations/order_functions.dart';
import '../../../../../../../../features/order_status_design/presentation/custom_widget/view_list_data_order_widget.dart';

class ViewListDataOrder extends StatelessWidget {
  final OrderDetailsModel orderDetailsModel;

  const ViewListDataOrder({
    super.key,
    required this.orderDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    final bool isArabic =
        Localizations.localeOf(context).languageCode == 'ar';

    final List<String> serviceTypes =
        orderDetailsModel.services
            ?.map(
              (service) => isArabic
              ? service.name ?? ''
              : service.latinname ?? '',
        )
            .where(
              (service) => service.isNotEmpty,
        )
            .toList() ??
            [];

    return ViewListDataOrderWidget(
      totalPrice: orderDetailsModel.totalprice?.toString(),
      appointment: OrderFunctions.formatDateFromDateTime(
        orderDetailsModel.appointment,
      ),
      date: OrderFunctions.formatDateFromDateTime(
        orderDetailsModel.date,
      ),
      serviceTypes: serviceTypes,
    );
  }
}