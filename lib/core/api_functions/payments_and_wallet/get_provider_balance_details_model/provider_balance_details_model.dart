import '../../../../../../core/api_functions/payments_and_wallet/get_provider_balance_details_model/recent_order_model.dart';

class ProviderBalanceDetailsModel {
  final double totalBalance;
  final double electronicBalance;
  final double cashBalance;
  final List<RecentOrderModel> recentOrders;

  ProviderBalanceDetailsModel({
    required this.totalBalance,
    required this.electronicBalance,
    required this.cashBalance,
    required this.recentOrders,
  });

  factory ProviderBalanceDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProviderBalanceDetailsModel(
      totalBalance: (json['totalBalance'] ?? 0).toDouble(),
      electronicBalance: (json['electronicBalance'] ?? 0).toDouble(),
      cashBalance: (json['cashBalance'] ?? 0).toDouble(),
      recentOrders: (json['recentOrders'] as List? ?? [])
          .map((e) => RecentOrderModel.fromJson(e))
          .toList(),
    );
  }
}