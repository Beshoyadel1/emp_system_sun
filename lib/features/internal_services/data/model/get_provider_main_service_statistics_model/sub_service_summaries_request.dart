import 'dart:convert';
import 'dart:typed_data';

class SubServiceSummariesRequest {
  final String? serviceName;
  final String? serviceLatinName;
  final Uint8List? image;
  final int? orderCount;
 //image: json["image"] != null ? base64Decode(json["image"]) : null,
//   "image": image != null ? base64Encode(image!) : null,
  SubServiceSummariesRequest({
    this.serviceName,
    this.serviceLatinName,
    this.image,
    this.orderCount,
  });
  factory SubServiceSummariesRequest.fromJson(Map<String, dynamic> json) {
    return SubServiceSummariesRequest(
      serviceName: json["serviceName"],
      serviceLatinName: json["serviceLatinName"],
      image: json["image"] != null ? base64Decode(json["image"]) : null,
      orderCount: json["orderCount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "serviceName": serviceName??"",
      "serviceLatinName": serviceLatinName??"",
      "image": image != null ? base64Encode(image!) : null,
      "orderCount": orderCount,
    };
  }
}