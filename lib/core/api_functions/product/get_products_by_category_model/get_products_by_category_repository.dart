import 'package:dio/dio.dart';
import '../../../../core/api_functions/product/get_products_by_category_model/get_products_by_category_request.dart';
import '../../../../core/api_functions/product/get_products_by_category_model/product_model_get_products_by_category.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';

Future<List<ProductModelGetProductsByCategory>> getProductsByCategoryFunction({
  required GetProductsByCategoryRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
      {},
      request.toJson(),
      ApiLink.getProductsByCategory,
    );

    final List list = response.data;

    return list.map((e) => ProductModelGetProductsByCategory.fromJson(e)).toList();
  } catch (e) {
    AppSnackBar.showError(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
    return [];
  }
}