class BrandModelCreateProvServiceRequest {
  final int? id;
  final double? uniformprice;
  final bool? isuniformprice;
  final double? cost;

  BrandModelCreateProvServiceRequest({
     this.id,
     this.uniformprice,
     this.isuniformprice,
     this.cost,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uniformprice": uniformprice,
      "isuniformprice": isuniformprice,
      "cost": cost,
    };
  }
}