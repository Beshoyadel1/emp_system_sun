import 'package:flutter/material.dart';
import 'package:emp_system_sun/core/language/language.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/core/theming/app_currency.dart';
import 'package:emp_system_sun/features/internal_services/data/model/get_provider_orders_model/order_details_model.dart';

class OrderDeliveryDetails extends StatelessWidget {
  const OrderDeliveryDetails({super.key, required this.order});

  final OrderDetailsModel order;

  @override
  Widget build(BuildContext context) {
    final delivery = order.deliveryOrder;
    final hasDelivery = order.isDeliveryOrder == true || delivery != null;
    final isOnSite = order.isOnSite;
    if (!hasDelivery && isOnSite == null) return const SizedBox.shrink();

    final translate = AppLocalizations.of(context).translate;
    final status = switch (delivery?.status?.trim().toLowerCase()) {
      'neworder' => AppLanguageKeys.deliveryAwaitingCourier,
      'accepted' => AppLanguageKeys.deliveryAccepted,
      'received' => AppLanguageKeys.deliveryReceived,
      'delivered' => AppLanguageKeys.deliveryDelivered,
      _ => delivery?.status,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 20,
          runSpacing: 8,
          children: [
            if (hasDelivery) Text(translate(AppLanguageKeys.deliveryDetails)),
            if (status != null && status.isNotEmpty) Text(translate(status)),
            if (delivery?.courierName?.isNotEmpty == true)
              Text(
                  '${translate(AppLanguageKeys.deliveryCourier)}: ${delivery!.courierName}'),
            if (delivery?.courierPhone?.isNotEmpty == true)
              SelectableText(delivery!.courierPhone!,
                  textDirection: TextDirection.ltr),
            if (delivery?.fee != null)
              Text(
                  '${translate(AppLanguageKeys.deliveryFee)}: ${AppCurrency.format(context, delivery!.fee)}'),
            if (isOnSite != null)
              Text(translate(isOnSite
                  ? AppLanguageKeys.orderOnSite
                  : AppLanguageKeys.orderOffSite)),
          ],
        ),
      ),
    );
  }
}
