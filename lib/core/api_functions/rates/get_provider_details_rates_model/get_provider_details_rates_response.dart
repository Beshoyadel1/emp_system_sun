import '../../../../core/api_functions/rates/get_provider_details_rates_model/provider.dart';
import '../../../../core/api_functions/rates/get_provider_details_rates_model/service_rates.dart';

class ProviderDetailsRatesResponse {
  final Provider provider;
  final int rateCount;
  final int averageRate;
  final List<ServiceRates> rates;

  ProviderDetailsRatesResponse({
    required this.provider,
    required this.rateCount,
    required this.averageRate,
    required this.rates,
  });

  factory ProviderDetailsRatesResponse.fromJson(Map<String, dynamic> json) {
    return ProviderDetailsRatesResponse(
      provider: Provider.fromJson(json['provider']),
      rateCount: json['rateCount'] ?? 0,
      averageRate: json['averageRate'] ?? 0,
      rates: (json['rates'] as List)
          .map((e) => ServiceRates.fromJson(e))
          .toList(),
    );
  }
}