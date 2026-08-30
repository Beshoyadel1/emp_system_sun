import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/notifications/data/model/receive_message_notification_model/receive_message_notification_model.dart';
import '../../../../../features/technical_support/data/model/chat_events/chat_events.dart';
import '../../../../../core/theming/auth_local_storage.dart';
import '../../../../../features/technical_support/data/model/get_chat_messages_model/chat_details_model.dart';
import '../../../../../features/technical_support/data/datasource/get_chat_messages_datasource/get_chat_messages_repository.dart';
import '../../../../../features/technical_support/data/request/get_chat_messages_request/get_chat_messages_request.dart';
import '../../../../../features/technical_support/data/datasource/send_message_datasource/send_message_repository.dart';
import '../../../../../features/technical_support/data/model/get_chat_messages_model/message_item_model.dart';
import '../../../../../features/technical_support/data/request/send_message_request/send_message_request.dart';
import 'chat_details_state.dart';

class ChatDetailsCubit
    extends Cubit<ChatDetailsState> {

  late final StreamSubscription
  _subscription;

  ChatDetailsCubit()
      : super(ChatDetailsInitial()) {

    _subscription =
        ChatEvents.instance.stream.listen(
          receiveMessage,
        );
  }

  // ============================================================
  // CURRENT USER
  // ============================================================

  int? myUserId;

  int? myUserType;

  // ============================================================
  // CURRENT CHAT
  // ============================================================

  int? selectedToUserId;

  int? selectedToUserType;

  ChatDetailsModel? currentChat;

  // ============================================================
  // LOAD CHAT
  // ============================================================

  Future<void> loadChat({
    required int toUserId,
    required int toUserType,
  }) async {

    selectedToUserId =
        toUserId;

    selectedToUserType =
        toUserType;

    emit(
      ChatDetailsLoading(),
    );

    try {

      final user =
      await AuthLocalStorage.getUser();

      if (user == null) {

        emit(
          ChatDetailsError(
            'User not found',
          ),
        );

        return;
      }

      myUserId =
          user.userid;

      myUserType =
          user.type;

      final chats =
      await getChatMessagesFunction(
        request:
        GetChatMessagesRequest(
          fromUserId:
          user.userid!,

          fromUserType:
          user.type!,

          toUserId:
          toUserId,

          toUserType:
          toUserType,
        ),
      );

      if (chats.isEmpty) {

        currentChat = null;

        emit(
          ChatDetailsSuccess(
            [],
          ),
        );

        return;
      }

      currentChat =
          chats.first;

      emit(
        ChatDetailsSuccess(
          [
            currentChat!,
          ],
        ),
      );

    } catch (e) {

      emit(
        ChatDetailsError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // RECEIVE SIGNALR MESSAGE
  // ============================================================

  void receiveMessage(
      ReceiveMessageData data,
      ) {

    // ----------------------------------------------------------
    // Chat must be opened
    // ----------------------------------------------------------

    if (currentChat == null) {
      return;
    }

    // ----------------------------------------------------------
    // Parse users
    // ----------------------------------------------------------

    final fromUser =
    int.tryParse(
      data.fromUser ?? '',
    );

    final toUser =
    int.tryParse(
      data.toUser ?? '',
    );

    final fromUserType =
    int.tryParse(
      data.fromUserType ?? '',
    );

    final toUserType =
    int.tryParse(
      data.toUserType ?? '',
    );

    if (fromUser == null ||
        toUser == null) {
      return;
    }

    // ----------------------------------------------------------
    // Check conversation
    // ----------------------------------------------------------

    final isSameConversation =
        (
            fromUser == myUserId &&
                toUser == selectedToUserId
        ) ||
            (
                fromUser == selectedToUserId &&
                    toUser == myUserId
            );

    if (!isSameConversation) {
      return;
    }

    // ----------------------------------------------------------
    // Check user types if available
    // ----------------------------------------------------------

    if (fromUserType != null &&
        toUserType != null &&
        myUserType != null &&
        selectedToUserType != null) {

      final isSameTypeConversation =
          (
              fromUser == myUserId &&
                  fromUserType == myUserType &&
                  toUser == selectedToUserId &&
                  toUserType == selectedToUserType
          ) ||
              (
                  fromUser == selectedToUserId &&
                      fromUserType == selectedToUserType &&
                      toUser == myUserId &&
                      toUserType == myUserType
              );

      if (!isSameTypeConversation) {
        return;
      }
    }

    // ----------------------------------------------------------
    // Create message
    // ----------------------------------------------------------

    final message =
    MessageItemModel(
      id:
      int.tryParse(
        data.id ?? '',
      ) ??
          0,

      fromUser:
      fromUser,

      toUser:
      toUser,

      message:
      data.message ?? '',

      date:
      _parseDate(
        data.date,
      ),

      viewed:
      _parseBool(
        data.viewed,
      ),
    );

    // ----------------------------------------------------------
    // Add message
    // ----------------------------------------------------------

    _appendMessage(
      message,
    );
  }

  // ============================================================
  // APPEND MESSAGE
  // ============================================================

  void _appendMessage(
      MessageItemModel message,
      ) {

    if (currentChat == null) {
      return;
    }

    final messages =
    List<MessageItemModel>.from(
      currentChat!.messages ?? [],
    );

    // ==========================================================
    // FIND MESSAGE
    // ==========================================================

    final index =
    _findExistingMessage(
      messages,
      message,
    );

    // ==========================================================
    // UPDATE EXISTING MESSAGE
    // ==========================================================

    if (index != -1) {

      final oldMessage =
      messages[index];

      messages[index] =
          MessageItemModel(
            id:
            message.id != 0
                ? message.id
                : oldMessage.id,

            fromUser:
            message.fromUser,

            toUser:
            message.toUser,

            message:
            message.message,

            date:
            message.date ??
                oldMessage.date,

            viewed:
            message.viewed,
          );

    }

    // ==========================================================
    // ADD NEW MESSAGE
    // ==========================================================

    else {

      messages.add(
        message,
      );
    }

    // ==========================================================
    // UPDATE CURRENT CHAT
    // ==========================================================

    currentChat =
        ChatDetailsModel(
          toUser:
          currentChat!.toUser,

          toUserType:
          currentChat!.toUserType,

          userName:
          currentChat!.userName,

          image:
          currentChat!.image,

          messages:
          messages,
        );

    // ==========================================================
    // EMIT SUCCESS
    // ==========================================================

    emit(
      ChatDetailsSuccess(
        [
          currentChat!,
        ],
      ),
    );
  }

  // ============================================================
  // FIND EXISTING MESSAGE
  // ============================================================

  int _findExistingMessage(
      List<MessageItemModel> messages,
      MessageItemModel newMessage,
      ) {

    // ----------------------------------------------------------
    // 1. REAL SERVER ID
    // ----------------------------------------------------------

    if (newMessage.id != 0) {

      final index =
      messages.indexWhere(
            (oldMessage) =>
        oldMessage.id ==
            newMessage.id,
      );

      if (index != -1) {
        return index;
      }
    }

    // ----------------------------------------------------------
    // 2. OPTIMISTIC MESSAGE
    // ----------------------------------------------------------

    for (
    int i = 0;
    i < messages.length;
    i++
    ) {

      final oldMessage =
      messages[i];

      if (oldMessage.message !=
          newMessage.message) {
        continue;
      }

      if (oldMessage.fromUser !=
          newMessage.fromUser) {
        continue;
      }

      if (oldMessage.toUser !=
          newMessage.toUser) {
        continue;
      }

      if (oldMessage.date == null ||
          newMessage.date == null) {
        continue;
      }

      final difference =
      oldMessage.date!
          .difference(
        newMessage.date!,
      )
          .inSeconds
          .abs();

      if (difference <= 30) {
        return i;
      }
    }

    return -1;
  }

  // ============================================================
  // SEND MESSAGE
  // ============================================================

  Future<void> sendMessage(
      String text,
      ) async {

    final message =
    text.trim();

    if (message.isEmpty) {
      return;
    }

    if (selectedToUserId == null ||
        selectedToUserType == null) {
      return;
    }

    if (currentChat == null) {
      return;
    }

    try {

      final user =
      await AuthLocalStorage.getUser();

      if (user == null) {

        emit(
          ChatDetailsError(
            'User not found',
          ),
        );

        return;
      }

      myUserId =
          user.userid;

      myUserType =
          user.type;

      // ========================================================
      // DATE
      // ========================================================

      final now =
      DateTime.now();

      // ========================================================
      // TEMP ID
      // ========================================================

      final tempId =
          DateTime.now()
              .millisecondsSinceEpoch;

      // ========================================================
      // REQUEST
      // ========================================================

      final request =
      SendMessageRequest(
        id: 0,

        fromuser:
        user.userid!,

        fromusertype:
        user.type!,

        touser:
        selectedToUserId!,

        tousertype:
        selectedToUserType!,

        message:
        message,

        date:
        now.toUtc()
            .toIso8601String(),

        // Don't send null values
        viewed:
        true,

        isclosed:
        false,

        harageid:
        0,

        orderid:
        0,
      );

      // ========================================================
      // OPTIMISTIC MESSAGE
      // ========================================================

      final tempMessage =
      MessageItemModel(
        id:
        tempId,

        fromUser:
        user.userid!,

        toUser:
        selectedToUserId!,

        message:
        message,

        date:
        now,

        viewed:
        true,
      );

      // ========================================================
      // SHOW IMMEDIATELY
      // ========================================================

      _appendMessage(
        tempMessage,
      );

      // ========================================================
      // SEND API
      // ========================================================

      try {

        await sendMessageFunction(
          sendMessageRequest:
          request,
        );

      } catch (e) {

        // ------------------------------------------------------
        // API failed
        // Remove optimistic message
        // ------------------------------------------------------

        _removeMessage(
          tempId,
        );

        // IMPORTANT:
        // Do not emit ChatDetailsError here.
        // Otherwise your chat UI may disappear.

        return;
      }

      // ========================================================
      // DON'T RELOAD CHAT
      // ========================================================
      //
      // SignalR should return the real message.
      //
      // The optimistic message will be replaced
      // by _findExistingMessage().
      //
    } catch (e) {

      emit(
        ChatDetailsError(
          e.toString(),
        ),
      );
    }
  }

  // ============================================================
  // REMOVE MESSAGE
  // ============================================================

  void _removeMessage(
      int messageId,
      ) {

    if (currentChat == null) {
      return;
    }

    final messages =
    List<MessageItemModel>.from(
      currentChat!.messages ?? [],
    );

    messages.removeWhere(
          (message) =>
      message.id == messageId,
    );

    currentChat =
        ChatDetailsModel(
          toUser:
          currentChat!.toUser,

          toUserType:
          currentChat!.toUserType,

          userName:
          currentChat!.userName,

          image:
          currentChat!.image,

          messages:
          messages,
        );

    emit(
      ChatDetailsSuccess(
        [
          currentChat!,
        ],
      ),
    );
  }

  // ============================================================
  // PARSE BOOL
  // ============================================================

  bool _parseBool(
      String? value,
      ) {

    if (value == null) {
      return false;
    }

    return value
        .trim()
        .toLowerCase() ==
        'true';
  }

  // ============================================================
  // PARSE DATE
  // ============================================================

  DateTime? _parseDate(
      String? date,
      ) {

    if (date == null ||
        date.isEmpty) {
      return null;
    }

    // ----------------------------------------------------------
    // ISO
    // ----------------------------------------------------------

    final iso =
    DateTime.tryParse(
      date,
    );

    if (iso != null) {
      return iso;
    }

    // ----------------------------------------------------------
    // Old format
    // ----------------------------------------------------------

    try {

      return DateFormat(
        'MM/dd/yyyy HH:mm:ss',
      ).parse(
        date,
      );

    } catch (_) {

      return null;
    }
  }

  // ============================================================
  // IS MY MESSAGE
  // ============================================================

  bool isMyMessage(
      int fromUserId,
      ) {

    return myUserId != null &&
        fromUserId ==
            myUserId;
  }

  // ============================================================
  // CLOSE
  // ============================================================

  @override
  Future<void> close() {

    _subscription.cancel();

    return super.close();
  }
}