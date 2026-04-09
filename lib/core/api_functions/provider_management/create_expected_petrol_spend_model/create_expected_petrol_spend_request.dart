class CreateExpectedPetrolSpendRequest {
  final int userId;
  final int userType;
  final int expectedSpend;

  CreateExpectedPetrolSpendRequest({
    required this.userId,
    required this.userType,
    required this.expectedSpend,
  });

  Map<String, dynamic> toJson() {
    return {
      "USERID": userId,
      "USERTYPE": userType,
      "EXPECTEDSPEND": expectedSpend,
    };
  }
}
