class AddTaxRequest {
  final String taxValue;

  AddTaxRequest({
    required this.taxValue,
  });

  Map<String, dynamic> toJson() {
    return {
      "TAXVALUE": taxValue,
    };
  }
}
