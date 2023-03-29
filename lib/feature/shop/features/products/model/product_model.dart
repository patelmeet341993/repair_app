import 'dart:async';

import 'package:repair/data/model/response/config_model.dart';
import 'package:repair/feature/shop/features/product_coupon/model/product_coupon_model.dart';
import 'package:repair/utils/parsing_helper.dart';

import '../../../../../data/model/response/error_response.dart';

class ProductModel {
  String? responseCode;
  String? message;
  ProductContent? content;
  List<Errors>? errors;

  ProductModel({this.responseCode, this.message, this.content, this.errors});

  ProductModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? new ProductContent.fromJson(json['content']) : null;
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(new Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductContent {
  int? currentPage;
  List<Product>? productList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  var nextPageUrl;
  String? path;
  String? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  ProductContent(
      {this.currentPage,
        this.productList,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  ProductContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      productList = <Product>[];
      json['data'].forEach((v) {
        productList!.add(new Product.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.productList != null) {
      data['data'] = this.productList!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Product {
  String? id;
  int? groupId;
  int? langId;
  String? name;
  String? shortDescription;
  String? description;
  String? coverImage;
  String? thumbnail;
  String? categoryId;
  String? subCategoryId;
  var tax;
  int? orderCount;
  int? isActive;
  int? ratingCount;
  double? avgRating;
  String? createdAt;
  String? updatedAt;
  ProductCategory? category;
  ProductVariationsAppFormat? variationsAppFormat;
  List<ProductVariations>? variations;
  List<ProductFaqs>? faqs;
  List<ProductDiscount>? productDiscount;
  List<ProductDiscount>? campaignDiscount;

  Product(
      {this.id,
        this.langId,
        this.groupId,
        this.name,
        this.shortDescription,
        this.description,
        this.coverImage,
        this.thumbnail,
        this.categoryId,
        this.subCategoryId,
        this.tax,
        this.orderCount,
        this.isActive,
        this.ratingCount,
        this.avgRating,
        this.createdAt,
        this.updatedAt,
        this.category,
        this.variationsAppFormat,
        this.variations,
        this.faqs,
        this.productDiscount,
        this.campaignDiscount,
      });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    langId = json['lang_id'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    coverImage = json['cover_image'];
    thumbnail = json['thumbnail'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    tax = json['tax'];
    orderCount = json['order_count'];
    isActive = json['is_active'];
    ratingCount = json['rating_count'];
    avgRating = ParsingHelper.parseDoubleMethod(json['avg_rating']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    variationsAppFormat = json['variations_app_format'] != null
        ? new ProductVariationsAppFormat.fromJson(json['variations_app_format'])
        : null;

    if (json['variations'] != null) {
      variations = <ProductVariations>[];
      json['variations'].forEach((v) {
        variations!.add(new ProductVariations.fromJson(v));
      });
    }

    category = json['category'] != null
        ? new ProductCategory.fromJson(json['category'])
        : null;
    if (json['faqs'] != null) {
      faqs = <ProductFaqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(new ProductFaqs.fromJson(v));
      });
    }
    if (json['service_discount'] != null) {
      productDiscount = <ProductDiscount>[];
      json['service_discount'].forEach((v) {
        productDiscount!.add(new ProductDiscount.fromJson(v));
      });
    }
    if (json['campaign_discount'] != null) {
      campaignDiscount = <ProductDiscount>[];
      json['campaign_discount'].forEach((v) {
        campaignDiscount!.add(new ProductDiscount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['lang_id'] = this.langId;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['cover_image'] = this.coverImage;
    data['thumbnail'] = this.thumbnail;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['tax'] = this.tax;
    data['order_count'] = this.orderCount;
    data['is_active'] = this.isActive;
    data['rating_count'] = this.ratingCount;
    data['avg_rating'] = this.avgRating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.variationsAppFormat != null) {
      data['variations_app_format'] = this.variationsAppFormat!.toJson();
    }

    if (this.variations != null) {
      data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }

    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.faqs != null) {
      data['faqs'] = this.faqs!.map((v) => v.toJson()).toList();
    }
    if (this.productDiscount != null) {
      data['service_discount'] = this.productDiscount!.map((v) => v.toJson()).toList();
    }
    if (this.campaignDiscount != null) {
      data['campaign_discount'] = this.campaignDiscount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductVariationsAppFormat {
  String? zoneId;
  double? defaultPrice;
  List<ProductZoneWiseVariations>? zoneWiseVariations;

  ProductVariationsAppFormat(
      {this.zoneId, this.defaultPrice, this.zoneWiseVariations});

  ProductVariationsAppFormat.fromJson(Map<String, dynamic> json) {
    zoneId = json['zone_id'];
    defaultPrice = json['default_price'].toDouble();
    if (json['zone_wise_variations'] != null) {
      zoneWiseVariations = <ProductZoneWiseVariations>[];
      json['zone_wise_variations'].forEach((v) {
        zoneWiseVariations!.add(new ProductZoneWiseVariations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zone_id'] = this.zoneId;
    data['default_price'] = this.defaultPrice;
    if (this.zoneWiseVariations != null) {
      data['zone_wise_variations'] =
          this.zoneWiseVariations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductVariations {
  int? id;
  String? variant;
  String? variantKey;
  String? serviceId;
  String? zoneId;
  num? price;
  String? createdAt;
  String? updatedAt;
  Zone? zone;

  ProductVariations(
      {this.id,
        this.variant,
        this.variantKey,
        this.serviceId,
        this.zoneId,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.zone});

  ProductVariations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    variant = json['variant'];
    variantKey = json['variant_key'];
    serviceId = json['service_id'];
    zoneId = json['zone_id'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['variant'] = this.variant;
    data['variant_key'] = this.variantKey;
    data['service_id'] = this.serviceId;
    data['zone_id'] = this.zoneId;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProductZoneWiseVariations {
  String? variantKey;
  String? variantName;
  num? price;

  ProductZoneWiseVariations({this.variantKey, this.variantName, this.price,});

  ProductZoneWiseVariations.fromJson(Map<String, dynamic> json) {
    variantKey = json['variant_key'];
    variantName = json['variant_name'];
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_key'] = this.variantKey;
    data['variant_name'] = this.variantName;
    data['price'] = this.price;
    return data;
  }
}

class ProductCategory {
  String? id;
  String? parentId;
  String? name;
  String? image;
  int? position;
  var description;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  List<ProductZonesBasicInfo>? zonesBasicInfo;
  List<ProductDiscount>? categoryDiscount;
  List<ProductDiscount>? campaignDiscount;


  ProductCategory(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.position,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.zonesBasicInfo,
        this.categoryDiscount,
        this.campaignDiscount,
      });

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    position = json['position'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['zones_basic_info'] != null) {
      zonesBasicInfo = <ProductZonesBasicInfo>[];
      json['zones_basic_info'].forEach((v) {
        zonesBasicInfo!.add(new ProductZonesBasicInfo.fromJson(v));
      });
    }
    if (json['category_discount'] != null) {
      categoryDiscount = <ProductDiscount>[];
      json['category_discount'].forEach((v) {
        categoryDiscount!.add(new ProductDiscount.fromJson(v));
      });
    }
    if (json['campaign_discount'] != null) {
      campaignDiscount = <ProductDiscount>[];
      json['campaign_discount'].forEach((v) {
        campaignDiscount!.add(new ProductDiscount.fromJson(v));
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
    if (this.zonesBasicInfo != null) {
      data['zones_basic_info'] = this.zonesBasicInfo!.map((v) => v.toJson()).toList();
    }
    if (this.categoryDiscount != null) {
      data['category_discount'] = this.categoryDiscount!.map((v) => v.toJson()).toList();
    }
    if (this.campaignDiscount != null) {
      data['campaign_discount'] = this.campaignDiscount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductZonesBasicInfo {
  String? id;
  String? name;
  List<Coordinates>? coordinates;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  ProductZonesBasicInfo(
      {this.id,
        this.name,
        this.coordinates,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  ProductZonesBasicInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['coordinates'] != null) {
      coordinates = <Coordinates>[];
      json['coordinates'].forEach((v) {
        coordinates!.add(new Coordinates.fromJson(v));
      });
    }
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.map((v) => v.toJson()).toList();
    }
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class ProductFaqs {
  String? id;
  String? question;
  String? answer;
  String? serviceId;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  ProductFaqs(
      {this.id,
        this.question,
        this.answer,
        this.serviceId,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  ProductFaqs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    serviceId = json['service_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['service_id'] = this.serviceId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProductDiscount {
  int? id;
  String? discountId;
  String? discountType;
  String? typeWiseId;
  String? createdAt;
  String? updatedAt;
  CouponProductDiscount? productDiscount;

  ProductDiscount(
      {this.id,
        this.discountId,
        this.discountType,
        this.typeWiseId,
        this.createdAt,
        this.updatedAt,
        this.productDiscount});

  ProductDiscount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountId = json['discount_id'];
    discountType = json['discount_type'];
    typeWiseId = json['type_wise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productDiscount = json['discount'] != null
        ? new CouponProductDiscount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount_id'] = this.discountId;
    data['discount_type'] = this.discountType;
    data['type_wise_id'] = this.typeWiseId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.productDiscount != null) {
      data['discount'] = this.productDiscount!.toJson();
    }
    return data;
  }
}
