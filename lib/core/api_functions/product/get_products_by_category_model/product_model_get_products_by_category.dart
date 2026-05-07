import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import '../../../../../../core/api_functions/product/get_all_product_categories_model/product_category_model.dart';
import '../../../../../../core/language/language_cubit/language_cubit.dart';


class ProductModelGetProductsByCategory {
  final int id;
  final String? name;
  final String? latinName;
  final Uint8List? image;

  final int? price;
  final int? cost;
  final int? inStock;

  final String? description;
  final String? latinDesc;
  final String? instructions;

  final bool? isNew;
  final int? taxId;
  final int? productCategoryId;

  final ProductCategoryModel? category;
  final ProviderModel? provider;

  final List<BrandModel> brands;
  final List<ProductSizeModel> sizes;

  ProductModelGetProductsByCategory({
    required this.id,
    this.name,
    this.latinName,
    this.image,
    this.price,
    this.cost,
    this.inStock,
    this.description,
    this.latinDesc,
    this.instructions,
    this.isNew,
    this.taxId,
    this.productCategoryId,
    this.category,
    this.provider,
    required this.brands,
    required this.sizes,
  });

  factory ProductModelGetProductsByCategory.fromJson(Map<String, dynamic> json) {
    return ProductModelGetProductsByCategory(
      id: json['id'],
      name: json['name'],
      latinName: json['latinname'],
      image: _decodeImage(json['image']),

      price: json['price'],
      cost: json['cost'],
      inStock: json['instock'],

      description: json['description'],
      latinDesc: json['latindesc'],
      instructions: json['instructions'],

      isNew: json['isnew'],
      taxId: json['taxid'],
      productCategoryId: json['productcategoryid'],

      category: json['productCategory'] != null
          ? ProductCategoryModel.fromJson(json['productCategory'])
          : null,

      provider: json['provider'] != null
          ? ProviderModel.fromJson(json['provider'])
          : null,

      brands: (json['brands'] as List?)
          ?.map((e) => BrandModel.fromJson(e))
          .toList() ??
          [],

      sizes: (json['sizes'] as List?)
          ?.map((e) => ProductSizeModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  static Uint8List? _decodeImage(String? base64String) {
    if (base64String == null) return null;
    try {
      return base64Decode(base64String);
    } catch (_) {
      return null;
    }
  }

  String getName(BuildContext context) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;

    return isArabic
        ? (name ?? "")
        : (latinName ?? "");
  }
  String getDescription(BuildContext context) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;

    return isArabic
        ? (description ?? "")
        : (latinName ?? "");
  }
}
class BrandModel {
  final int? brandId;
  final String? brandName;
  final String? brandLatinName;
  final Uint8List? image;

  final List<CarModel> models;

  BrandModel({
    this.brandId,
    this.brandName,
    this.brandLatinName,
    this.image,
    required this.models,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      brandId: json['brandid'],
      brandName: json['brandname'],
      brandLatinName: json['brandlatinname'],
      image: ProductModelGetProductsByCategory._decodeImage(json['image']),

      models: (json['models'] as List?)
          ?.map((e) => CarModel.fromJson(e))
          .toList() ??
          [],
    );
  }
  String getBrandName(BuildContext context) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;

    return isArabic
        ? (brandName ?? "")
        : (brandLatinName ?? "");
  }
}
class CarModel {
  final int? modelId;
  final String? modelName;
  final Uint8List? image;

  CarModel({
    this.modelId,
    this.modelName,
    this.image,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      modelId: json['modelid'],
      modelName: json['modelname'],
      image: ProductModelGetProductsByCategory._decodeImage(json['image']),
    );
  }
}
class ProviderModel {
  final int? id;
  final String? name;
  final String? latinName;
  final Uint8List? image;

  ProviderModel({
    this.id,
    this.name,
    this.latinName,
    this.image,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'],
      name: json['name'],
      latinName: json['latinname'],
      image: ProductModelGetProductsByCategory._decodeImage(json['image']),
    );
  }
}
class ProductSizeModel {
  final int? id;
  final String? name;
  final String? latinName;
  final int? price;
  final int? cost;

  ProductSizeModel({
    this.id,
    this.name,
    this.latinName,
    this.price,
    this.cost,
  });

  factory ProductSizeModel.fromJson(Map<String, dynamic> json) {
    return ProductSizeModel(
      id: json['id'],
      name: json['name'],
      latinName: json['latinname'],
      price: json['price'],
      cost: json['cost'],
    );
  }
}
//--------
//  final ProductCategory? category;
//  String getBrandName(BuildContext context) {
//     if (brands.isEmpty) return "";
//
//     final isArabic =
//         LanguageCubit.get(context).isAllAppLanguageArabic;
//
//     return isArabic
//         ? (brands.first.brandName ?? "")
//         : (brands.first.brandLatinName ?? "");
//   }