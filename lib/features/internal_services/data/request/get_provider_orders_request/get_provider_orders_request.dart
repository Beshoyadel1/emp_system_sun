import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/employee_wrapper_request.dart';

class GetProviderOrdersRequest {
  static const int pageSize = 10;
  final int? providerId;
  final int? employeeId;
  final int? pageNumber;
  final int? orderType;
  final int? serviceId;
  final int? branchId;

  GetProviderOrdersRequest({
    this.providerId,
    this.employeeId,
    this.pageNumber,
    this.orderType,
    this.serviceId,
    this.branchId,
  });

  factory GetProviderOrdersRequest.forEmployee({
    required EmployeeWrapperRequest employee,
    required int pageNumber,
    int? orderType,
    int? serviceId,
  }) {
    final broadAccess = employee.permissions?.acceptAllOrders == true ||
        employee.permissions?.acceptAndRefuseAndAssignOrders == true;
    return GetProviderOrdersRequest(
      providerId: employee.employeeDetails?.provid,
      employeeId: broadAccess ? null : employee.employeeDetails?.id,
      branchId: broadAccess ? null : employee.employeeDetails?.branchid,
      pageNumber: pageNumber,
      orderType: orderType,
      serviceId: serviceId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (providerId != null) "providerId": providerId,
      if (employeeId != null) "employeeId": employeeId,
      "pageNumber": pageNumber,
      "pageSize": pageSize,
      if (orderType != null) "orderType": orderType,
      if (serviceId != null) "ServiceId": serviceId,
      if (branchId != null) "branchId": branchId,
    };
  }
}
