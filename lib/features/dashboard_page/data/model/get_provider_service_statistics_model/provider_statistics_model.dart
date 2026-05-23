import 'summary_card.dart';

class ProviderStatisticsModel {
  final List<SummaryCard> summaryCards;

  ProviderStatisticsModel({
    required this.summaryCards,
  });

  factory ProviderStatisticsModel.fromJson(
      Map<String, dynamic> json) {

    final data = json['data'];

    return ProviderStatisticsModel(
      summaryCards: (data['summaryCards'] as List<dynamic>)
          .map((e) => SummaryCard.fromJson(e))
          .toList(),
    );
  }
}
