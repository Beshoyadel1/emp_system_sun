import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/datasource/change_harage_status_datasource/change_harage_status_datasource.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/datasource/get_harage_chat_datasource/get_harage_chat_datasource.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/model/get_harage_chat_model/get_harage_chat_model.dart';
import 'package:emp_system_sun/features/cars_haraj_page/data/request/change_harage_status_request/change_harage_status_request.dart';
import 'package:emp_system_sun/features/notifications/data/model/receive_message_notification_model/receive_message_notification_model.dart';
import 'package:emp_system_sun/features/technical_support/data/model/chat_events/chat_events.dart';

import '../../../../../../../../../features/cars_haraj_page/data/datasource/get_car_brand_datasource/get_car_brand_models_repository.dart';
import '../../../../../../../../../features/cars_haraj_page/data/request/get_car_brand_request/get_car_brand_models_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../core/theming/auth_local_storage.dart';
import '../../../../../../../../../features/cars_haraj_page/data/datasource/create_harage_datasource/create_harage_repository.dart';
import '../../../../../../../../../features/cars_haraj_page/data/datasource/delete_harage_datasource/delete_harage_repository.dart';
import '../../../../../../../../../features/cars_haraj_page/data/datasource/get_car_brand_models_datasource/get_car_brand_repository.dart';
import '../../../../../../../../../features/cars_haraj_page/data/datasource/update_harage_datasource/update_harage_repository.dart';
import '../../../../../../../../../features/cars_haraj_page/data/model/get_car_brand_models_model/car_brand_data_model.dart';
import '../../../../../../../../../features/cars_haraj_page/data/request/create_update_harage_request/create_update_harage_request.dart';
import '../../../../../../../../../features/cars_haraj_page/data/request/delete_harage_request/delete_harage_request.dart';
import '../../../../../../../../../features/technical_support/data/datasource/send_message_datasource/send_message_repository.dart';
import '../../../../../../../../../features/technical_support/data/request/send_message_request/send_message_request.dart';
import '../../../../../../../features/cars_haraj_page/data/datasource/get_user_harages_datasource/get_user_harages_datasource.dart';
import '../../../../../../../features/cars_haraj_page/data/request/get_user_harages_request/get_user_harages_request.dart';
import '../../../../../../../features/cars_haraj_page/data/response/get_user_harages_response/get_user_harages_response.dart';
import '../../../../../../../features/cars_haraj_page/data/datasource/get_all_harages_datasource/get_all_harages_datasource.dart';
import '../../../../../../../features/cars_haraj_page/data/datasource/get_car_details_datasource/get_car_details_datasource.dart';
import '../../../../../../../features/cars_haraj_page/data/model/get_car_details_model/get_car_details_model.dart';
import '../../../../../../../features/cars_haraj_page/data/request/get_all_harages_request/get_all_harages_request.dart';
import '../../../../../../../features/cars_haraj_page/data/request/get_car_details_request/get_car_details_request.dart';
import '../../../../../../../features/cars_haraj_page/data/response/get_all_harage_response/get_all_harage_response.dart';
import '../../../../../../../features/cars_haraj_page/presentation/bloc/harag_cubit/harag_state.dart';
import '../../../../../../../features/cars_haraj_page/data/request/get_harage_details_request/get_harage_details_request.dart';
import '../../../../../../../features/cars_haraj_page/data/response/get_harage_details_response/get_harage_details_response.dart';
import '../../../../../../../features/cars_haraj_page/data/datasource/get_harage_details_datasource/get_harage_details_datasource.dart';
import '../../../data/request/get_harage_chat_request/get_harage_chat_request.dart';


class HaragCubit extends Cubit<HaragState> {
  late final StreamSubscription _subscription;

  HaragCubit()
      : super(
    const HaragInitial(),
  ) {
    // ============================================================
    // LISTEN TO LIVE SIGNALR MESSAGES
    // ============================================================

    _subscription = ChatEvents.instance.stream.listen(
          (data) {
        receiveHarageMessage(data);
      },
    );
  }

  // ============================================================
  // RESPONSES
  // ============================================================

  GetAllHarageResponse? haragesResponse;

  GetHarageDetailsResponse? harageDetailsResponse;

  GetCarDetailsModel? carDetailsResponse;

  GetUserHaragesResponse? userHaragesResponse;

  GetHarageChatResponse? harageChatResponse;

  // ============================================================
  // CURRENT CHAT
  // ============================================================

