import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../features/internal_services/data/model/get_provider_orders_model/order_model.dart';
import '../../../../../features/order_status_design/presentation/pages/order_details/screens/list_order_details.dart';
import '../../../../../core/theming/colors.dart';

class OrderDetails extends StatelessWidget {
   final OrderModel order;

  const OrderDetails({super.key,required this.order});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldColor,
        ),
        body:  SafeArea(
          child: Padding(
            padding:const EdgeInsetsGeometry.all(10),
            child: SingleChildScrollView(
              child: ListOrderDetails(
                order:order,
              ),
            ),
          ),
        ));
  }
}
