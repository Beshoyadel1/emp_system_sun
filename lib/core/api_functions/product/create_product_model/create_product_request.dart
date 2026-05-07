import 'dart:convert';
import 'dart:typed_data';


class CreateProductRequest {
  final int? provId;
  final String? name;
  final String? latinName;
  final Uint8List? image;
  final int? taxId;
  final int? productCategoryId;
  final String? description;
  final String? latinDesc;
  final int? price;
  final int? cost;
  final int? inStock;
  final String? instructions;
  final bool? isNew;

  final List<ProductBrand>? brands;
  final List<ProductCarModel>? carModels;
  final List<ProductSize>? sizes;

  CreateProductRequest({
    this.provId,
    this.name,
    this.latinName,
    this.image,
    this.taxId,
    this.productCategoryId,
    this.description,
    this.latinDesc,
    this.price,
    this.cost,
    this.inStock,
    this.instructions,
    this.isNew,
    this.brands,
    this.carModels,
    this.sizes,
  });

  CreateProductRequest copyWith({
    int? provId,
    String? name,
    String? latinName,
    Uint8List? image,
    int? taxId,
    int? productCategoryId,
    String? description,
    String? latinDesc,
    int? price,
    int? cost,
    int? inStock,
    String? instructions,
    bool? isNew,
    List<ProductBrand>? brands,
    List<ProductCarModel>? carModels,
    List<ProductSize>? sizes,
  }) {
    return CreateProductRequest(
      provId: provId ?? this.provId,
      name: name ?? this.name,
      latinName: latinName ?? this.latinName,
      image: image ?? this.image,
      taxId: taxId ?? this.taxId,
      productCategoryId: productCategoryId ?? this.productCategoryId,
      description: description ?? this.description,
      latinDesc: latinDesc ?? this.latinDesc,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      inStock: inStock ?? this.inStock,
      instructions: instructions ?? this.instructions,
      isNew: isNew ?? this.isNew,
      brands: brands ?? this.brands,
      carModels: carModels ?? this.carModels,
      sizes: sizes ?? this.sizes,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (provId != null) data["provid"] = provId;
    if (name != null) data["name"] = name;
    if (latinName != null) data["latinname"] = latinName;
    if (image != null) data["image"] = base64Encode(image!);
    if (taxId != null) data["taxid"] = taxId;
    if (productCategoryId != null) {
      data["productcategoryid"] = productCategoryId;
    }
    if (description != null) data["description"] = description;
    if (latinDesc != null) data["latindesc"] = latinDesc;
    if (price != null) data["price"] = price;
    if (cost != null) data["cost"] = cost;
    if (inStock != null) data["instock"] = inStock;
    if (instructions != null) data["instructions"] = instructions;
    if (isNew != null) data["isnew"] = isNew;

    if (brands != null) {
      data["brands"] = brands!.map((e) => e.toJson()).toList();
    }

    if (carModels != null) {
      data["carModels"] = carModels!.map((e) => e.toJson()).toList();
    }

    if (sizes != null) {
      data["sizes"] = sizes!.map((e) => e.toJson()).toList();
    }

    return data;
  }
}

class ProductBrand {
  final int? brandid;

  ProductBrand({this.brandid});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (brandid != null) data["brandid"] = brandid;
    return data;
  }
}

class ProductCarModel {
  final int? productCarBrandId;
  final int? carBrandId;
  final int? carModelId;

  ProductCarModel({
    this.productCarBrandId,
    this.carBrandId,
    this.carModelId,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (productCarBrandId != null) {
      data["productcarbrandid"] = productCarBrandId;
    }
    if (carBrandId != null) data["carbrandid"] = carBrandId;
    if (carModelId != null) data["carmodelid"] = carModelId;
    return data;
  }
}

class ProductSize {
  final int? provId;
  final String? name;
  final String? latinName;
  final int? price;
  final int? cost;

  ProductSize({
    this.provId,
    this.name,
    this.latinName,
    this.price,
    this.cost,
  });

  ProductSize copyWith({
    int? provId,
    String? name,
    String? latinName,
    int? price,
    int? cost,
  }) {
    return ProductSize(
      provId: provId ?? this.provId,
      name: name ?? this.name,
      latinName: latinName ?? this.latinName,
      price: price ?? this.price,
      cost: cost ?? this.cost,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (provId != null) data["provid"] = provId;
    if (name != null) data["name"] = name;
    if (latinName != null) data["latinname"] = latinName;
    if (price != null) data["price"] = price;
    if (cost != null) data["cost"] = cost;

    return data;
  }
}