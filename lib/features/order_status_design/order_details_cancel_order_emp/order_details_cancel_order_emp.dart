import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/api_functions/order/get_provider_orders_model/order_model.dart';
import '../../../../../../features/order_status_design/order_details_cancel_order_emp/screens/list_data_order_details_cancel_order_emp.dart';
import '../../../../../../features/order_status_design/order_details_cancel_order_emp/screens/part_left_screen/data_part_left_screen_order_details_cancel_order_emp.dart';
import '../../../../../core/theming/colors.dart';

class OrderDetailsCancelOrderEmp extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsCancelOrderEmp({super.key,required this.order});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 960;

    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Expanded(
                flex: 3,
                child: Padding(
                  padding:  const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: ListDataOrderDetailsCancelOrderEmp(
                      order:order
                    ),
                  ),
                ),
              ),
              if ((!isMobile))
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding:  EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: DataPartLeftScreenOrderDetailsCancelOrderEmp()
                    ),
                  ),
                ),
            ],
          ),
        )
    );
  }
}