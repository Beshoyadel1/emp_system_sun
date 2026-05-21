import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/employee_details_request.dart';

class EmployeeWrapperRequest {

  final EmployeeDetailsRequest? employeeDetails;

  final List<int> provServiceIds;

  const EmployeeWrapperRequest({
    this.employeeDetails,
    this.provServiceIds = const [],
  });

  factory EmployeeWrapperRequest.fromJson(
      dynamic json,
      ) {

    if (json == null) {

      return const EmployeeWrapperRequest();
    }

    /// لو النوع غلط
    if (json is! Map<String, dynamic>) {

      return const EmployeeWrapperRequest();
    }

    /// employeeDetails object
    EmployeeDetailsRequest? employee;
    employee = EmployeeDetailsRequest.fromJson(
      json["employeeDetails"],
    );
    if (json["employeeDetails"] != null) {


      employee = EmployeeDetailsRequest.fromJson(
        json["employeeDetails"],
      );

    } else {

    }

    /// provServiceIds
    List<int> services = [];

    if (json["provServiceIds"] == null) {


      services = [];

    } else if (json["provServiceIds"] is List) {



      services = List<int>.from(
        json["provServiceIds"],
      );

    } else {


      services = [];
    }

    return EmployeeWrapperRequest(

      employeeDetails: employee,

      provServiceIds: services,
    );
  }

  Map<String, dynamic> toJson() {

    // print("========== EMPLOYEE WRAPPER TO JSON ==========");
    //
    // print({
    //   "employeeDetails":
    //   employeeDetails?.toJson(),
    //
    //   "provServiceIds":
    //   provServiceIds,
    // });

    return {

      "employeeDetails":
      employeeDetails?.toJson(),

      "provServiceIds":
      provServiceIds,
    };
  }
}