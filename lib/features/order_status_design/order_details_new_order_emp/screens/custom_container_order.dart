import 'package:flutter/cupertino.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/order_funcations/order_functions.dart';
import '../../../../../core/api_functions/order/get_provider_orders_model/order_model.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../features/internal_services/internal_orders/custom_widget/Column_date_order_with_time_widget.dart';
import '../../../../../features/internal_services/internal_orders/custom_widget/column_price_order_widget.dart';
import '../../../../../features/internal_services/internal_orders/custom_widget/row_image_with_title_widget.dart';
import '../../../../../features/internal_services/internal_orders/custom_widget/text_with_container_status.dart';

class CustomContainerOrder extends StatelessWidget {
  final OrderModel order;

  const CustomContainerOrder({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final service =
    order.services?.isNotEmpty == true ? order.services!.first : null;

    final serviceTitle = OrderFunctions.getServiceTitle(
      context: context,
      service: service,
    );

    return CustomContainer(
      isSelected: false,
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      typeWidget: Wrap(
        spacing: 35,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          ColumnDateOrderWithTimeWidget(
            title: AppLanguageKeys.identity,
            time: order.id.toString()
          ),
          RowImageWithTitleWidget(
            isWrap: true,
            imagePath: service?.image,
            title: serviceTitle,
            subTitle: '',
          ),
          RowImageWithTitleWidget(
            isWrap: true,
            isJob: true,
            imagePath: order.providerImage,
            title: AppLanguageKeys.name,
            subTitle: order.providerName ?? "",
          ),
          TextWithContainerStatus(
            status: order.orderStatus ?? 0,
          ),
          ColumnDateOrderWithTimeWidget(
            time: OrderFunctions.formatDate(order.orderDate),
          ),
          ColumnPriceOrderWidget(
            price: order.totalPrice?.toString() ?? "20",
          ),
        ],
      ),
    );
  }
}
