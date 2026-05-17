import 'dart:convert';
import 'dart:typed_data';
class CompanyDetailsRequest {
  final int? id;
  final String? name;
  final String? latinname;
  final String? vatno;
  final String? cr;
  final int? packageid;
  final Uint8List? image;

  const CompanyDetailsRequest({
    this.id,
    this.name,
    this.latinname,
    this.vatno,
    this.cr,
    this.packageid,
    this.image,
  });

  factory CompanyDetailsRequest.fromJson(Map<String, dynamic> json) =>
      CompanyDetailsRequest(
        id: json["id"],
        name: json["name"],
        latinname: json["latinname"],
        vatno: json["vatno"],
        cr: json["cr"],
        packageid: json["packageid"],
        image: json["image"] != null ? base64Decode(json["image"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "id": id??0,
    "name": name??"",
    "latinname": latinname??"",
    "vatno": vatno??"",
    "cr": cr??"",
    "packageid": packageid??0,
    "image": image != null ? base64Encode(image!) : null,
  };
}
