import '../../../../../../core/api/dio_function/api_constants.dart';

class OrdersTabs {
  static const int all = 0;
  static const int newOrders = 1;
  static const int completed = 2;
  static const int inProgress = 3;
}
class InternalOrdersFilter {

  static List filterOrders(List allOrders, int selectedTab) {
    switch (selectedTab) {
      case OrdersTabs.newOrders:
        return allOrders
            .where((o) =>
        o.orderStatus == OrderStatus.newOrderForProvider||
            o.orderStatus == OrderStatus.newOrderForCompany
            )
            .toList();

      case OrdersTabs.completed:
        return allOrders
            .where((o) =>
        o.orderStatus == OrderStatus.orderCompleted ||
            o.orderStatus == OrderStatus.rejectedByProvider
            || o.orderStatus == OrderStatus.rejectedByCompany
            || o.orderStatus == OrderStatus.cancelledByUser
        )
            .toList();

      case OrdersTabs.inProgress:
        return allOrders
            .where((o) =>
        o.orderStatus == OrderStatus.workInProgress ||
            o.orderStatus == OrderStatus.employeeInRoad ||
            o.orderStatus == OrderStatus.waitingAppointment)
            .toList();

      case OrdersTabs.all:
      default:
        return allOrders;
    }
  }
}
int mapOrderType(int tab) {
  switch (tab) {
    case OrdersTabs.newOrders:
      return 1;

    case OrdersTabs.completed:
      return 2;

    case OrdersTabs.inProgress:
      return 3;

    case OrdersTabs.all:
    default:
      return 0;
  }
}