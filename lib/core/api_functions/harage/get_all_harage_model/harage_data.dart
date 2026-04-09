import '../../../../core/api_functions/harage/get_all_harage_model/car_model.dart';
import '../../../../core/api_functions/harage/get_all_harage_model/user_model.dart';

class HarageData {
  final int? id;
  final int? userid;
  final int? usertype;
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
  final UserModel? user;
  final CarModel? car;

  HarageData({
     this.id,
     this.userid,
     this.usertype,
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

  factory HarageData.fromJson(Map<String, dynamic> json) {
    return HarageData(
      id: json['id'],
      userid: json['userid'],
      usertype: json['usertype'],
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
      user: UserModel.fromJson(json['user']),
      car: CarModel.fromJson(json['car']),
    );
  }
}