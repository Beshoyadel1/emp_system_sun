import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/chat/send_message_model/send_message_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<void> sendMessageFunction({required SendMessageRequest sendMessageRequest}) async {
  try {
    String jsonString = json.encode(sendMessageRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
      ApiLink.sendMessage,
    ).then((value) {
    });
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}