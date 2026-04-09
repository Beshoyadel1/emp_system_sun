import 'dart:ui';
import '../../../../../core/api_functions/statistics/get_provider_harage_sold_cars_by_type_model/get_provider_harage_sold_cars_by_type_model.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/colors.dart';

class ChartDataModel {
  final String label;
  final int percentage;
  final Color color;

  ChartDataModel({
    required this.label,
    required this.percentage,
    required this.color,
  });
}

final List<ChartDataModel> data = [
  ChartDataModel(
    label: AppLanguageKeys.newCars,
    percentage: 60,
    color: AppColors.orangeColor,
  ),
  ChartDataModel(
    label: AppLanguageKeys.usedCars,
    percentage: 30,
    color: AppColors.lightBlueColor,
  ),
];

List<ChartDataModel> mapSoldCarsToChartData(
    GetProviderHarageSoldCarsByTypeModel model,
    ) {
  final total = model.newCarsCount + model.usedCarsCount;

  if (total == 0) {
    return [
      ChartDataModel(
        label: AppLanguageKeys.newCars,
        percentage: 0,
        color: AppColors.orangeColor,
      ),
      ChartDataModel(
        label: AppLanguageKeys.usedCars,
        percentage: 0,
        color: AppColors.lightBlueColor,
      ),
    ];
  }

  return [
    ChartDataModel(
      label: AppLanguageKeys.newCars,
      percentage: ((model.newCarsCount / total) * 100).round(),
      color: AppColors.orangeColor,
    ),
    ChartDataModel(
      label: AppLanguageKeys.usedCars,
      percentage: ((model.usedCarsCount / total) * 100).round(),
      color: AppColors.lightBlueColor,
    ),
  ];
}
