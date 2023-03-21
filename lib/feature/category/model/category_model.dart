import 'package:flutter/material.dart';

import '../../service/model/service_model.dart';

class CategoryModel {
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
  List<Service>? services;


  CategoryModel(
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
        this.services
      });

  CategoryModel.fromJson(Map<String, dynamic> json) {
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
      services = <Service>[];
      json['services'].forEach((v) {
        services!.add(new Service.fromJson(v));
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
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
