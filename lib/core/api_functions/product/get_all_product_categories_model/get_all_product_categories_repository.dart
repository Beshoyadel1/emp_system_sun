import 'package:dio/dio.dart';
import '../../../../../../core/api_functions/product/get_all_product_categories_model/product_category_model.dart';
import '../../../../core/api/dio_function/api_constants.dart';
import '../../../../core/api/dio_function/dio_controller.dart';
import '../../../../core/api/dio_function/failures.dart';


Future<List<ProductCategoryModel>> getAllProductCategoriesFunction() async {
  try {
    final response = await Network.getData(
      ApiLink.getAllProductCategories,
    );

    final List list = response.data;

    return list
        .map((e) => ProductCategoryModel.fromJson(e))
        .toList();
  } catch (e) {
    throw Exception(
      e is DioException
          ? responseOfStatusCode(e.response?.statusCode)
          : e.toString(),
    );
  }
}