  int? selectedHarageId;

  int? myUserId;

  int? myUserType;

  // ============================================================
  // GET HARAGE CHAT
  // ============================================================

  Future<void> getHarageChat({
    required int harageId,
  }) async {
    selectedHarageId = harageId;

    emit(
      GetHarageChatLoading(
        currentPage: state.currentPage,
        pageCount: state.pageCount,
      ),
    );

    try {
      final user = await AuthLocalStorage.getUser();

      if (user == null) {
        emit(
          GetHarageChatError(
            message: 'User not found',
            currentPage: state.currentPage,
            pageCount: state.pageCount,
          ),
        );
        return;
      }

      myUserId = user.userid;
      myUserType = user.type;

      final response = await getHarageChatFunction(
        getHarageChatRequest: GetHarageChatRequest(
          harageId: harageId,
        ),
      );

      harageChatResponse = response;

      emit(
        GetHarageChatSuccess(
          response: response,
          currentPage: state.currentPage,
          pageCount: state.pageCount,
        ),
      );
    } catch (e) {
      emit(
        GetHarageChatError(
          message: e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
          currentPage: state.currentPage,
          pageCount: state.pageCount,
        ),
      );
    }
  }

  // ============================================================
  // RECEIVE LIVE HARAGE MESSAGE
  // ============================================================

  // ============================================================
// RECEIVE LIVE HARAG MESSAGE
// ============================================================

  void receiveHarageMessage(
      ReceiveMessageData data,
      ) {
    // ==========================================================
    // CHAT MUST BE OPEN
    // ==========================================================

    if (harageChatResponse?.data == null) {
      print('❌ HARAG CHAT NOT OPEN');
      return;
    }

    // ==========================================================
    // HARAG MUST BE SELECTED
    // ==========================================================

    if (selectedHarageId == null) {
      print('❌ NO SELECTED HARAGE');
      return;
    }

    // ==========================================================
    // PARSE DATA
    // ==========================================================

    final fromUser = int.tryParse(
      data.fromUser ?? '',
    );

    final fromUserType = int.tryParse(
      data.fromUserType ?? '',
    );

    // ----------------------------------------------------------
    // TO USER IS OPTIONAL FOR HARAG
    // ----------------------------------------------------------

    final toUser =
        int.tryParse(
          data.toUser ?? '',
        ) ??
            0;

    final toUserType =
        int.tryParse(
          data.toUserType ?? '',
        ) ??
            0;

    final harageId = int.tryParse(
      data.harageId ?? '',
    );

    final orderId =
        int.tryParse(
          data.orderId ?? '',
        ) ??
            0;


    if (fromUser == null ||
        fromUserType == null ||
        harageId == null) {
      print(
        '❌ INVALID HARAG SIGNALR DATA',
      );
      return;
    }

    // ==========================================================
    // HARAGE MUST MATCH
    // ==========================================================

    if (harageId != selectedHarageId) {
      print(
        '❌ HARAGE ID MISMATCH',
      );

      print(
        'CURRENT: $selectedHarageId',
      );

      print(
        'RECEIVED: $harageId',
      );

      return;
    }

    // ==========================================================
    // CHECK SENDER
    // ==========================================================
    //
    // We only need to make sure the sender belongs to this
    // Harag conversation.
    //
    // TOUSER / TOUSERTYPE are NOT required.
    //
    // ==========================================================

    final isMyMessage =
        fromUser == myUserId &&
            fromUserType == myUserType;

    final isKnownContributor =
    harageChatResponse!
        .data!
        .contributors
        .any(
          (contributor) =>
      contributor.userId ==
          fromUser &&
          contributor.userType ==
              fromUserType,
    );

    if (!isMyMessage &&
        !isKnownContributor) {
      print(
        '❌ UNKNOWN HARAG CONTRIBUTOR',
      );
      return;
    }

    // ==========================================================
    // CREATE LIVE MESSAGE
    // ==========================================================

    final liveMessage =
    GetHarageChatMessage(
      id: int.tryParse(
        data.id ?? '0',
      ),

      fromUser:
      fromUser,

      toUser:
      toUser,

      fromUserType:
      fromUserType,

      toUserType:
      toUserType,

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

      isClosed:
      _parseBool(
        data.isClosed,
      ),

      harageId:
      harageId,

      orderId:
      orderId,
    );

    print(
      '🟢 HARAG LIVE MESSAGE ACCEPTED',
    );

    // ==========================================================
    // ADD / REPLACE OPTIMISTIC MESSAGE
    // ==========================================================

    _appendMessage(
      liveMessage,
    );
  }

// ============================================================
// APPEND / UPDATE MESSAGE
// ============================================================

