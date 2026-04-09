import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import '../../../../../../../../core/api_functions/order/get_provider_orders_model/order_model.dart';
import '../../../../../../../../features/internal_services/internal_orders/custom_widget/row_image_with_title_widget.dart';
import '../../../../../../../../features/internal_services/internal_orders/custom_widget/text_with_container_status.dart';
import '../../../../../../../../features/internal_services/internal_orders/custom_widget/Column_date_order_with_time_widget.dart';
import '../../../../../../../../features/internal_services/internal_orders/custom_widget/column_price_order_widget.dart';
import '../../../../../../../../features/internal_services/internal_orders/custom_widget/column_request_status_widget.dart';
import '../../../../../../../../features/internal_services/internal_orders/custom_widget/container_details_widget.dart';
import '../../../../../../../../features/internal_services/internal_orders/custom_widget/row_image_with_title_orange_and_sub_title_black_widget.dart';
import '../../../../../../../../features/internal_services/internal_orders/custom_widget/row_kind_of_car_with_text_widget.dart';

class MobileSecondPartDataContainerInListDataFirstScreenInternalOrders
    extends StatelessWidget {
  final String
      titlePart1,
      subTitlePart1,
      imagePathPart2,
      textCarPart2,
      titlePart2,
      titlePart3,
      subTitlePart3,
      timePart5,
      pricePart6;
  final int? status;
  final Uint8List? imagePathPart1,imagePathPart3;
  final OrderModel order;
  const MobileSecondPartDataContainerInListDataFirstScreenInternalOrders({
    super.key,
    required this.imagePathPart1,
    required this.titlePart1,
    required this.subTitlePart1,
    required this.imagePathPart2,
    required this.textCarPart2,
    required this.titlePart2,
    required this.imagePathPart3,
    required this.titlePart3,
    required this.subTitlePart3,
    this.status,
    required this.timePart5,
    required this.pricePart6,
    required this.order
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: RowImageWithTitleWidget(
                imagePath: imagePathPart1,
                title: titlePart1,
               // textSizeTitle: 12,
                subTitle: subTitlePart1,
              ),
            ),
            // Flexible(
            //   child: RowKindOfCarWithTextWidget(
            //     imagePath: imagePathPart2,
            //     textCar: textCarPart2,
            //     title: titlePart2,
            //   ),
            // ),
          ],
        ),
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: RowImageWithTitleWidget(
                isJob: true,
                imagePath: imagePathPart3,
                title: titlePart3,
                subTitle: subTitlePart3,
              ),
            ),
            Flexible(
              child: TextWithContainerStatus(
                status: status??0,
              )
            ),
          ],
        ),
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: ColumnDateOrderWithTimeWidget(time: timePart5)),
            Flexible(child: ColumnPriceOrderWidget(price: pricePart6)),
          ],
        ),
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Expanded(child: ContainerDetailsWidget(
            status: status ?? 0,
            order: order,
          ))],
        ),
      ],
    );
  }
}
