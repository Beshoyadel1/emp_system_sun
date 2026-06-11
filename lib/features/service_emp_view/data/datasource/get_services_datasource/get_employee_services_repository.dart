import 'package:dio/dio.dart';
import 'package:emp_system_sun/features/service_emp_view/data/model/get_employee_services_model/employee_service_model.dart';
import 'package:emp_system_sun/features/service_emp_view/data/request/get_employee_services_request/get_employee_services_request.dart';
import '../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../core/api/dio_function/dio_controller.dart';
import '../../../../../core/api/dio_function/failures.dart';

Future<List<EmployeeServiceModel>> getEmployeeServicesFunction({
  required GetEmployeeServicesRequest request,
}) async {
  try {
    final response = await Network.postDataWithBodyAndParams(
        {}, request.toJson(), ApiLink.getEmployeeServices);

    if (response.data["success"] != true) {
      return [];
    }

    final List<dynamic> data = response.data["data"] ?? [];

    return data
        .map(
          (e) => EmployeeServiceModel.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
  } on DioException catch (e) {
    throw Exception(
      responseOfStatusCode(
        e.response?.statusCode,
      ),
    );
  } catch (e) {
    throw Exception(
      e.toString(),
    );
  }
}
