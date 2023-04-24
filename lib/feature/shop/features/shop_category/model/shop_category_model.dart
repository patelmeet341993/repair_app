import 'package:flutter/material.dart';
import 'package:repair/utils/parsing_helper.dart';
import 'package:repair/utils/parsing_helper.dart';
import 'package:repair/utils/parsing_helper.dart';
import 'package:repair/utils/parsing_helper.dart';
import 'package:repair/utils/parsing_helper.dart';
import 'package:repair/utils/parsing_helper.dart';

import '../../products/model/product_model.dart';



class ShopCategoryModel {
  String? id;
  String? parentId;
  String? name;
  String? image;
  int? position;
  var description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  var serviceCount;
  GlobalKey? globalKey;
  List<Product>? product;
  int totalproductsCount = 0;
  List<Product> totalproducts = [];
  List<ProductVariations>? productvariants;


  ShopCategoryModel(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.position,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.serviceCount,
        this.globalKey,
        this.product,
        this.totalproducts = const [],
        this.totalproductsCount = 0,
        this.productvariants
      });

  ShopCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    position = json['position'];
    description = json['description'];
    isActive = int.tryParse(json['is_active'].toString()) == 1 ? true : false;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceCount = json['services_count'];
    totalproductsCount = ParsingHelper.parseIntMethod(json['totalproducts_count']);
    if (json['totalproducts'] != null) {
      totalproducts = <Product>[];
      json['totalproducts'].forEach((v) {
        totalproducts.add(new Product.fromJson(v));
      });
    }
    if (json['productvariants'] != null) {
      productvariants = <ProductVariations>[];
      json['productvariants'].forEach((v) {
        productvariants!.add(new ProductVariations.fromJson(ParsingHelper.parseMapMethod(v)));
      });
    }
    globalKey = GlobalKey(debugLabel: json['id']);
    if (json['services'] != null) {
      product = <Product>[];
      json['services'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['position'] = this.position;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['services_count'] = this.serviceCount;
    if (this.product != null) {
      data['services'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
// class Product {
//   int id = 0;
//   String productId = "";
//   int groupId = 0;
//   String subcategoryId = "";
//   String createdAt = "";
//   String updatedAt = "";
//
//   Product(
//       {this.id = 0,
//         this.productId = "",
//         this.groupId = 0,
//         this.subcategoryId = "",
//         this.createdAt = "",
//         this.updatedAt = ""});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     id = ParsingHelper.parseIntMethod(json['id']);
//     productId = ParsingHelper.parseStringMethod(json['product_id']);
//     groupId = ParsingHelper.parseIntMethod(json['group_id']);
//     subcategoryId = ParsingHelper.parseStringMethod(json['subcategory_id']);
//     createdAt = ParsingHelper.parseStringMethod(json['created_at']);
//     updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['product_id'] = this.productId;
//     data['group_id'] = this.groupId;
//     data['subcategory_id'] = this.subcategoryId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }