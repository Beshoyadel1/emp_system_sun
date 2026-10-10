import 'dart:async';
import '../../../../../features/notifications/data/model/receive_message_notification_model/receive_message_notification_model.dart';

class ChatEvents {
  ChatEvents._();

  static final ChatEvents instance = ChatEvents._();

  int? activeChatUserId;
  int? activeChatUserType;
  final Map<Object, int> _activeHarages = {};
  void activateHarage(Object owner, int id) => _activeHarages[owner] = id;
  void deactivateHarage(Object owner) => _activeHarages.remove(owner);
  bool isHarageActive(int id) => _activeHarages.containsValue(id);
  void clearActiveHarages() => _activeHarages.clear();

  final StreamController<ReceiveMessageData> _controller =
      StreamController<ReceiveMessageData>.broadcast();

  Stream<ReceiveMessageData> get stream => _controller.stream;
  final _syncController = StreamController<void>.broadcast();
  Stream<void> get syncRequests => _syncController.stream;
  void requestSync() => _syncController.add(null);

  void add(ReceiveMessageData data) {
    _controller.add(data);
  }

  Future<void> dispose() async {
    clearActiveHarages();
    activeChatUserId = null;
    activeChatUserType = null;
    await _controller.close();
    await _syncController.close();
  }
}
