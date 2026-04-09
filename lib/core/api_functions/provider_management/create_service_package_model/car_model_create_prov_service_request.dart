class CarModelCreateProvServiceRequest {
  final int? id;
  final int? carBrandId;
  final int? carModelId;
  final int? price;
  final int? cost;

  CarModelCreateProvServiceRequest({
     this.id,
     this.carBrandId,
     this.carModelId,
     this.price,
     this.cost,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "carbrandid": carBrandId,
      "carmodelid": carModelId,
      "price": price,
      "cost": cost,
    };
  }
}