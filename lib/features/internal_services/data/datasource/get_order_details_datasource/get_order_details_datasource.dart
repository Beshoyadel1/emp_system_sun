import 'package:dio/dio.dart';
import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../../../core/api/dio_function/failures.dart';
import '../../../../../../../features/internal_services/data/model/get_provider_orders_model/order_details_model.dart';
import '../../../../../../../features/internal_services/data/request/get_order_details_request/get_order_details_datasource.dart';

Future<OrderDetailsModel> getOrderDetailsFunction({
  required GetOrderDetailsDatasource getOrderDetailsDatasource,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      getOrderDetailsDatasource.toJson(),
      ApiLink.getOrderDetails,
    );

    final responseData = response.data;

    final bool success = responseData["success"] ?? false;

    if (!success) {
      throw Exception(
        responseData["message"] ?? "Something went wrong",
      );
    }

    final Map<String, dynamic> data =
    Map<String, dynamic>.from(responseData["data"] ?? {});

    return OrderDetailsModel.fromJson(data);
  } catch (e) {
    if (e is DioException) {
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        throw Exception(
          data["message"] ??
              responseOfStatusCode(
                e.response?.statusCode,
              ),
        );
      }

      throw Exception(
        responseOfStatusCode(
          e.response?.statusCode,
        ),
      );
    }

    throw Exception(
      e.toString(),
    );
  }
}