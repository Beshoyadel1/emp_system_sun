class UpdateTaxRequest {
  final int taxId;
  final int taxValue;

  UpdateTaxRequest({
    required this.taxId,
    required this.taxValue,

  });

  Map<String, dynamic> toJson() {
    return {
      "TAXID": taxId,
      "TAXVALUE": taxValue,
    };
  }
}