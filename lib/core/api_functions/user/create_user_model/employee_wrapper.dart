
import 'package:emp_system_sun/core/api_functions/user/create_user_model/employee_details_request.dart';

class EmployeeWrapper {
  final EmployeeDetailsRequest? employeeDetails;
  final List<int>? provServiceIds;

  EmployeeWrapper({
    this.employeeDetails,
    this.provServiceIds,
  });

  factory EmployeeWrapper.fromJson(Map<String, dynamic> json) {
    return EmployeeWrapper(
      employeeDetails: json['employeeDetails'] != null
          ? EmployeeDetailsRequest.fromJson(json['employeeDetails'])
          : null,

      provServiceIds: json['provServiceIds'] != null
          ? List<int>.from(json['provServiceIds'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employeeDetails": employeeDetails?.toJson(),
      "provServiceIds": provServiceIds ?? [],
    };
  }
}