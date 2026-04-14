import 'package:dio/dio.dart';
import '../../../../../../../core/api_functions/chat/get_work_team_chat_model/work_team_user_model.dart';
import '../../../../core/api_functions/chat/get_work_team_chat_model/get_work_team_chat_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';


Future<List<WorkTeamUserModel>> getWorkTeamChatFunction({
  required GetWorkTeamChatRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getWorkTeamChat,
    );

    final responseData = response.data;

    final List data = responseData is List
        ? responseData
        : responseData['data'] ?? [];

    return data.map((e) => WorkTeamUserModel.fromJson(e)).toList();

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return [];
  }
}