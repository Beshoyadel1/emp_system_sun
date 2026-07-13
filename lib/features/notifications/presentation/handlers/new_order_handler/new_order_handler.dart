import 'package:flutter/foundation.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../features/internal_services/presentation/cubit/order_funcations/order_functions.dart';
import '../../../../../../features/notifications/data/datasource/parsers/new_order_parser/new_order_parser.dart';
import '../../../../../../features/notifications/presentation/services/dialog_service/dialog_service.dart';
import '../../../../../../features/notifications/presentation/services/navigation_service/navigation_service.dart';

class NewOrderHandler {
  NewOrderHandler({
    required NewOrderParser parser,
    required NotificationDialogService dialogService,
    required NotificationNavigationService navigationService,
  })  : _parser = parser,
        _dialogService = dialogService,
        _navigationService = navigationService;

  final NewOrderParser _parser;
  final NotificationDialogService _dialogService;
  final NotificationNavigationService _navigationService;

  Future<void> handle(List<Object?>? arguments) async {
    try {
      final model = _parser.parse(arguments);

      if (model == null) {
        return;
      }

      if (!await model.data!.orderInfo!.canView()) {
        return;
      }

      await _dialogService.show(
        title:
        OrderFunctions.formatDate(
          model.data?.orderInfo?.orderDate?.toString() ?? "",
        ),
        subtitle: AppLanguageKeys.newOrders,
        onView: () async {
          _navigationService.openDashboardOrders();
        },
      );
    } catch (e, s) {
      debugPrint("NewOrder Error => $e");
      debugPrintStack(stackTrace: s);
    }
  }
}