class AssignServiceToEmployeeRequest {
  final int employeeId;
  final int provServiceId;

  AssignServiceToEmployeeRequest({
    required this.employeeId,
    required this.provServiceId,

  });

  Map<String, dynamic> toJson() {
    return {
      "employeeId": employeeId,
      "provServiceId": provServiceId,
    };
  }
}