  void _appendMessage(
      GetHarageChatMessage message,
      ) {
    if (harageChatResponse?.data == null) {
      return;
    }

    final currentMessages =
    List<GetHarageChatMessage>.from(
      harageChatResponse!.data!.messages,
    );

    // ==========================================================
    // FIND EXISTING MESSAGE
    // ==========================================================

    final index = _findExistingMessage(
      currentMessages,
      message,
    );

    // ==========================================================
    // UPDATE EXISTING MESSAGE
    // ==========================================================

    if (index != -1) {
      final oldMessage =
      currentMessages[index];

      currentMessages[index] =
          GetHarageChatMessage(
            // ------------------------------------------------------
            // REAL SERVER ID
            // ------------------------------------------------------

            id:
            message.id != null &&
                message.id != 0
                ? message.id
                : oldMessage.id,

            // ------------------------------------------------------
            // USERS
            // ------------------------------------------------------

            fromUser:
            message.fromUser,

            toUser:
            message.toUser != 0
                ? message.toUser
                : oldMessage.toUser,

            fromUserType:
            message.fromUserType,

            toUserType:
            message.toUserType != 0
                ? message.toUserType
                : oldMessage.toUserType,

            // ------------------------------------------------------
            // CONTENT
            // ------------------------------------------------------

            message:
            message.message,

            date:
            message.date ??
                oldMessage.date,

            // ------------------------------------------------------
            // STATUS
            // ------------------------------------------------------

            viewed:
            message.viewed,

            isClosed:
            message.isClosed,

            // ------------------------------------------------------
            // HARAG
            // ------------------------------------------------------

            harageId:
            message.harageId ??
                oldMessage.harageId,

            orderId:
            message.orderId ??
                oldMessage.orderId,
          );

      print(
        '🔄 HARAG MESSAGE UPDATED',
      );
    }

    // ==========================================================
    // ADD NEW MESSAGE
    // ==========================================================

    else {
      currentMessages.add(
        message,
      );

      print(
        '➕ NEW HARAG MESSAGE ADDED',
      );
    }

    // ==========================================================
    // UPDATE RESPONSE
    // ==========================================================

    harageChatResponse =
        GetHarageChatResponse(
          success:
          harageChatResponse!.success,

          data:
          GetHarageChatData(
            contributors:
            harageChatResponse!
                .data!
                .contributors,

            messages:
            currentMessages,
          ),
        );

    // ==========================================================
    // EMIT
    // ==========================================================

    emit(
      GetHarageChatSuccess(
        response:
        harageChatResponse,
        currentPage:
        state.currentPage,
        pageCount:
        state.pageCount,
      ),
    );
  }

// ============================================================
// FIND EXISTING MESSAGE
// ============================================================

