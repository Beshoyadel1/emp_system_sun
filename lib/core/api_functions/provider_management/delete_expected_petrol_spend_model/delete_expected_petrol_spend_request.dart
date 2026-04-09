class DeleteExpectedPetrolSpendRequest {
  final int id;

  DeleteExpectedPetrolSpendRequest({
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }
}

