import '../../../../../core/language/language_constant.dart';
class filterOrdersModel {
  final String text;
  bool isSelected;

  filterOrdersModel({required this.text, this.isSelected = false});
}

final List<filterOrdersModel> filterOrders = [
  filterOrdersModel(text: AppLanguageKeys.allOrdersKey, isSelected: true),
  filterOrdersModel(text: AppLanguageKeys.newOrdersKey),
  filterOrdersModel(text: AppLanguageKeys.completedOrdersKey),
  filterOrdersModel(text: AppLanguageKeys.underServiceKey),
];

final List<filterOrdersModel> filterOptionsCars = [
  filterOrdersModel(text: AppLanguageKeys.allCars, isSelected: true),
  filterOrdersModel(text: AppLanguageKeys.newCars),
  filterOrdersModel(text:AppLanguageKeys.usedCars),
  filterOrdersModel(text: AppLanguageKeys.soldCars),
];