  int _findExistingMessage(
      List<GetHarageChatMessage> messages,
      GetHarageChatMessage newMessage,
      ) {
    // ==========================================================
    // 1. REAL SERVER ID
    // ==========================================================

    if (newMessage.id != null &&
        newMessage.id != 0) {
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

    // ==========================================================
    // 2. MATCH OPTIMISTIC MESSAGE
    // ==========================================================

    for (int i = 0;
    i < messages.length;
    i++) {
      final oldMessage =
      messages[i];

      // --------------------------------------------------------
      // SAME HARAGE
      // --------------------------------------------------------

      if (oldMessage.harageId !=
          newMessage.harageId) {
        continue;
      }

      // --------------------------------------------------------
      // SAME SENDER
      // --------------------------------------------------------

      if (oldMessage.fromUser !=
          newMessage.fromUser) {
        continue;
      }

      if (oldMessage.fromUserType !=
          newMessage.fromUserType) {
        continue;
      }

      // --------------------------------------------------------
      // SAME MESSAGE
      // --------------------------------------------------------

      if (oldMessage.message !=
          newMessage.message) {
        continue;
      }

      // --------------------------------------------------------
      // DATE MATCH
      // --------------------------------------------------------

      if (oldMessage.date != null &&
          newMessage.date != null) {
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
    }

    return -1;
  }

// ============================================================
// SEND MESSAGE
// ============================================================

  Future<void> sendMessage({
    required String message,
    required int harageId,
  }) async {
    final text =
    message.trim();

    if (text.isEmpty) {
      return;
    }

    if (harageId == 0) {
      emit(
        const SendMessageError(
          message:
          'Invalid Harage ID',
        ),
      );

      return;
    }

    try {
      // ========================================================
      // GET CURRENT USER
      // ========================================================

      final user =
      await AuthLocalStorage.getUser();

      if (user == null) {
        emit(
          const SendMessageError(
            message:
            'User not found',
          ),
        );

        return;
      }

      // ========================================================
      // FROM USER
      // ========================================================

      final fromUser =
          user.userid ?? 0;

      final fromUserType =
          user.type ?? 0;

      if (fromUser == 0 ||
          fromUserType == 0) {
        emit(
          const SendMessageError(
            message:
            'Invalid user information',
          ),
        );

        return;
      }

      // ========================================================
      // SAVE CURRENT USER
      // ========================================================

      myUserId =
          fromUser;

      myUserType =
          fromUserType;

      selectedHarageId =
          harageId;

      // ========================================================
      // DATE
      // ========================================================

      final now =
      DateTime.now();

      final utcDate =
      now.toUtc()
          .toIso8601String();

      // ========================================================
      // REQUEST
      // ========================================================
      //
      // HARAG DOES NOT NEED TOUSER / TOUSERTYPE.
      //
      // The conversation is identified by HARAGEID.
      //
      // ========================================================

      final request =
      SendMessageRequest(
        id:
        0,

        fromuser:
        fromUser,

        fromusertype:
        fromUserType,

        message:
        text,

        date:
        utcDate,

        viewed:
        true,

        isclosed:
        true,

        harageid:
        harageId,

        orderid:
        0,
      );

      // ========================================================
      // TEMP ID
      // ========================================================

      final tempId =
          DateTime.now()
              .millisecondsSinceEpoch;

      // ========================================================
      // OPTIMISTIC MESSAGE
      // ========================================================
      //
      // SHOW MESSAGE IMMEDIATELY.
      //
      // ========================================================

      final tempMessage =
      GetHarageChatMessage(
        id:
        tempId,

        fromUser:
        fromUser,

        // Harag does not depend on these.
        toUser:
        0,

        fromUserType:
        fromUserType,

        toUserType:
        0,

        message:
        text,

        date:
        now,

        viewed:
        true,

        isClosed:
        true,

        harageId:
        harageId,

        orderId:
        0,
      );

      // ========================================================
      // ADD IMMEDIATELY
      // ========================================================

      _appendMessage(
        tempMessage,
      );

      print('');
      print(
        '==============================================',
      );
      print(
        '🟡 HARAG OPTIMISTIC MESSAGE',
      );
      print(
        'FROM USER: $fromUser',
      );
      print(
        'FROM TYPE: $fromUserType',
      );
      print(
        'HARAGE ID: $harageId',
      );
      print(
        'MESSAGE: $text',
      );
      print(
        '==============================================',
      );
      print('');

      // ========================================================
      // SEND API
      // ========================================================

      try {
        await sendMessageFunction(
          sendMessageRequest:
          request,
        );

        print(
          '✅ HARAG MESSAGE SENT SUCCESSFULLY',
        );
      } catch (e) {
        // ======================================================
        // API FAILED
        // ======================================================

        print(
          '❌ HARAG MESSAGE SEND FAILED: $e',
        );

        // Remove temporary message
        _removeMessage(
          tempId,
        );

        emit(
          SendMessageError(
            message:
            e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
          ),
        );

        return;
      }

      // ========================================================
      // DON'T RELOAD
      // ========================================================
      //
      // SignalR will send the real message.
      //
      // _findExistingMessage()
      // will replace the optimistic message.
      //
    } catch (e) {
      print(
        '❌ HARAG SEND ERROR: $e',
      );

      emit(
        SendMessageError(
          message:
          e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }

// ============================================================
// REMOVE OPTIMISTIC MESSAGE
// ============================================================

  void _removeMessage(
      int messageId,
      ) {
    if (harageChatResponse?.data == null) {
      return;
    }

    final messages =
    List<GetHarageChatMessage>.from(
      harageChatResponse!.data!.messages,
    );

    messages.removeWhere(
          (message) =>
      message.id ==
          messageId,
    );

    harageChatResponse =
        GetHarageChatResponse(
          success:
          harageChatResponse!.success,

          data:
          GetHarageChatData(
            contributors:
            harageChatResponse!
                .data!
                .contributors,

            messages:
            messages,
          ),
        );

    emit(
      GetHarageChatSuccess(
        response:
        harageChatResponse,
        currentPage:
        state.currentPage,
        pageCount:
        state.pageCount,
      ),
    );
  }

// ============================================================
// MARK MESSAGE AS VIEWED
// ============================================================

  void markMessageAsViewed({
    required int messageId,
  }) {
    if (harageChatResponse?.data == null) {
      return;
    }

    final messages =
    List<GetHarageChatMessage>.from(
      harageChatResponse!.data!.messages,
    );

    final index =
    messages.indexWhere(
          (message) =>
      message.id ==
          messageId,
    );

    if (index == -1) {
      return;
    }

    final oldMessage =
    messages[index];

    // Already viewed
    if (oldMessage.viewed == true) {
      return;
    }

    messages[index] =
        GetHarageChatMessage(
          id:
          oldMessage.id,

          fromUser:
          oldMessage.fromUser,

          toUser:
          oldMessage.toUser,

          fromUserType:
          oldMessage.fromUserType,

          toUserType:
          oldMessage.toUserType,

          message:
          oldMessage.message,

          date:
          oldMessage.date,

          viewed:
          true,

          isClosed:
          oldMessage.isClosed,

          harageId:
          oldMessage.harageId,

          orderId:
          oldMessage.orderId,
        );

    // ==========================================================
    // UPDATE RESPONSE
    // ==========================================================

    harageChatResponse =
        GetHarageChatResponse(
          success:
          harageChatResponse!.success,

          data:
          GetHarageChatData(
            contributors:
            harageChatResponse!
                .data!
                .contributors,

            messages:
            messages,
          ),
        );

    emit(
      GetHarageChatSuccess(
        response:
        harageChatResponse,
        currentPage:
        state.currentPage,
        pageCount:
        state.pageCount,
      ),
    );
  }

// ============================================================
// MARK ALL MESSAGES AS VIEWED
// ============================================================

  void markAllMessagesAsViewed() {
    if (harageChatResponse?.data == null) {
      return;
    }

    final messages =
    List<GetHarageChatMessage>.from(
      harageChatResponse!.data!.messages,
    );

    bool changed = false;

    for (int i = 0;
    i < messages.length;
    i++) {
      final message =
      messages[i];

      // --------------------------------------------------------
      // ONLY INCOMING MESSAGES
      // --------------------------------------------------------

      final isIncoming =
          message.fromUser !=
              myUserId;

      if (isIncoming &&
          message.viewed != true) {
        messages[i] =
            GetHarageChatMessage(
              id:
              message.id,

              fromUser:
              message.fromUser,

              toUser:
              message.toUser,

              fromUserType:
              message.fromUserType,

              toUserType:
              message.toUserType,

              message:
              message.message,

              date:
              message.date,

              viewed:
              true,

              isClosed:
              message.isClosed,

              harageId:
              message.harageId,

              orderId:
              message.orderId,
            );

        changed = true;
      }
    }

    if (!changed) {
      return;
    }

    // ==========================================================
    // UPDATE RESPONSE
    // ==========================================================

    harageChatResponse =
        GetHarageChatResponse(
          success:
          harageChatResponse!.success,

          data:
          GetHarageChatData(
            contributors:
            harageChatResponse!
                .data!
                .contributors,

            messages:
            messages,
          ),
        );

    emit(
      GetHarageChatSuccess(
        response:
        harageChatResponse,
        currentPage:
        state.currentPage,
        pageCount:
        state.pageCount,
      ),
    );
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
// GET OTHER CONTRIBUTOR
// ============================================================

  GetHarageChatContributor?
  getOtherContributor() {
    if (harageChatResponse?.data ==
        null) {
      return null;
    }

    final contributors =
        harageChatResponse!
            .data!
            .contributors;

    for (final contributor
    in contributors) {
      if (contributor.userId !=
          myUserId ||
          contributor.userType !=
              myUserType) {
        return contributor;
      }
    }

    return null;
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

    // ==========================================================
    // ISO DATE
    // ==========================================================

    final parsed =
    DateTime.tryParse(
      date,
    );

    if (parsed != null) {
      return parsed;
    }

    // ==========================================================
    // OLD DATE FORMAT
    // ==========================================================

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
  // GET USER HARAGES
  // ============================================================

  Future<void> getUserHarages({
    required int currentPage,
  }) async {
    final previousPageCount =
        state.pageCount;

    emit(
      UserHaragesLoading(
        currentPage:
        currentPage,
        pageCount:
        previousPageCount,
      ),
    );

    try {
      final user =
      await AuthLocalStorage.getUser();

      if (user == null) {
        emit(
          UserHaragesError(
            message:
            'User not found',
            currentPage:
            currentPage,
            pageCount:
            previousPageCount,
          ),
        );
        return;
      }

      final response =
      await getUserHaragesFunction(
        getUserHaragesRequest:
        GetUserHaragesRequest(
          userId:
          user.userid ?? 0,
          userType:
          user.type ?? 0,
          pageNumber:
          currentPage,
        ),
      );

      userHaragesResponse =
          response;

      emit(
        UserHaragesSuccess(
          response:
          response,
          currentPage:
          response?.data?.currentPage ??
              currentPage,
          pageCount:
          response?.data?.pageCount ??
              previousPageCount,
        ),
      );
    } catch (e) {
      emit(
        UserHaragesError(
          message:
          e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
          currentPage:
          currentPage,
          pageCount:
          previousPageCount,
        ),
      );
    }
  }

  // ============================================================
  // GET CAR DETAILS
  // ============================================================

  Future<void> getCarDetails({
    required int carId,
  }) async {
    try {
      emit(
        const CarDetailsLoading(),
      );

      final response =
      await getCarDetailsFunction(
        request:
        GetCarDetailsRequest(
          carId: carId,
        ),
      );

      carDetailsResponse =
          response;

      emit(
        CarDetailsSuccess(
          response:
          response,
        ),
      );
    } catch (e) {
      carDetailsResponse =
      null;

      emit(
        CarDetailsError(
          message:
          e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }

  // ============================================================
  // GET ALL HARAGES
  // ============================================================

  Future<void> getAllHarages({
    required int currentPage,
  }) async {
    final previousPageCount =
        state.pageCount;

    emit(
      HaragLoading(
        currentPage:
        currentPage,
        pageCount:
        previousPageCount,
      ),
    );

    try {
      final response =
      await getAllHaragesFunction(
        request:
        GetAllHaragesRequest(
          pageNumber:
          currentPage,
        ),
      );

      haragesResponse =
          response;

      emit(
        HaragSuccess(
          response:
          response,
          currentPage:
          response.currentPage,
          pageCount:
          response.pageCount,
        ),
      );
    } catch (e) {
      emit(
        HaragError(
          message:
          e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
          currentPage:
          currentPage,
          pageCount:
          previousPageCount,
        ),
      );
    }
  }

  // ============================================================
  // GET HARAGE DETAILS
  // ============================================================

  Future<void> getHarageDetails({
    required int harageId,
  }) async {
    try {
      emit(
        HaragDetailsLoading(
          currentPage:
          state.currentPage,
          pageCount:
          state.pageCount,
        ),
      );

      final response =
      await getHarageDetailsFunction(
        getHarageDetailsRequest:
        GetHarageDetailsRequest(
          harageId:
          harageId,
        ),
      );

      harageDetailsResponse =
          response;

      final car =
          response?.data?.car;

      if (car != null &&
          car.id != null) {
        await getCarDetails(
          carId: car.id!,
        );
      }

      emit(
        HaragDetailsSuccess(
          response:
          response,
          currentPage:
          state.currentPage,
          pageCount:
          state.pageCount,
        ),
      );
    } catch (e) {
      emit(
        HaragDetailsError(
          message:
          e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
          currentPage:
          state.currentPage,
          pageCount:
          state.pageCount,
        ),
      );
    }
  }

  // ============================================================
  // CREATE HARAGE
  // ============================================================

  Future<void> createHarage({
    required CreateUpdateHarageRequest request,
  }) async {
    emit(
      const CreateHarageLoading(),
    );

    try {
      final user =
      await AuthLocalStorage.getUser();

      if (user == null) {
        emit(
          const CreateHarageError(
            message:
            'User not found',
          ),
        );
        return;
      }

      final createRequest =
      CreateUpdateHarageRequest(
        userId:
        user.userid,
        userType:
        user.type,
        carId:
        request.carId,
        carBrandId:
        request.carBrandId,
        carModelId:
        request.carModelId,
        isNew:
        request.isNew,
        releaseDate:
        request.releaseDate,
        transmissionType:
        request.transmissionType,
        fuelType:
        request.fuelType,
        kilometers:
        request.kilometers,
        description:
        request.description,
        addressText:
        request.addressText,
        price:
        request.price,
        cost:
        request.cost,
        branchId:
        request.branchId,
        images:
        request.images,
      );

      await createHarageFunction(
        createUpdateHarageRequest:
        createRequest,
      );

      emit(
        const CreateHarageSuccess(),
      );
    } catch (e) {
      emit(
        CreateHarageError(
          message:
          e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }

  // ============================================================
  // DELETE HARAGE
  // ============================================================

  Future<void> deleteHarage({
    required int harageId,
  }) async {
    emit(
      const DeleteHarageLoading(),
    );

    try {
      final request =
      DeleteHarageRequest(
        harageId:
        harageId,
      );

      await deleteHarageFunction(
        deleteHarageRequest:
        request,
      );

      emit(
        const DeleteHarageSuccess(),
      );
    } catch (e) {
      emit(
        DeleteHarageError(
          message:
          e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }

  // ============================================================
  // CHANGE HARAGE STATUS
  // ============================================================

  Future<void> changeHarageStatus({
    required ChangeHarageStatusRequest request,
  }) async {
    emit(
      ChangeHarageStatusLoading(),
    );

    try {
      await changeHarageStatusFunction(
        request:
        request,
      );

      emit(
        ChangeHarageStatusSuccess(),
      );
    } catch (e) {
      emit(
        ChangeHarageStatusError(
          e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }

  // ============================================================
  // UPDATE HARAGE
  // ============================================================

  Future<void> updateHarage({
    required CreateUpdateHarageRequest request,
    int? harageStatus,
    String? statusNotes,
  }) async {
    emit(
      const UpdateHarageLoading(),
    );

    try {
      await updateHarageFunction(
        createUpdateHarageRequest:
        request,
      );

      if (harageStatus != null &&
          request.id != null) {
        await changeHarageStatusFunction(
          request:
          ChangeHarageStatusRequest(
            harageId:
            request.id!,
            status:
            harageStatus,
            notes:
            statusNotes,
          ),
        );
      }

      emit(
        const UpdateHarageSuccess(),
      );
    } catch (e) {
      emit(
        UpdateHarageError(
          message:
          e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }

  // ============================================================
  // GET CAR BRANDS
  // ============================================================

  Future<void> getCarBrands() async {
    emit(
      const HaragBrandsLoading(),
    );

    try {
      final brands =
      await getCarBrandFunction();

      final validBrands =
      <CarBrandDataModel>[];

      for (final brand
      in brands) {
        final brandId =
            brand.id;

        if (brandId == null ||
            brandId == 0) {
          continue;
        }

        try {
          final models =
          await getCarBrandModelsFunction(
            request:
            GetCarBrandModelsRequest(
              carBrandId:
              brandId,
            ),
          );

          if (models.isNotEmpty) {
            validBrands.add(
              brand,
            );
          }
        } catch (_) {
          continue;
        }
      }

      if (validBrands.isEmpty) {
        emit(
          const HaragBrandsError(
            message:
            'No brands with models found',
          ),
        );
        return;
      }

      emit(
        HaragBrandsSuccess(
          brands:
          validBrands,
        ),
      );
    } catch (e) {
      emit(
        HaragBrandsError(
          message:
          e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }

  // ============================================================
  // GET MODELS BY BRAND ID
  // ============================================================

  Future<void> getCarModels({
    required int brandId,
  }) async {
    emit(
      const HaragModelsLoading(),
    );

    try {
      final models =
      await getCarBrandModelsFunction(
        request:
        GetCarBrandModelsRequest(
          carBrandId:
          brandId,
        ),
      );

      if (models.isEmpty) {
        emit(
          const HaragModelsError(
            message:
            'No models found',
          ),
        );
        return;
      }

      emit(
        HaragModelsSuccess(
          models:
          models,
        ),
      );
    } catch (e) {
      emit(
        HaragModelsError(
          message:
          e.toString().replaceFirst(
            'Exception: ',
            '',
          ),
        ),
      );
    }
  }

  // ============================================================
  // REFRESH
  // ============================================================

  Future<void> refreshGetAllHarages() async {
    await getAllHarages(
      currentPage:
      state.currentPage,
    );
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