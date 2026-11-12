import 'dart:convert';
import 'dart:typed_data';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/employee_wrapper_request.dart';

import 'company_details_request.dart';
import 'driver_details_request.dart';
import 'provider_details_request.dart';
import 'admin_details_request.dart';

class CreateUserRequest {
  final int? userid;
  final String? username;
  final String? phone;
  final String? email;
  final String? password;
  final int? gander;
  final DateTime? birthDate;
  final int? type;
  final String? nationality;
  final String? nationalAddress;
  final bool? isActive;
  final DateTime? joinDate;
  final String? referralCode;
  final Uint8List? image;
  final String? fcmToken;
  final int? currentCarId;

  final AdminDetailsRequest? adminDetails;
  final ProviderDetailsRequest? providerDetails;
  final EmployeeWrapperRequest? employeeDetails;
  final CompanyDetailsRequest? companyDetails;
  final DriverDetailsRequest? driverDetails;

  const CreateUserRequest({
    this.userid,
    this.username,
    this.phone,
    this.email,
    this.password,
    this.gander,
    this.birthDate,
    this.type,
    this.nationality,
    this.nationalAddress,
    this.isActive,
    this.joinDate,
    this.referralCode,
    this.image,
    this.fcmToken,
    this.currentCarId,
    this.adminDetails,
    this.providerDetails,
    this.employeeDetails,
    this.companyDetails,
    this.driverDetails,
  });
  bool isSameData(CreateUserRequest other) {
    return jsonEncode(toJson()) == jsonEncode(other.toJson());
  }
  factory CreateUserRequest.fromJson(
      Map<String, dynamic> json,
      ) {

    final driverInfo = json["driverInfo"];
    final driver = driverInfo is Map ? driverInfo["driverDetails"] : json["driverDetails"];
    return CreateUserRequest(

      userid: json["userid"],

      username: json["username"],

      phone: json["phone"],

      email: json["email"],

      password: json["password"],

      gander:
      json["gender"] ??
          json["gander"],

      birthDate: _parseBirthDate(json["birthdate"]),

      type: json["type"],

      nationality:
      json["nationality"],
      nationalAddress: json["nationaladdress"],

      isActive:
      json["isactive"],

      referralCode:
      json["referralcode"],

      fcmToken:
      json["fcmtoken"],

      currentCarId:
      json["defaultcarid"] ??
          json["currentcarid"],

      joinDate:
      json["joindate"] != null
          ? DateTime.parse(
        json["joindate"],
      )
          : null,

      image:
      json["image"] != null
          ? base64Decode(
        json["image"],
      )
          : null,

      adminDetails:
      json["adminDetails"] != null
          ? AdminDetailsRequest.fromJson(
        json["adminDetails"],
      )
          : null,

      providerDetails:
      json["providerDetails"] != null
          ? ProviderDetailsRequest.fromJson(
        json["providerDetails"],
      )
          : null,

      employeeDetails:
      EmployeeWrapperRequest.fromJson(
        json["employeeDetails"],
      ),

      companyDetails:
      json["companyDetails"] != null
          ? CompanyDetailsRequest.fromJson(
        json["companyDetails"],
      )
          : null,

      driverDetails: driver is Map<String, dynamic>
          ? DriverDetailsRequest.fromJson(driver)
          : null,
    );
  }
  // A birthday is a calendar date, so keep its day regardless of timezone.
  static DateTime? _parseBirthDate(dynamic value) {
    if (value is! String || value.trim().isEmpty) return null;
    final date = DateTime.tryParse(value.trim().split('T').first);
    return date == null ? null : DateTime(date.year, date.month, date.day);
  }

  String? _birthDateToJson() {
    final date = birthDate;
    if (date == null) return null;
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-${day}T00:00:00';
  }

  Map<String, dynamic> toApiJson({required bool isUpdate}) {
    final body = toJson();
    body['gender'] = body.remove('gander');
    body['defaultcarid'] = body.remove('currentcarid');
    body.remove('joindate');
    if (!isUpdate) body.remove('userid');
    final driver = body.remove('driverDetails');
    if (driver != null) body['driverInfo'] = {'driverDetails': driver};
    return body;
  }

  Map<String, dynamic> toJson() {
    return {
      "userid": userid ?? 0,
      "username": username ?? "",
      "phone": phone ?? "",
      "email": email ?? "",
      "password": password ?? "",
      "gander": gander ?? 0,
      "birthdate": _birthDateToJson(),
      "type": type ?? 0,
      "nationality": nationality ?? "",
      if (nationalAddress != null) "nationaladdress": nationalAddress,
      "isactive": isActive ?? true,
      "joindate": (joinDate ?? DateTime.now()).toIso8601String(),
      "referralcode": referralCode ?? "",
      "fcmtoken": fcmToken ?? "",
      "currentcarid": currentCarId ?? 0,
      "image": image != null ? base64Encode(image!) : null,
      "adminDetails": adminDetails?.toJson(),
      "providerDetails": providerDetails?.toJson(),
      "employeeDetails": employeeDetails?.toJson(),
      "companyDetails": companyDetails?.toJson(),
      "driverDetails": driverDetails?.toJson(),
    };
  }
}
