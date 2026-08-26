import 'package:dio/dio.dart';
import '../../../../../../../../../features/cars_haraj_page/data/request/delete_harage_request/delete_harage_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<void> deleteHarageFunction({
  required DeleteHarageRequest deleteHarageRequest,
}) async {
  try {
    await Network.postDataWithBodyAndParams(
      {},
      deleteHarageRequest.toJson(), // params
      ApiLink.deleteHarage,
    );
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}