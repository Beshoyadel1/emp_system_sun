import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../model/employee_chat_model.dart';

class EmployeeChatRepository {
  const EmployeeChatRepository();

  /// Fetches all conversation summaries for the specified employee.
  Future<List<GetAllMessagesModel>> getAllMessages({
    required int userId,
    required int userType,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'userId': userId,
        'userType': userType,
      };

      final response = await Network.postDataWithBodyAndParams(
        {},
        queryParams,
        ApiLink.getUserChats,
      );

      final responseData = response.data;
      if (responseData == null) return [];

      List rawList = [];
      if (responseData is List) {
        rawList = responseData;
      } else if (responseData is Map && responseData['data'] is List) {
        rawList = responseData['data'];
      }

      return rawList
          .whereType<Map>()
          .map((item) =>
              GetAllMessagesModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ??
          e.message ??
          'Failed to load conversations');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Fetches team members associated with this employee's facility (supervisor, technicians, system admin).
  Future<List<WorkTeamMemberModel>> getWorkTeam({
    required int userId,
    required int userType,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'userId': userId,
        'user': userId,
        'userType': userType,
      };

      final response = await Network.postDataWithBodyAndParams(
        {},
        queryParams,
        ApiLink.getWorkTeamChat,
      );

      final responseData = response.data;
      if (responseData == null) return [];

      List rawList = [];
      if (responseData is List) {
        rawList = responseData;
      } else if (responseData is Map && responseData['data'] is List) {
        rawList = responseData['data'];
      }

      return rawList
          .whereType<Map>()
          .map((item) =>
              WorkTeamMemberModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ??
          e.message ??
          'Failed to load work team');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Fetches the recent conversation messages using the GetChatMessages endpoint.
  Future<List<ChatMessageModel>> getChatMessages({
    required int fromUserId,
    required int fromUserType,
    required int toUserId,
    required int toUserType,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'fromUserId': fromUserId,
        'fromUserType': fromUserType,
        'toUserId': toUserId,
        'toUserType': toUserType,
      };

      final response = await Network.postDataWithBodyAndParams(
        {},
        queryParams,
        ApiLink.getChatMessages,
      );

      final responseData = response.data;
      if (responseData == null) return [];

      List rawList = [];
      if (responseData is List) {
        rawList = responseData;
      } else if (responseData is Map && responseData['data'] is List) {
        rawList = responseData['data'];
      }

      if (rawList.isNotEmpty && rawList.first is Map) {
        final firstMap = Map<String, dynamic>.from(rawList.first);
        final messages = firstMap['Messages'] ?? firstMap['messages'];
        if (messages is List) {
          return messages
              .whereType<Map>()
              .map((item) =>
                  ChatMessageModel.fromJson(Map<String, dynamic>.from(item)))
              .toList();
        }
      }

      return rawList
          .whereType<Map>()
          .map((item) =>
              ChatMessageModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ??
          e.message ??
          'Failed to load chat messages');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Fetches older messages for a conversation before the specified [date].
  Future<List<ChatMessageModel>> getOlderMessages({
    required int fromUser,
    required int fromUserType,
    required int toUser,
    required int toUserType,
    required String date,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'fromUser': fromUser,
        'fromUserType': fromUserType,
        'toUser': toUser,
        'toUserType': toUserType,
        'date': date,
      };

      final response = await Network.postDataWithBodyAndParams(
        {},
        queryParams,
        ApiLink.getOtherMessages,
      );

      final responseData = response.data;
      if (responseData == null) return [];

      List rawList = [];
      if (responseData is List) {
        rawList = responseData;
      } else if (responseData is Map && responseData['data'] is List) {
        rawList = responseData['data'];
      }

      return rawList
          .whereType<Map>()
          .map((item) =>
              ChatMessageModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ??
          e.message ??
          'Failed to load older messages');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Sends a new chat message to the recipient.
  Future<dynamic> sendChatMessage({
    required SendChatMessageModel message,
  }) async {
    try {
      final bodyString = jsonEncode(message.toJson());
      final response = await Network.postDataWithBody(
        bodyString,
        ApiLink.sendMessage,
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ??
          e.message ??
          'Failed to send message');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Marks the conversation between users as viewed.
  Future<bool> makeChatViewed({
    required int fromUser,
    required int fromUserType,
    required int toUser,
    required int toUserType,
    int? orderId,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'fromUser': fromUser,
        'fromUserType': fromUserType,
        'toUser': toUser,
        'toUserType': toUserType,
      };
      if (orderId != null && orderId > 0) {
        queryParams['orderId'] = orderId;
      }

      final response = await Network.postDataWithBodyAndParams(
        {},
        queryParams,
        ApiLink.makeChatViewed,
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
