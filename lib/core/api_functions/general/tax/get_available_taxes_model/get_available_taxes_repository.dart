import '../../../../../core/api_functions/general/tax/get_available_taxes_model/get_tax_model.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';


Future<List<GetTaxModel>> getTaxFunction() async {
  try {
    final response = await Network.getData(
      ApiLink.getAvailableTaxs,
    );

    final List data = response.data;

    return data.map((e) => GetTaxModel.fromJson(e)).toList();
  } catch (e) {
    throw e;
  }
}