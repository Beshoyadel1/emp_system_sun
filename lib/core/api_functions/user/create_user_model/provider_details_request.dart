class ProviderDetailsRequest {
  final int? id;
  final String? name;
  final String? latinname;
  final String? description;
  final String? latindesc;
  final int? provid;
  final String? cr;
  final String? vatno;
  final int? packageid;
  final DateTime? subscriptionstartdate,subscriptionenddate;

  const ProviderDetailsRequest({
    this.id,
    this.name,
    this.latinname,
    this.description,
    this.latindesc,
    this.provid,
    this.cr,
    this.vatno,
    this.packageid,
    this.subscriptionenddate,
    this.subscriptionstartdate
  });

  factory ProviderDetailsRequest.fromJson(Map<String, dynamic> json) =>
      ProviderDetailsRequest(
        id: json["id"],
        name: json["name"],
        latinname: json["latinname"],
        description: json["description"],
        latindesc: json["latindesc"],
        provid: json["provid"],
        cr: json["cr"],
        vatno: json["vatno"],
        packageid: json["packageid"],
        subscriptionstartdate: json["subscriptionstartdate"] != null
            ? DateTime.parse(json["subscriptionstartdate"])
            : null,

        subscriptionenddate: json["subscriptionenddate"] != null
            ? DateTime.parse(json["subscriptionenddate"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "id": id??0,
    "name": name??"",
    "latinname": latinname??"",
    "description": description??"",
    "latindesc": latindesc??"",
    "provid": provid??0,
    "cr": cr??"",
    "vatno": vatno??"",
    "packageid": packageid??0,
    "subscriptionenddate": subscriptionenddate?.toIso8601String(),
    "subscriptionstartdate": subscriptionstartdate?.toIso8601String(),
  };
}
