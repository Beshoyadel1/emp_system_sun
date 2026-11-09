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

    dynamic field(String name) {
      for (final entry in json.entries) {
        if (entry.key.toString().toLowerCase() == name.toLowerCase()) {
          return entry.value;
        }
      }
      return null;
    }

    final employeeJson = field('employeeDetails');
    final servicesJson = field('serviceIds');
    final permissionsJson = field('permissions');

    return EmployeeWrapperRequest(
      employeeDetails: employeeJson is Map
          ? EmployeeDetailsRequest.fromJson(
              Map<String, dynamic>.from(
                employeeJson,
              ),
            )
          : null,
      serviceIds: servicesJson is List
          ? servicesJson
              .map((id) => int.tryParse('$id'))
              .whereType<int>()
              .toList()
          : const [],
      permissions: permissionsJson is Map
          ? EmployeePermissionsRequest.fromJson(
              Map<String, dynamic>.from(
                permissionsJson,
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employeeDetails": employeeDetails?.toJson(),
      "serviceIds": serviceIds,
      "permissions": permissions?.toJson(),
    };
  }
}

class EmployeePermissionsRequest {
  final int? employeeId;

  final bool? acceptAllOrders;
  final bool? acceptAndRefuseAndAssignOrders;
  final bool? harage;
  final bool? maintenanceAndInternalServices;
  final bool? mobileServices;
  final bool? spareParts;
  final bool? servicePackage;
  final bool? petrol;

  const EmployeePermissionsRequest({
    this.employeeId,
    this.acceptAllOrders,
    this.acceptAndRefuseAndAssignOrders,
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
    dynamic permission(String name) {
      for (final entry in json.entries) {
        if (entry.key.toLowerCase() == name.toLowerCase()) return entry.value;
      }
      return null;
    }

    return EmployeePermissionsRequest(
      employeeId: permission('employeeid'),
      acceptAllOrders: permission('acceptallorders'),
      acceptAndRefuseAndAssignOrders:
          permission("acceptandrefuseandassignorders"),
      harage: json["harage"],
      maintenanceAndInternalServices: json["maintenanceandinternalservices"],
      mobileServices: json["mobileservices"],
      spareParts: json["spareparts"],
      servicePackage: json["servicepackage"],
      petrol: json["petrol"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employeeid": employeeId,
      "acceptallorders": acceptAllOrders,
      "acceptandrefuseandassignorders": acceptAndRefuseAndAssignOrders,
      "harage": harage,
      "maintenanceandinternalservices": maintenanceAndInternalServices,
      "mobileservices": mobileServices,
      "spareparts": spareParts,
      "servicepackage": servicePackage,
      "petrol": petrol,
    };
  }
}
