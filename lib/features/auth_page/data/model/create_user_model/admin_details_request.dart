class AdminDetailsRequest {
  final int? id;
  final String? jobname;
  final String? joblatinname;

  const AdminDetailsRequest({
    this.id,
    this.jobname,
    this.joblatinname,
  });

  factory AdminDetailsRequest.fromJson(Map<String, dynamic> json) => AdminDetailsRequest(
    id: json["id"],
    jobname: json["jobname"],
    joblatinname: json["joblatinname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id??0,
    "jobname": jobname??"",
    "joblatinname": joblatinname??"",
  };
}