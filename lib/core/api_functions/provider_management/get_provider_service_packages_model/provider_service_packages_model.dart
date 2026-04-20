import '../../../../../../core/api_functions/provider_management/get_provider_service_packages_model/package_provider_service_packages_model.dart';
import '../../../../../../core/api_functions/provider_management/get_provider_service_packages_model/service_provider_service_packages_model.dart';

class ProviderServicePackagesModel {
  final PackageProviderServicePackagesModel package;
  final List<ServiceProviderServicePackagesModel> services;

  ProviderServicePackagesModel({
    required this.package,
    required this.services,
  });

  factory ProviderServicePackagesModel.fromJson(Map<String, dynamic> json) {
    return ProviderServicePackagesModel(
      package: PackageProviderServicePackagesModel.fromJson(json['package']),
      services: List<ServiceProviderServicePackagesModel>.from(
        json['services'].map((x) => ServiceProviderServicePackagesModel.fromJson(x)),
      ),
    );
  }
}
