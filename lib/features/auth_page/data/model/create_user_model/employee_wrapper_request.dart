import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/employee_details_request.dart';

class EmployeeWrapperRequest {
  final EmployeeDetailsRequest? employeeDetails;
  final List<int> serviceIds;
  final EmployeePermissionsRequest? permissions;

  const EmployeeWrapperRequest({
    this.employeeDetails,
    this.serviceIds = const [],
    this.permissions,
  });

  factory EmployeeWrapperRequest.fromJson(
      dynamic json,
      ) {
    if (json == null || json is! Map) {
      return const EmployeeWrapperRequest();
    }

    final employeeJson = json["employeeDetails"];

    return EmployeeWrapperRequest(
      employeeDetails:
      employeeJson is Map
          ? EmployeeDetailsRequest.fromJson(
        Map<String, dynamic>.from(
          employeeJson,
        ),
      )
          : null,

      serviceIds:
      json["serviceIds"] is List
          ? List<int>.from(
        json["serviceIds"],
      )
          : const [],

      permissions:
      json["permissions"] is Map
          ? EmployeePermissionsRequest.fromJson(
        Map<String, dynamic>.from(
          json["permissions"],
        ),
      )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employeeDetails":
      employeeDetails?.toJson(),

      "serviceIds":
      serviceIds,

      "permissions":
      permissions?.toJson(),
    };
  }
}
class EmployeePermissionsRequest {
  final int? employeeId;

  final bool? acceptAllOrders;
  final bool? changeOrderStatus;
  final bool? harage;
  final bool? maintenanceAndInternalServices;
  final bool? mobileServices;
  final bool? spareParts;
  final bool? servicePackage;
  final bool? petrol;

  const EmployeePermissionsRequest({
    this.employeeId,
    this.acceptAllOrders,
    this.changeOrderStatus,
    this.harage,
    this.maintenanceAndInternalServices,
    this.mobileServices,
    this.spareParts,
    this.servicePackage,
    this.petrol,
  });

  factory EmployeePermissionsRequest.fromJson(
      Map<String, dynamic> json,
      ) {
    return EmployeePermissionsRequest(
      employeeId: json["employeeid"],

      acceptAllOrders: json["acceptallorders"],

      changeOrderStatus: json["changeorderstatus"],

      harage: json["harage"],

      maintenanceAndInternalServices:
      json["maintenanceandinternalservices"],

      mobileServices:
      json["mobileservices"],

      spareParts:
      json["spareparts"],

      servicePackage:
      json["servicepackage"],

      petrol:
      json["petrol"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employeeid": employeeId,
      "acceptallorders": acceptAllOrders,
      "changeorderstatus": changeOrderStatus,
      "harage": harage,
      "maintenanceandinternalservices":
      maintenanceAndInternalServices,
      "mobileservices": mobileServices,
      "spareparts": spareParts,
      "servicepackage": servicePackage,
      "petrol": petrol,
    };
  }
}