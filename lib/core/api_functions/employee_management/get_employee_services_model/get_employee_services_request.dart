class GetEmployeeServicesRequest {
  final int employeeId;

  GetEmployeeServicesRequest({
    required this.employeeId,

  });

  Map<String, dynamic> toJson() {
    return {
      "employeeId": employeeId,
    };
  }
}