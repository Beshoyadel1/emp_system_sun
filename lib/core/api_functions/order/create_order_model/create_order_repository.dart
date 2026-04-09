import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api_functions/order/create_order_model/create_order_request.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';
import '../../../../core/language/language_constant.dart';

Future<void> createOrderFunction({required CreateOrderRequest createOrderRequest}) async {
  try {
    String jsonString = json.encode(createOrderRequest.toJson());

    await Network.postDataWithBody(
      jsonString,
        ApiLink.createOrder,
    ).then((value) {
      AppSnackBar.showSuccess(AppLanguageKeys.createOrderSuccessfully);
    });

  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}