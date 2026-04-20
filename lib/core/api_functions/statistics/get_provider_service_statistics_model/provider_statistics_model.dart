import '../../../../core/api_functions/statistics/get_provider_service_statistics_model/summary_card.dart';

class ProviderStatisticsModel {
  final List<SummaryCard> summaryCards;

  ProviderStatisticsModel({required this.summaryCards});

  factory ProviderStatisticsModel.fromJson(Map<String, dynamic> json) {
    return ProviderStatisticsModel(
      summaryCards: (json['summaryCards'] as List)
          .map((e) => SummaryCard.fromJson(e))
          .toList(),
    );
  }
}

