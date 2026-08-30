import 'dart:async';
import '../../../../../features/notifications/data/model/receive_message_notification_model/receive_message_notification_model.dart';

class ChatEvents {
  ChatEvents._();

  static final ChatEvents instance =
  ChatEvents._();

  final StreamController<ReceiveMessageData>
  _controller =
  StreamController<ReceiveMessageData>.broadcast();

  Stream<ReceiveMessageData> get stream =>
      _controller.stream;

  void add(
      ReceiveMessageData data,
      ) {
    _controller.add(data);
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}