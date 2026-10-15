import 'package:emp_system_sun/core/services/auth_session.dart';
import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/features/service_emp_view/data/datasource/get_services_datasource/get_employee_services_repository.dart';
import 'package:emp_system_sun/features/service_emp_view/data/model/get_employee_services_model/employee_service_model.dart';
import 'package:emp_system_sun/features/service_emp_view/data/request/get_employee_services_request/get_employee_services_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'employee_services_state.dart';

class EmployeeServicesCubit extends Cubit<EmployeeServicesState> {
  EmployeeServicesCubit() : super(EmployeeServicesInitial());
  List<EmployeeServiceModel> services = [];
  int _request = 0;

  void reset() {
    _request++;
    services = [];
    if (!isClosed) emit(EmployeeServicesInitial());
  }

  Future<void> getEmployeeServices() async {
    if (isClosed) return;
    final version = AuthSession.version;
    final request = ++_request;
    bool current() =>
        !isClosed && request == _request && AuthSession.isCurrent(version);
    emit(EmployeeServicesLoading());
    try {
      final user = await AuthLocalStorage.getUser();
      if (!current()) return;
      final employeeId = user?.userid;
      if (employeeId == null) {
        services = [];
        emit(EmployeeServicesError('Employee Id Not Found'));
        return;
      }
      final result = await getEmployeeServicesFunction(
        request: GetEmployeeServicesRequest(employeeId: employeeId),
      );
      if (!current()) return;
      services = List<EmployeeServiceModel>.from(result);
      emit(EmployeeServicesSuccess(services));
    } catch (e) {
      if (!current()) return;
      services = [];
      emit(EmployeeServicesError(e.toString()));
    }
  }
}
