import 'package:dio/dio.dart';
import '../../../../core/api_functions/chat/make_chat_viewed_model/make_chat_viewed_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';


Future<void> makeChatViewedFunction({
  required MakeChatViewedRequest makeChatViewedRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      makeChatViewedRequest.toJson(), // params
      ApiLink.makeChatViewed,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.makeChatViewedSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}