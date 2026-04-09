class EmployeeDetailsRequest {
  final int? id;
  final int? provid;
  final String? jobname;
  final String? joblatinname;
  final int? branchid;

  const EmployeeDetailsRequest({
    this.id,
    this.provid,
    this.jobname,
    this.joblatinname,
    this.branchid,
  });

  factory EmployeeDetailsRequest.fromJson(Map<String, dynamic> json) =>
      EmployeeDetailsRequest(
        id: json["id"],
        provid: json["provid"],
        jobname: json["jobname"],
        joblatinname: json["joblatinname"],
        branchid: json["branchid"],
      );

  Map<String, dynamic> toJson() => {
    "id": id??0,
    "provid": provid??0,
    "jobname": jobname??"",
    "joblatinname": joblatinname??"",
    "branchid": branchid??0,
  };
}