import 'summary_card.dart';

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

