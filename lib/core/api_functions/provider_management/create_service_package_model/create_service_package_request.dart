import '../../../../../../core/api_functions/provider_management/create_service_package_model/car_model_create_service_package_request.dart';

class CreateServicePackageRequest {
  final int? provId;
  final String? name;
  final String? latinName;
  final String? items;
  final int? taxId;
  final num? price;
  final List<int>? serviceIds;
  final List<CarModelCreateServicePackageRequest>? cars;

  CreateServicePackageRequest({
     this.provId,
     this.name,
     this.latinName,
     this.items,
     this.taxId,
     this.price,
     this.serviceIds,
     this.cars,
  });

  Map<String, dynamic> toJson() {
    return {
      "provid": provId,
      "name": name,
      "latinname": latinName,
      "items": items,
      "taxid": taxId,
      "price": price,
      "serviceIds": serviceIds,
      "cars": cars?.map((e) => e.toJson()).toList(),
    };
  }
}