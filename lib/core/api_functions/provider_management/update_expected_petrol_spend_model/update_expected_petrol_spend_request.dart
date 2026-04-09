class UpdateExpectedPetrolSpendRequest {
  final int id;
  final int expectedSpend;

  UpdateExpectedPetrolSpendRequest({
    required this.id,
    required this.expectedSpend,
  });

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "EXPECTEDSPEND": expectedSpend,
    };
  }
}