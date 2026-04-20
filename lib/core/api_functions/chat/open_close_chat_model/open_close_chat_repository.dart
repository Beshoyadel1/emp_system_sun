import 'package:dio/dio.dart';
import '../../../../core/api_functions/chat/open_close_chat_model/open_close_chat_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';


Future<void> openCloseChatFunction({
  required OpenCloseChatRequest openCloseChatRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      openCloseChatRequest.toJson(), // params
      ApiLink.openCloseChat,
    );
   // AppSnackBar.showSuccess(AppLanguageKeys.openCloseChatSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}