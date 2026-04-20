import 'dart:convert';
import 'dart:typed_data';
import '../../../../core/api_functions/user/create_user_model/company_details_request.dart';
import '../../../../core/api_functions/user/create_user_model/driver_details_request.dart';
import '../../../../core/api_functions/user/create_user_model/employee_details_request.dart';
import '../../../../core/api_functions/user/create_user_model/provider_details_request.dart';
import '../../../../core/api_functions/user/create_user_model/admin_details_request.dart';

class CreateUserRequest {
  final int? userid;
  final String? username;
  final String? phone;
  final String? email;
  final String? password;
  final int? gander;
  final int? age;
  final int? type;
  final String? nationality;
  final bool? isActive;
  final DateTime? joinDate;
  final String? referralCode;
  final Uint8List? image;
  final String? fcmToken;
  final int? currentCarId;

  final AdminDetailsRequest? adminDetails;
  final ProviderDetailsRequest? providerDetails;
  final EmployeeDetailsRequest? employeeDetails;
  final CompanyDetailsRequest? companyDetails;
  final DriverDetailsRequest? driverDetails;

  const CreateUserRequest({
    this.userid,
    this.username,
    this.phone,
    this.email,
    this.password,
    this.gander,
    this.age,
    this.type,
    this.nationality,
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

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) {
    return CreateUserRequest(
      userid: json["userid"],
      username: json["username"],
      phone: json["phone"],
      email: json["email"],
      password: json["password"],
      gander: json["gander"],
      age: json["age"],
      type: json["type"],
      nationality: json["nationality"],
      isActive: json["isactive"],
      referralCode: json["referralcode"],
      fcmToken: json["fcmtoken"],
      currentCarId: json["currentcarid"],
      joinDate:
      json["joindate"] != null ? DateTime.parse(json["joindate"]) : null,
      image: json["image"] != null ? base64Decode(json["image"]) : null,

      adminDetails: json["adminDetails"] != null
          ? AdminDetailsRequest.fromJson(json["adminDetails"])
          : null,
      providerDetails: json["providerDetails"] != null
          ? ProviderDetailsRequest.fromJson(json["providerDetails"])
          : null,

      employeeDetails: json["employeeDetails"] != null
          ? EmployeeDetailsRequest.fromJson(json["employeeDetails"])
          : null,

      companyDetails: json["companyDetails"] != null
          ? CompanyDetailsRequest.fromJson(json["companyDetails"])
          : null,

      driverDetails: json["driverDetails"] != null
          ? DriverDetailsRequest.fromJson(json["driverDetails"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userid": userid ?? 0,
      "username": username ?? "",
      "phone": phone ?? "",
      "email": email ?? "",
      "password": password ?? "",
      "gander": gander ?? 0,
      "age": age ?? 0,
      "type": type ?? 0,
      "nationality": nationality ?? "",
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
