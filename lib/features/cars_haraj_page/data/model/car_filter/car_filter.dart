import '../../../../../../core/api/dio_function/api_constants.dart';

class OrdersTabs {
  static const int all = 0;
  static const int newItems = 1;
  static const int usedItems = 2;
  static const int soldItems = 3;
}
class CarFilter {
  static List filterCars(List allCars, int selectedTab) {
    switch (selectedTab) {
      case OrdersTabs.newItems:
        return allCars.where((c) => c.isNew == true).toList();

      case OrdersTabs.usedItems:
        return allCars.where((c) => c.isNew == false).toList();

      case OrdersTabs.soldItems:
        return allCars.where((c) => c.isSold == true).toList();

      case OrdersTabs.all:
      default:
        return allCars;
    }
  }
}