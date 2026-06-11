import 'package:emp_system_sun/features/service_emp_view/data/model/get_employee_services_model/employee_service_model.dart';

abstract class EmployeeServicesState {}

class EmployeeServicesInitial extends EmployeeServicesState {}

class EmployeeServicesLoading extends EmployeeServicesState {}

class EmployeeServicesSuccess extends EmployeeServicesState {
  final List<EmployeeServiceModel> services;

  EmployeeServicesSuccess(this.services);
}

class EmployeeServicesError extends EmployeeServicesState {
  final String message;

  EmployeeServicesError(this.message);
}