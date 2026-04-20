class GetTaxModel {
  final int taxId;
  final int taxPercentage;

  GetTaxModel({
    required this.taxId,
    required this.taxPercentage,
  });

  factory GetTaxModel.fromJson(Map<String, dynamic> json) {
    return GetTaxModel(
      taxId: json['taxid'],
      taxPercentage: json['taxpercentage'],
    );
  }
}