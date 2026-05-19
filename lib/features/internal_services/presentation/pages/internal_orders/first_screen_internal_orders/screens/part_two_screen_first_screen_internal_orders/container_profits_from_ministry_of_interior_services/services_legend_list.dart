import 'package:flutter/material.dart';
import '../../../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../../../features/internal_services/data/model/get_provider_main_service_statistics_model/sub_service_summaries_model.dart';
import '../../../../../../../../../features/internal_services/presentation/pages/internal_orders/custom_widget/row_circle_color_text_percentage_widget.dart';

class ServicesLegendList extends StatelessWidget {

  final List<SubServiceSummariesModel> services;

  const ServicesLegendList({
    super.key,
    required this.services,
  });

  List<SubServiceSummariesModel> get _sortedServices {
    final sorted = List<SubServiceSummariesModel>.from(services);

    sorted.sort(
          (a, b) => (b.orderCount ?? 0).compareTo(a.orderCount ?? 0),
    );

    return sorted;
  }

  @override
  Widget build(BuildContext context) {

    final isArabic =
        Localizations.localeOf(context).languageCode == 'ar';

    if (services.isEmpty) {
      return const SizedBox();
    }

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

        final orderCount = service.orderCount ?? 0;

        return RowCircleColorTextPercentageWidget(
          colorCircle: legendColor(index),
          text: title,
          percentage: orderCount.toString(),
        );
      },
    );
  }
}