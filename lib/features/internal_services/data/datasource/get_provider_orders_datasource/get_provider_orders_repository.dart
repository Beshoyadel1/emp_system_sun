import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/internal_services/data/request/get_provider_orders_request/get_provider_orders_request.dart';
import 'package:emp_system_sun/features/internal_services/data/response/get_provider_orders_response/get_provider_orders_response.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<GetProviderOrdersResponse> getProviderOrdersFunction({
  required GetProviderOrdersRequest getProviderOrdersRequest,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      getProviderOrdersRequest.toJson(),
      ApiLink.getProviderOrders,
    );

    final result = GetProviderOrdersResponse.fromJson(response.data);


    return result;
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );

    rethrow;
  }
}