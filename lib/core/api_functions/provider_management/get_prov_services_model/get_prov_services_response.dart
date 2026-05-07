class GetProvServicesResponse {
  final ProvService provService;
  final List<BrandItem> brands;

  GetProvServicesResponse({
    required this.provService,
    required this.brands,
  });

  factory GetProvServicesResponse.fromJson(Map<String, dynamic> json) {
    return GetProvServicesResponse(
      provService: ProvService.fromJson(json['provService']),
      brands: (json['brands'] as List)
          .map((e) => BrandItem.fromJson(e))
          .toList(),
    );
  }
}
class ProvService {
  final int id;
  final int serviceid;
  final int provid;
  final int taxid;
  final String name;
  final String latinname;
  final double uniformprice;
  final double cost;
  final bool isuniformprice;

  ProvService({
    required this.id,
    required this.serviceid,
    required this.provid,
    required this.taxid,
    required this.name,
    required this.latinname,
    required this.uniformprice,
    required this.cost,
    required this.isuniformprice,
  });

  factory ProvService.fromJson(Map<String, dynamic> json) {
    return ProvService(
      id: json['id'],
      serviceid: json['serviceid'],
      provid: json['provid'],
      taxid: json['taxid'],
      name: json['name'],
      latinname: json['latinname'],
      uniformprice: (json['uniformprice'] as num?)?.toDouble() ?? 0.0,
      cost: (json['cost'] as num?)?.toDouble() ?? 0.0,
      isuniformprice: (json['isuniformprice'] as bool?) ?? false,
    );
  }
}
class BrandItem {
  final ProvServiceBrand provServiceBrand;
  final List<ModelItem> models;

  BrandItem({
    required this.provServiceBrand,
    required this.models,
  });

  factory BrandItem.fromJson(Map<String, dynamic> json) {
    return BrandItem(
      provServiceBrand:
      ProvServiceBrand.fromJson(json['provServiceBrand']),
      models: (json['models'] as List)
          .map((e) => ModelItem.fromJson(e))
          .toList(),
    );
  }
}
class ProvServiceBrand {
  final int id;
  final int provserviceid;
  final int brandid;
  final double? uniformprice;
  final bool isuniformprice;
  final double? cost;

  ProvServiceBrand({
    required this.id,
    required this.provserviceid,
    required this.brandid,
    required this.uniformprice,
    required this.isuniformprice,
    required this.cost,
  });

  factory ProvServiceBrand.fromJson(Map<String, dynamic> json) {
    return ProvServiceBrand(
      id: json['id'],
      provserviceid: json['provserviceid'],
      brandid: json['brandid'],
      uniformprice: json['uniformprice']?.toDouble(),
      isuniformprice: (json['isuniformprice'] as bool?) ?? false,
      cost: json['cost']?.toDouble(),
    );
  }
}
class ModelItem {
  final int id;
  final int provserviceid;
  final int carbrandid;
  final int carmodelid;
  final double price;
  final double cost;

  ModelItem({
    required this.id,
    required this.provserviceid,
    required this.carbrandid,
    required this.carmodelid,
    required this.price,
    required this.cost,
  });

  factory ModelItem.fromJson(Map<String, dynamic> json) {
    return ModelItem(
      id: json['id'],
      provserviceid: json['provserviceid'],
      carbrandid: json['carbrandid'],
      carmodelid: json['carmodelid'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      cost: (json['cost'] as num?)?.toDouble() ?? 0.0,
    );
  }
}