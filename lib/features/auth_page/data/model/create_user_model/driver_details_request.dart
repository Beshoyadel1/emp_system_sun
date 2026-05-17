import 'dart:convert';
import 'dart:typed_data';

class DriverDetailsRequest {
  final int? id;
  final int? companyid;
  final String? name;
  final String? latinname;
  final Uint8List? licenseimage;
  final Uint8List? identityimage;

  const DriverDetailsRequest({
    this.id,
    this.companyid,
    this.name,
    this.latinname,
    this.licenseimage,
    this.identityimage,
  });

  factory DriverDetailsRequest.fromJson(Map<String, dynamic> json) => DriverDetailsRequest(
    id: json["id"],
    companyid: json["companyid"],
    name: json["name"],
    latinname: json["latinname"],
    licenseimage: json["licenseimage"] != null ? base64Decode(json["licenseimage"]) : null,
    identityimage: json["identityimage"] != null ? base64Decode(json["identityimage"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id??0,
    "companyid": companyid??0,
    "name": name??"",
    "latinname": latinname??"",
    "licenseimage": licenseimage != null ? base64Encode(licenseimage!) : null,
    "identityimage": identityimage != null ? base64Encode(identityimage!) : null,
  };
}