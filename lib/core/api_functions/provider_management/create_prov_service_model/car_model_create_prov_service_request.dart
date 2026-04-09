class CarModelCreateProvServiceRequest {
  final int? id;
  final int? carbrandid;
  final int? carmodelid;
  final double? price;
  final double? cost;

  CarModelCreateProvServiceRequest({
     this.id,
     this.carbrandid,
     this.carmodelid,
     this.price,
     this.cost,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "carbrandid": carbrandid,
      "carmodelid": carmodelid,
      "price": price,
      "cost": cost,
    };
  }
}