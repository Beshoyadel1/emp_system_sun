import 'package:flutter/material.dart';
import '../../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/sub_service_summaries_request.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../features/internal_services/internal_orders/custom_widget/row_circle_color_text_percentage_widget.dart';

class ServicesLegendListSparePartsOrders extends StatelessWidget {

  final List<SubServiceSummariesRequest> services;

  const ServicesLegendListSparePartsOrders({
    super.key,
    required this.services,
  });

  List<SubServiceSummariesRequest> get _sortedServices {
    final sorted = List<SubServiceSummariesRequest>.from(services);

    sorted.sort(
          (a, b) => (b.orderCount ?? 0).compareTo(a.orderCount ?? 0),
    );

    return sorted;
  }

  @override
  Widget build(BuildContext context) {

    final isArabic =
        Localizations.localeOf(context).languageCode == 'ar';

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _sortedServices.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {

        final service = _sortedServices[index];

        final title = isArabic
            ? (service.serviceName ?? '')
            : (service.serviceLatinName ?? '');

        final count = service.orderCount ?? 0;

        return RowCircleColorTextPercentageWidget(
          colorCircle: legendColor(index),
          text: title,
          percentage: count.toString(),
        );
      },
    );
  }
}