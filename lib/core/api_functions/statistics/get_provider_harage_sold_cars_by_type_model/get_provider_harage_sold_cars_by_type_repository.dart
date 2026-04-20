import 'package:dio/dio.dart';
import '../../../../../../core/api_functions/statistics/get_provider_harage_sold_cars_by_type_model/get_provider_harage_sold_cars_by_type_model.dart';
import '../../../../core/api_functions/statistics/get_provider_harage_sold_cars_by_type_model/get_provider_harage_sold_cars_by_type_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<GetProviderHarageSoldCarsByTypeModel?> getProviderHarageSoldCarsByTypeFunction({
  required GetProviderHarageSoldCarsByTypeRequest getProviderHarageSoldCarsByTypeRequest,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      getProviderHarageSoldCarsByTypeRequest.toJson(),
      ApiLink.getProviderHarageSoldCarsByType,
    );
    final data = GetProviderHarageSoldCarsByTypeModel.fromJson(response.data);
    //AppSnackBar.showSuccess(AppLanguageKeys.getProviderHarageSoldCarsByTypeSuccessfully);
    return data;
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return null;
  }
}
