import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/login_datasource/login_repository.dart';
import 'package:emp_system_sun/features/service_emp_view/data/datasource/get_services_datasource/get_employee_services_repository.dart';
import 'package:emp_system_sun/features/service_emp_view/data/model/get_employee_services_model/employee_service_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/features/service_emp_view/data/request/get_employee_services_request/get_employee_services_request.dart';

import 'employee_services_state.dart';

import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/features/service_emp_view/data/datasource/get_services_datasource/get_employee_services_repository.dart';
import 'package:emp_system_sun/features/service_emp_view/data/model/get_employee_services_model/employee_service_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:emp_system_sun/features/service_emp_view/data/request/get_employee_services_request/get_employee_services_request.dart';

import 'employee_services_state.dart';

class EmployeeServicesCubit extends Cubit<EmployeeServicesState> {
  EmployeeServicesCubit() : super(EmployeeServicesInitial());

  List<EmployeeServiceModel> services = [];

  Future<void> getEmployeeServices() async {
    try {
      emit(EmployeeServicesLoading());

      final user = await AuthLocalStorage.getUser();

      final employeeId = user?.userid;


      if (employeeId == null) {
        services = [];

        emit(
          EmployeeServicesError(
            'Employee Id Not Found',
          ),
        );

        return;
      }

      final request = GetEmployeeServicesRequest(
        employeeId: employeeId,
      );

      final result = await getEmployeeServicesFunction(
        request: request,
      );

      services = List<EmployeeServiceModel>.from(result);


      emit(
        EmployeeServicesSuccess(services),
      );
    } catch (e, stackTrace) {
      services = [];

      emit(
        EmployeeServicesError(
          e.toString(),
        ),
      );
    }
  }
}