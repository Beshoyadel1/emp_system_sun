
import '../../../../../../core/api_functions/provider_management/create_prov_service_model/brand_model_create_prov_service_request.dart';
import '../../../../../../core/api_functions/provider_management/create_prov_service_model/car_model_create_prov_service_request.dart';

class UpdateProvServiceRequest {
  final int? id;
  final int? serviceId;
  final int? provId;
  final int? taxId;
  final String? name;
  final String? latinName;
  final double? uniformprice;
  final double? cost;
  final bool? isuniformprice;
  final List<BrandModelCreateProvServiceRequest>? brands;
  final List<CarModelCreateProvServiceRequest>? cars;

  UpdateProvServiceRequest({
    this.id,
    this.serviceId,
    this.provId,
    this.taxId,
    this.name,
    this.latinName,
    this.brands,
    this.cars,
    this.cost,
    this.uniformprice,
    this.isuniformprice,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "serviceid": serviceId,
    "provid": provId,
    "taxid": taxId,
    "name": name,
    "latinname": latinName,
    "cost": cost,
    "uniformprice": uniformprice,
    "isuniformprice": isuniformprice,
    "brands": brands?.map((e) => e.toJson()).toList(),
    "cars": cars?.map((e) => e.toJson()).toList(),
  };
}