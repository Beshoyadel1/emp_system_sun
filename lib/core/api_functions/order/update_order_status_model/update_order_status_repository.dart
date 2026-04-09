import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../core/api_functions/order/update_order_status_model/update_order_status_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

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