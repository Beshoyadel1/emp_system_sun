
import 'package:emp_system_sun/core/api_functions/provider_management/create_service_package_model/car_model_create_service_package_request.dart';

class UpdateServicePackageRequest {
  final int? id;
  final int? provId;
  final String? name;
  final String? latinName;
  final String? items;
  final int? taxId;
  final num? price;
  final List<int>? serviceIds;
  final List<CarModelCreateServicePackageRequest>? cars;

  UpdateServicePackageRequest({
    this.id,
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
      "id": id,
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