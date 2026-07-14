import 'package:flutter/foundation.dart';
import '../../../../../../features/notifications/data/datasource/parsers/receive_message_parser/receive_message_parser.dart';
import '../../../../../../features/notifications/presentation/services/dialog_service/dialog_service.dart';
import '../../../../../../features/notifications/presentation/services/navigation_service/navigation_service.dart';

class ReceiveMessageHandler {
  ReceiveMessageHandler({
    required ReceiveMessageParser parser,
    required NotificationDialogService dialogService,
    required NotificationNavigationService navigationService,
  })  : _parser = parser,
        _dialogService = dialogService,
        _navigationService = navigationService;

  final ReceiveMessageParser _parser;
  final NotificationDialogService _dialogService;
  final NotificationNavigationService _navigationService;

  Future<void> handle(List<Object?>? arguments) async {
    try {
      final model = _parser.parse(arguments);

      if (model == null) {
        return;
      }

      if (!await model.canView()) {
        return;
      }

      await _dialogService.show(
        title: model.data?.data?.fromUserName ?? "",
        subtitle: model.data?.data?.message  ?? "",
        onView: () async {
          _navigationService.openChat();
        },
      );
    } catch (e, s) {
      debugPrint("ReceiveMessage Error => $e");
      debugPrintStack(stackTrace: s);
    }
  }
}