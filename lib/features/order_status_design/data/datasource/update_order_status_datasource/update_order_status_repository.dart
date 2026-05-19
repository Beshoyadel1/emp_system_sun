import '../../request/update_order_status_request/update_order_status_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';

Future<bool> updateOrderStatusFunction({
  required UpdateOrderStatusRequest updateOrderStatusRequest,
}) async {
  try {
    final value = await Network.postDataWithBodyAndParams(
        null,
      updateOrderStatusRequest.toJson(),
      ApiLink.updateOrderStatus,
    );


    return value.statusCode == 200 &&
        value.data.toString().trim() == "Done";

  } catch (e) {
    return false;
  }
}
