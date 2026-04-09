class AddCarToGroupRequest {
  final int groupId;
  final int carId;
  AddCarToGroupRequest({
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
