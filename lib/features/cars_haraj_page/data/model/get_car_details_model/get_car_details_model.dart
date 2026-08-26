import 'dart:typed_data';

class GetCarDetailsModel {
  final CarInfoModel? carInfo;
  final SummaryModel? summary;
  final FuelConsumptionModel? fuelConsumption;
  final List<ServiceStatsModel> serviceStats;
  final List<RecentInvoiceModel> recentInvoices;
  final List<DriverModel> drivers;

  GetCarDetailsModel({
    this.carInfo,
    this.summary,
    this.fuelConsumption,
    this.serviceStats = const [],
    this.recentInvoices = const [],
    this.drivers = const [],
  });

  factory GetCarDetailsModel.fromJson(Map<String, dynamic> json) {
    return GetCarDetailsModel(
      carInfo: json['carInfo'] != null
          ? CarInfoModel.fromJson(json['carInfo'])
          : null,
      summary: json['summary'] != null
          ? SummaryModel.fromJson(json['summary'])
          : null,
      fuelConsumption: json['fuelConsumption'] != null
          ? FuelConsumptionModel.fromJson(json['fuelConsumption'])
          : null,
      serviceStats: (json['serviceStats'] as List?)
          ?.map(
            (e) => ServiceStatsModel.fromJson(e),
      )
          .toList() ??
          [],
      recentInvoices: (json['recentInvoices'] as List?)
          ?.map(
            (e) => RecentInvoiceModel.fromJson(e),
      )
          .toList() ??
          [],
      drivers: (json['drivers'] as List?)
          ?.map(
            (e) => DriverModel.fromJson(e),
      )
          .toList() ??
          [],
    );
  }
}

class CarInfoModel {
  final int? id;
  final int? releaseDate;
  final int? ownerId;
  final int? ownerType;
  final String? chassisNo;
  final String? plateNo;
  final String? insuranceNo;
  final Uint8List? licenceImage;
  final String? name;
  final CarBrandModel? brand;
  final CarModelBrandDataModel? model;

  CarInfoModel({
    this.id,
    this.releaseDate,
    this.ownerId,
    this.ownerType,
    this.chassisNo,
    this.plateNo,
    this.insuranceNo,
    this.licenceImage,
    this.name,
    this.brand,
    this.model,
  });

  factory CarInfoModel.fromJson(Map<String, dynamic> json) {
    return CarInfoModel(
      id: json['id'],
      releaseDate: json['releasedate'],
      ownerId: json['ownerid'],
      ownerType: json['ownertype'],
      chassisNo: json['chassisno'],
      plateNo: json['plateno'],
      insuranceNo: json['insuranceno'],
      licenceImage: json['licenceimage'] is List
          ? Uint8List.fromList(
        List<int>.from(json['licenceimage']),
      )
          : null,
      name: json['name'],
      brand: json['brand'] != null
          ? CarBrandModel.fromJson(json['brand'])
          : null,
      model: json['model'] != null
          ? CarModelBrandDataModel.fromJson(json['model'])
          : null,
    );
  }
}

class CarBrandModel {
  final int? carBrandId;
  final String? brandName;
  final String? brandLatinName;
  final Uint8List? image;

  CarBrandModel({
    this.carBrandId,
    this.brandName,
    this.brandLatinName,
    this.image,
  });

  factory CarBrandModel.fromJson(Map<String, dynamic> json) {
    return CarBrandModel(
      carBrandId: json['carbrandid'],
      brandName: json['brandname'],
      brandLatinName: json['brandlatinname'],
      image: json['image'] is List
          ? Uint8List.fromList(
        List<int>.from(json['image']),
      )
          : null,
    );
  }
}

class CarModelBrandDataModel {
  final int? carModelId;
  final String? modelName;
  final Uint8List? image;

  CarModelBrandDataModel({
    this.carModelId,
    this.modelName,
    this.image,
  });

  factory CarModelBrandDataModel.fromJson(Map<String, dynamic> json) {
    return CarModelBrandDataModel(
      carModelId: json['carmodelid'],
      modelName: json['modelname'],
      image: json['image'] is List
          ? Uint8List.fromList(
        List<int>.from(json['image']),
      )
          : null,
    );
  }
}

class SummaryModel {
  final double? totalInvoices;
  final double? totalPetrol;
  final int? maintenanceCount;
  final int? refuelCount;

  SummaryModel({
    this.totalInvoices,
    this.totalPetrol,
    this.maintenanceCount,
    this.refuelCount,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      totalInvoices: (json['totalInvoices'] as num?)?.toDouble(),
      totalPetrol: (json['totalPetrol'] as num?)?.toDouble(),
      maintenanceCount: json['maintenanceCount'],
      refuelCount: json['refuelCount'],
    );
  }
}

class FuelConsumptionModel {
  final double? consumptionPercentage;
  final double? totalConsumption;
  final double? expectedSpend;

  FuelConsumptionModel({
    this.consumptionPercentage,
    this.totalConsumption,
    this.expectedSpend,
  });

  factory FuelConsumptionModel.fromJson(Map<String, dynamic> json) {
    return FuelConsumptionModel(
      consumptionPercentage:
      (json['consumptionPercentage'] as num?)?.toDouble(),
      totalConsumption:
      (json['totalConsumption'] as num?)?.toDouble(),
      expectedSpend:
      (json['expectedSpend'] as num?)?.toDouble(),
    );
  }
}

class ServiceStatsModel {
  final String? serviceName;
  final String? serviceLatinName;
  final double? value;
  final double? percentage;

  ServiceStatsModel({
    this.serviceName,
    this.serviceLatinName,
    this.value,
    this.percentage,
  });

  factory ServiceStatsModel.fromJson(Map<String, dynamic> json) {
    return ServiceStatsModel(
      serviceName: json['serviceName'],
      serviceLatinName: json['serviceLatinName'],
      value: (json['value'] as num?)?.toDouble(),
      percentage: (json['percentage'] as num?)?.toDouble(),
    );
  }
}

class RecentInvoiceModel {
  final int? id;
  final DateTime? date;
  final String? categoryName;
  final double? amount;

  RecentInvoiceModel({
    this.id,
    this.date,
    this.categoryName,
    this.amount,
  });

  factory RecentInvoiceModel.fromJson(Map<String, dynamic> json) {
    return RecentInvoiceModel(
      id: json['id'],
      date: json['date'] != null
          ? DateTime.tryParse(json['date'])
          : null,
      categoryName: json['categoryName'],
      amount: (json['amount'] as num?)?.toDouble(),
    );
  }
}

class DriverModel {
  DriverModel();

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel();
  }
}