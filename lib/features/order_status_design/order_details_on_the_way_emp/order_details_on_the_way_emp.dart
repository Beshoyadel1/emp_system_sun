import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/api_functions/order/get_provider_orders_model/order_model.dart';
import '../../../../../../../features/order_status_design/order_details_on_the_way_emp/screens/list_data_order_details_on_the_way_emp.dart';
import '../../../../../../../features/order_status_design/order_details_on_the_way_emp/screens/part_left_screen/data_part_left_screen_order_details_on_the_way_emp.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../core/theming/colors.dart';

class OrderDetailsOnTheWayEmp extends StatelessWidget {
  final OrderModel order;
  const OrderDetailsOnTheWayEmp({super.key,required this.order});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 960;
    bool isTabletCustom = size.width > ValuesOfAllApp.mobileWidth && size.width <= ValuesOfAllApp.customTabWidth;
    bool isTab = size.width > ValuesOfAllApp.tabWidth;

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
                  padding:const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: ListDataOrderDetailsOnTheWayEmp(
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
                      child: DataPartLeftScreenOrderDetailsOnTheWayEmp()
                    ),
                  ),
                ),
            ],
          ),
        )
    );
  }
}