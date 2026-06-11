import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/employee_details_request.dart';

class EmployeeWrapperRequest {

  final EmployeeDetailsRequest? employeeDetails;

  final List<int> serviceIds;

  const EmployeeWrapperRequest({
    this.employeeDetails,
    this.serviceIds = const [],
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

    /// serviceIds
    List<int> services = [];

    if (json["serviceIds"] == null) {


      services = [];

    } else if (json["serviceIds"] is List) {



      services = List<int>.from(
        json["serviceIds"],
      );

    } else {


      services = [];
    }

    return EmployeeWrapperRequest(

      employeeDetails: employee,

      serviceIds: services,
    );
  }

  Map<String, dynamic> toJson() {

    // print("========== EMPLOYEE WRAPPER TO JSON ==========");
    //
    // print({
    //   "employeeDetails":
    //   employeeDetails?.toJson(),
    //
    //   "serviceIds":
    //   serviceIds,
    // });

    return {

      "employeeDetails":
      employeeDetails?.toJson(),

      "serviceIds":
      serviceIds,
    };
  }
}