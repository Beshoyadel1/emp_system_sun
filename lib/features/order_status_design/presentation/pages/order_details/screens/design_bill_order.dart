import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../features/internal_services/data/model/get_provider_orders_model/order_details_model.dart';
import '../../../../../../../../features/order_status_design/presentation/custom_widget/design_bill_order_widget.dart';

class DesignBillOrder extends StatelessWidget {
  final OrderDetailsModel orderDetailsModel;
  const DesignBillOrder({super.key,required this.orderDetailsModel});

  @override
  Widget build(BuildContext context) {
    return  DesignBillOrderWidget(
      paymentMethod:orderDetailsModel.paymentmethod,
      price:orderDetailsModel.totalprice.toString(),
      tax: orderDetailsModel.taxamount.toString(),
      totalPrice:orderDetailsModel.totalprice.toString(),
    );
  }
}
