import 'package:flutter/material.dart';
import '../../../../../../../../features/internal_services/data/model/get_provider_orders_model/order_details_model.dart';
import '../../../../../../../../features/order_status_design/presentation/custom_widget/container_contact_with_customer_order_details_widget.dart';

class ContainerContactWithCustomerOrderDetails extends StatelessWidget {
  final OrderDetailsModel orderDetailsModel;
  const ContainerContactWithCustomerOrderDetails({super.key,required this.orderDetailsModel});

  @override
  Widget build(BuildContext context) {
    return  ContainerContactWithCustomerOrderDetailsWidget(
      imageUser: orderDetailsModel.providerInfo?.image,
      nameCustomer:orderDetailsModel.providerInfo?.name ,
    );
  }
}
