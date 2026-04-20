class UpdateHarageRequest {
  final int? id;
  final int? userId;
  final int? userType;
  final bool? isNew;
  final String? releaseDate;
  final int? transmissionType;
  final int? fuelType;
  final int? kilometers;
  final String? description;
  final String? addressText;
  final num? price;
  final num? cost;
  final bool? isSold;
  final int? commentsNumber;
  final String? sellDate;

  final UpdateHarageUser? user;
  final UpdateHarageCar? car;

  UpdateHarageRequest({
    this.id,
    this.userId,
    this.userType,
    this.isNew,
    this.releaseDate,
    this.transmissionType,
    this.fuelType,
    this.kilometers,
    this.description,
    this.addressText,
    this.price,
    this.cost,
    this.isSold,
    this.commentsNumber,
    this.sellDate,
    this.user,
    this.car,
  });

  factory UpdateHarageRequest.fromJson(Map<String, dynamic> json) {
    return UpdateHarageRequest(
      id: json['id'],
      userId: json['userid'],
      userType: json['usertype'],
      isNew: json['isnew'],
      releaseDate: json['releasedate'],
      transmissionType: json['transmissiontype'],
      fuelType: json['fueltype'],
      kilometers: json['kilometers'],
      description: json['description'],
      addressText: json['addresstext'],
      price: json['price'],
      cost: json['cost'],
      isSold: json['issold'],
      commentsNumber: json['commentsnumber'],
      sellDate: json['selldate'],
      user: json['user'] != null
          ? UpdateHarageUser.fromJson(json['user'])
          : null,
      car: json['car'] != null
          ? UpdateHarageCar.fromJson(json['car'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      if (userId != null) "userid": userId,
      if (userType != null) "usertype": userType,
      if (isNew != null) "isnew": isNew,
      if (releaseDate != null) "releasedate": releaseDate,
      if (transmissionType != null)
        "transmissiontype": transmissionType,
      if (fuelType != null) "fueltype": fuelType,
      if (kilometers != null) "kilometers": kilometers,
      if (description != null) "description": description,
      if (addressText != null) "addresstext": addressText,
      if (price != null) "price": price,
      if (cost != null) "cost": cost,
      if (isSold != null) "issold": isSold,
      if (commentsNumber != null)
        "commentsnumber": commentsNumber,
      if (sellDate != null) "selldate": sellDate,

      if (user != null) "user": user!.toJson(),
      if (car != null) "car": car!.toJson(),
    };
  }
}
class UpdateHarageUser {
  final int? id;
  final int? type;
  final String? name;
  final String? latinName;
  final String? image;
  final String? branchName;
  final String? branchLatinName;

  UpdateHarageUser({
    this.id,
    this.type,
    this.name,
    this.latinName,
    this.image,
    this.branchName,
    this.branchLatinName,
  });

  factory UpdateHarageUser.fromJson(Map<String, dynamic> json) {
    return UpdateHarageUser(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      latinName: json['latinname'],
      image: json['image'],
      branchName: json['branchname'],
      branchLatinName: json['branchlatinname'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      if (type != null) "type": type,
      if (name != null) "name": name,
      if (latinName != null) "latinname": latinName,
      if (image != null) "image": image,
      if (branchName != null) "branchname": branchName,
      if (branchLatinName != null)
        "branchlatinname": branchLatinName,
    };
  }
}
class UpdateHarageCar {
  final int? id;
  final String? brandName;
  final String? brandLatinName;
  final String? brandImage;
  final String? modelName;
  final String? carImage;

  UpdateHarageCar({
    this.id,
    this.brandName,
    this.brandLatinName,
    this.brandImage,
    this.modelName,
    this.carImage,
  });

  factory UpdateHarageCar.fromJson(Map<String, dynamic> json) {
    return UpdateHarageCar(
      id: json['id'],
      brandName: json['brandname'],
      brandLatinName: json['brandlatinname'],
      brandImage: json['brandimage'],
      modelName: json['modelname'],
      carImage: json['carimage'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      if (brandName != null) "brandname": brandName,
      if (brandLatinName != null)
        "brandlatinname": brandLatinName,
      if (brandImage != null) "brandimage": brandImage,
      if (modelName != null) "modelname": modelName,
      if (carImage != null) "carimage": carImage,
    };
  }
}