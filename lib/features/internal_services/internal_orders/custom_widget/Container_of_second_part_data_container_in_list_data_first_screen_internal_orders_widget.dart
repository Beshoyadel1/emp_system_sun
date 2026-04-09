import 'dart:typed_data';
import 'package:emp_system_sun/core/api_functions/order/get_provider_orders_model/order_model.dart';
import 'package:emp_system_sun/features/internal_services/internal_orders/first_screen_internal_orders/screens/big_container_of_new_orders/part_container_big_container_of_new_orders/custom_tab_second_part_data_container_in_list_data_first_screen_internal_orders.dart';
import 'package:emp_system_sun/features/internal_services/internal_orders/first_screen_internal_orders/screens/big_container_of_new_orders/part_container_big_container_of_new_orders/mobile_second_part_data_container_in_list_data_first_screen_internal_orders.dart';
import 'package:emp_system_sun/features/internal_services/internal_orders/first_screen_internal_orders/screens/big_container_of_new_orders/part_container_big_container_of_new_orders/tab_second_part_data_container_in_list_data_first_screen_internal_orders.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../../../../core/theming/colors.dart';

class ContainerOfSecondPartDataContainerInListDataFirstScreenInternalOrdersWidget
    extends StatelessWidget {
  final String? titlePart1,
      subTitlePart1,
      imagePathPart2,
      textCarPart2,
      titlePart2,
      titlePart3,
      subTitlePart3,
      timePart5,
      pricePart6;
  final int? status;
  final Uint8List? imagePathPart1, imagePathPart3;
  final OrderModel order;

  const ContainerOfSecondPartDataContainerInListDataFirstScreenInternalOrdersWidget(
      {super.key,
      this.imagePathPart1,
      this.titlePart1,
      this.subTitlePart1,
      this.imagePathPart2,
      this.textCarPart2,
      this.titlePart2,
      this.imagePathPart3,
      this.titlePart3,
      this.subTitlePart3,
      this.status,
      this.timePart5,
      this.pricePart6,
      required this.order});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = size.width <= ValuesOfAllApp.mobileWidth;
    bool isTabletCustom =
        size.width > ValuesOfAllApp.mobileWidth && size.width <= 1330;
    return Container(
      padding: const EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isMobile
          ? MobileSecondPartDataContainerInListDataFirstScreenInternalOrders(
              imagePathPart1: imagePathPart1,
              titlePart1: titlePart1!,
              subTitlePart1: subTitlePart1!,
              imagePathPart2: imagePathPart2!,
              textCarPart2: textCarPart2!,
              titlePart2: titlePart2!,
              imagePathPart3: imagePathPart3,
              titlePart3: titlePart3!,
              subTitlePart3: subTitlePart3!,
              status: status,
              timePart5: timePart5!,
              pricePart6: pricePart6!,
              order: order,
            )
          : isTabletCustom
              ? CustomTabSecondPartDataContainerInListDataFirstScreenInternalOrders(
                  imagePathPart1: imagePathPart1,
                  titlePart1: titlePart1!,
                  subTitlePart1: subTitlePart1!,
                  imagePathPart2: imagePathPart2!,
                  textCarPart2: textCarPart2!,
                  titlePart2: titlePart2!,
                  imagePathPart3: imagePathPart3,
                  titlePart3: titlePart3!,
                  subTitlePart3: subTitlePart3!,
                  status: status,
                  timePart5: timePart5!,
                  pricePart6: pricePart6!,
                  order: order,
                )
              : TabSecondPartDataContainerInListDataFirstScreenInternalOrders(
                  imagePathPart1: imagePathPart1,
                  titlePart1: titlePart1!,
                  subTitlePart1: subTitlePart1!,
                  imagePathPart2: imagePathPart2!,
                  textCarPart2: textCarPart2!,
                  titlePart2: titlePart2!,
                  imagePathPart3: imagePathPart3,
                  titlePart3: titlePart3!,
                  subTitlePart3: subTitlePart3!,
                  status: status,
                  timePart5: timePart5!,
                  pricePart6: pricePart6!,
                  order: order,
                ),
    );
  }
}
