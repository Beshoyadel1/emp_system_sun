import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/login_datasource/login_repository.dart';
import 'package:emp_system_sun/features/service_emp_view/data/datasource/get_services_datasource/get_employee_services_repository.dart';
import 'package:emp_system_sun/features/service_emp_view/data/model/get_employee_services_model/employee_service_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/features/service_emp_view/data/request/get_employee_services_request/get_employee_services_request.dart';

import 'employee_services_state.dart';

class EmployeeServicesCubit extends Cubit<EmployeeServicesState> {
  List<EmployeeServiceModel> services = [];

  EmployeeServicesCubit() : super(EmployeeServicesInitial());

  Future<void> getEmployeeServices() async {
   // print('CUBIT HASH => ${hashCode}');
    try {
      emit(EmployeeServicesLoading());

      final user = await AuthLocalStorage.getUser();

      final employeeId = user?.userid;

      if (employeeId == null) {
        emit(
          EmployeeServicesError(
            'Employee Id Not Found',
          ),
        );
        return;
      }

      final result = await getEmployeeServicesFunction(
        request: GetEmployeeServicesRequest(
          employeeId: employeeId,
        ),
      );

      services = result;
      emit(
        EmployeeServicesSuccess(result),
      );
    } catch (e) {
      emit(
        EmployeeServicesError(
          e.toString(),
        ),
      );
    }
  }
}
