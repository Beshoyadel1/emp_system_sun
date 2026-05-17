class ServicePackageModel {
  final String? packageName;
  final String? packageLatinName;
  final String? items;
  final int? id;
  final int? orderId;
  final int? servicePackageId;
  final num? price;
  final num? taxPercentage;
  final int? quantity;
  final num? totalPrice;
  final int? carId;

  ServicePackageModel({
     this.packageName,
     this.packageLatinName,
     this.items,
     this.id,
     this.orderId,
     this.servicePackageId,
     this.price,
     this.taxPercentage,
     this.quantity,
     this.totalPrice,
     this.carId,
  });

  factory ServicePackageModel.fromJson(Map<String, dynamic> json) {
    return ServicePackageModel(
      packageName: json['packagename'],
      packageLatinName: json['packagelatinname'],
      items: json['items'],
      id: json['id'] ?? 0,
      orderId: json['orderid'] ?? 0,
      servicePackageId: json['servicepackageid'] ?? 0,
      price: json['price'] ?? 0,
      taxPercentage: json['taxpercentage'] ?? 0,
      quantity: json['quantity'] ?? 0,
      totalPrice: json['totalprice'] ?? 0,
      carId: json['carid'] ?? 0,
    );
  }
}