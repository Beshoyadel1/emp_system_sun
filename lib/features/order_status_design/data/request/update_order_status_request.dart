class UpdateOrderStatusRequest {
  final int orderId;
  final int status;
  final List<int>? employeeIds;
  final int? changedById;
  final int? changedByType;

  UpdateOrderStatusRequest({
    required this.orderId,
    required this.status,
    this.employeeIds,
    this.changedById,
    this.changedByType,
  });

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "status": status,
      if (changedById != null) "changedById": changedById,
      if (changedByType != null) "changedByType": changedByType,
    };
  }
}
