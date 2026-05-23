import '../../model/get_user_chats_model/message_model.dart';
import '../../request/get_user_chats_request/get_user_chats_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';

Future<List<MessageModel>> getUserMessagesFunction({
  required GetUserChatsRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getUserChats,
    );

    final List data =
        response.data['data'] ?? [];

    return data
        .map((e) => MessageModel.fromJson(e))
        .toList();

  } catch (e) {
    throw Exception(e.toString());
  }
}