class DeleteTaxRequest {
  final int taxId;

  DeleteTaxRequest({
    required this.taxId,
  });

  Map<String, dynamic> toJson() {
    return {
      "taxId": taxId,
    };
  }
}