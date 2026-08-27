import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../../core/api/dio_function/failures.dart';
import '../../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../../features/cars_haraj_page/data/request/change_harage_status_request/change_harage_status_request.dart';

Future<void> changeHarageStatusFunction({
  required ChangeHarageStatusRequest request,
}) async {
  try {
    final jsonString = json.encode(
      request.toJson(),
    );

    await Network.postDataWithBody(
      jsonString,
      ApiLink.changeHarageStatus,
    );
  } catch (e) {

    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );

    rethrow;
  }
}