import 'package:dio/dio.dart';
import '../../../../core/api_functions/user/check_if_user_exist_or_not_model/check_if_user_exist_or_not_model.dart';
import '../../../../core/api_functions/user/check_if_user_exist_or_not_model/check_if_user_exist_or_not_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<List<CheckIfUserExistOrNotModel>?> checkIfUserExistOrNotFunction({
  required CheckIfUserExistOrNotRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.checkIfUserExistOrNot,
    );

    final data = response.data as List;

    return data
        .map((e) => CheckIfUserExistOrNotModel.fromJson(e))
        .toList();

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return null;
  }
}
