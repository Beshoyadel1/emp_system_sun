import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../../../../features/cars_haraj_page/data/request/create_update_harage_request/create_update_harage_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<void> updateHarageFunction({
  required CreateUpdateHarageRequest createUpdateHarageRequest,
}) async {
  try {
    final String jsonString = json.encode(
      createUpdateHarageRequest.toUpdateJson(),
    );

     await Network.postDataWithBody(
      jsonString,
      ApiLink.updateHarage,
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