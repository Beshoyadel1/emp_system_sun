import 'package:flutter/foundation.dart';
import '../../../../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../../main.dart';
import '../../../../../../features/technical_support/data/model/chat_events/chat_events.dart';
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

      if (model?.data?.data != null) {
        ChatEvents.instance.add(model!.data!.data!);
      }
      if (model == null) {
        return;
      }

      if (!await model.canView()) {
        return;
      }
      final context = navigatorKey.currentContext;

      if (context != null && context.mounted) {
        final appCubit = AppCubit.get(context);
        final isTechnicalSupportOpen =
            appCubit.selectedPageIndex == PagesOfAllApp.technicalSupportPageNumber;

        final incomingSenderId = model.data?.data?.fromUser;
        final isActiveChatWithSameSender = isTechnicalSupportOpen &&
            ChatEvents.instance.activeChatUserId != null &&
            incomingSenderId != null &&
            ChatEvents.instance.activeChatUserId.toString() == incomingSenderId;

        // If the active conversation is open with the same sender, message is appended in real-time
        // without showing an intrusive popup dialog.
        if (isActiveChatWithSameSender) {
          return;
        }
      }

      final title = (model.data?.data?.fromUserName?.isNotEmpty == true)
          ? model.data!.data!.fromUserName!
          : (model.data?.title?.isNotEmpty == true ? model.data!.title! : "رسالة جديدة");
      final subtitle = (model.data?.data?.message?.isNotEmpty == true)
          ? model.data!.data!.message!
          : (model.data?.body ?? "");

      await _dialogService.show(
        title: title,
        subtitle: subtitle,
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