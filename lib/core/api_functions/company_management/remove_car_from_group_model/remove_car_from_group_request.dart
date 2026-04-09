class RemoveCarFromGroupRequest {
  final int groupId;
  final int carId;
  RemoveCarFromGroupRequest({
    required this.groupId,
    required this.carId,
  });

  Map<String, dynamic> toJson() {
    return {
      "groupId": groupId,
      "carId": carId,
    };
  }
}
