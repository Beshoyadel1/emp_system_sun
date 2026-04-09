class GetExpectedPetrolSpendRequest {
  final int userId;
  final int branchId;

  GetExpectedPetrolSpendRequest({
    required this.userId,
    required this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "branchId": branchId,
    };
  }
}