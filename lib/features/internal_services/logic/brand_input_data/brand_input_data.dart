class BrandInputData {
  int selectedOption; // 0 = unified / 1 = per category
  String? unifiedPrice;
  Map<int, String> modelPrices; // modelId -> price

  BrandInputData({
    this.selectedOption = 0,
    this.unifiedPrice,
    Map<int, String>? modelPrices,

  }) : modelPrices = modelPrices ?? {};
}
