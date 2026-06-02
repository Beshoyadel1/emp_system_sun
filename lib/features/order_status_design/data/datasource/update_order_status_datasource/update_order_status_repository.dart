import '../../request/update_order_status_request/update_order_status_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';

Future<bool> updateOrderStatusFunction({
  required UpdateOrderStatusRequest updateOrderStatusRequest,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      null,
      updateOrderStatusRequest.toJson(),
      ApiLink.updateOrderStatus,
    );

    if (response.statusCode == 200) {
      return response.data["success"] == true;
    }

    return false;
  } catch (e) {
    return false;
  }
}
