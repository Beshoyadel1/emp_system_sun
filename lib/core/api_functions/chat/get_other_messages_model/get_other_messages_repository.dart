import 'package:dio/dio.dart';
import '../../../../core/api_functions/chat/get_other_messages_model/get_other_messages_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> getOtherMessagesFunction({
  required GetOtherMessagesRequest getOtherMessagesRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getOtherMessagesRequest.toJson(), // params
      ApiLink.getOtherMessages,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getOtherMessagesSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}