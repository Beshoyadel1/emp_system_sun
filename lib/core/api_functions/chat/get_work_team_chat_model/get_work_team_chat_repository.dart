import 'package:dio/dio.dart';
import '../../../../core/api_functions/chat/get_work_team_chat_model/get_work_team_chat_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';


Future<void> getWorkTeamChatFunction({
  required GetWorkTeamChatRequest getWorkTeamChatRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      getWorkTeamChatRequest.toJson(), // params
      ApiLink.getWorkTeamChat,
    );
    AppSnackBar.showSuccess(AppLanguageKeys.getWorkTeamChatSuccessfully);
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}