import '../../data/model/notification_payload.dart';
import '../../../technical_support/data/model/chat_events/chat_events.dart';
import 'notification_audio_service/notification_audio_service.dart';

enum NotificationAlert { silent, chat, order }

class NotificationAlertService {
  const NotificationAlertService(
      {this.audio = const NotificationAudioService()});
  final NotificationAudioService audio;

  NotificationAlert alertFor(NotificationPayload payload,
      {required int userId, required int userType}) {
    if (payload.kind == NotificationKind.newOrder ||
        payload.kind == NotificationKind.orderStatus ||
        payload.kind == NotificationKind.orderAssigned) {
      return NotificationAlert.order;
    }
    if (payload.kind != NotificationKind.chat) return NotificationAlert.silent;
    final sender = payload.integer('fromuser') ?? payload.integer('fromuserid');
    final senderType = payload.integer('fromusertype');
    if (sender == userId && senderType == userType) {
      return NotificationAlert.silent;
    }
    final harageId = payload.integer('harageid') ?? 0;
    if (harageId > 0 && ChatEvents.instance.isHarageActive(harageId)) {
      return NotificationAlert.silent;
    }
    if (harageId == 0 &&
        sender == ChatEvents.instance.activeChatUserId &&
        senderType == ChatEvents.instance.activeChatUserType) {
      return NotificationAlert.silent;
    }
    return NotificationAlert.chat;
  }

  Future<void> playChat() => audio.playChat();
  Future<void> stopChat() => audio.stopChat();
}
