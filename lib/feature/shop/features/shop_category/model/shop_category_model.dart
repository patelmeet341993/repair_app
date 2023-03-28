import 'package:flutter/material.dart';

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
        this.product
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
