class BrandModelCreateProvServiceRequest {
  final int? id;
  final int? uniFormPrice;
  final bool? isUniFormPrice;
  final int? cost;

  BrandModelCreateProvServiceRequest({
     this.id,
     this.uniFormPrice,
     this.isUniFormPrice,
     this.cost,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uniformprice": uniFormPrice,
      "isuniformprice": isUniFormPrice,
      "cost": cost,
    };
  }
}