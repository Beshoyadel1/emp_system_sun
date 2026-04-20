import '../../../../../../core/api_functions/provider_management/create_prov_service_model/brand_model_create_prov_service_request.dart';
import '../../../../../../core/api_functions/provider_management/create_prov_service_model/car_model_create_prov_service_request.dart';

class CreateProvServiceRequest {
  final int? serviceid;
  final int? provid;
  final int? taxid;
  final String? name;
  final String? latinname;
  final List<BrandModelCreateProvServiceRequest>? brands;
  final List<CarModelCreateProvServiceRequest>? cars;

  CreateProvServiceRequest({
     this.serviceid,
     this.provid,
     this.taxid,
     this.name,
     this.latinname,
     this.brands,
     this.cars,
  });

  Map<String, dynamic> toJson() {
    return {
      "serviceid": serviceid,
      "provid": provid,
      "taxid": taxid,
      "name": name,
      "latinname": latinname,
      "brands": brands?.map((e) => e.toJson()).toList()??[],
      "cars": cars?.map((e) => e.toJson()).toList()??[],
    };
  }
}