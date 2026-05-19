import '../../model/get_chat_messages_model/chat_details_model.dart';
import '../../request/get_chat_messages_request/get_chat_messages_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';

Future<List<ChatDetailsModel>> getChatMessagesFunction({
  required GetChatMessagesRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getChatMessages,
    );

    final List data = response.data;

    return data.map((e) => ChatDetailsModel.fromJson(e)).toList();

  } catch (e) {
    throw Exception(e.toString());
  }
}