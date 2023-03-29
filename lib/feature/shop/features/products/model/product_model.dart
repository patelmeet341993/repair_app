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
    content = json['content'] != null ? new ProductContent.fromJson(json['content']) : null;
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
  String id = "";
  int groupId = 0;
  int langId = 0;
  String name = "";
  String description = "";
  String categoryId = "";
  int indicator = 0;
  String sku = "";
  String tags = "";
  String vendor = "";
  String madeIn = "";
  String manufacturer = "";
  String manufacturerPartNo = "";
  String brandIds = "";
  int weight = 0;
  int length = 0;
  int width = 0;
  int height = 0;
  int returnStatus = 0;
  int promoStatus = 0;
  int cancelableStatus = 0;
  String tillStatus = "";
  int bstatus = 0;
  String image = "";
  String videoURL = "";
  String brochure = "";
  String seoPageNm = "";
  String sMetaTitle = "";
  String sMetaKeywords = "";
  String sMetaDescription = "";
  int publishedStatus = 0;
  int showHomePageStatus = 0;
  int reviewStatus = 0;
  String availableStartDt = "";
  String availableEndDt = "";
  int markAsNewStatus = 0;
  int topsellerStatus = 0;
  int indemandStatus = 0;
  int bapprovalst = 0;
  String approvalDt = "";
  int blockProductStatus = 0;
  String blockComment = "";
  String adminComment = "";
  int approveStatus = 0;
  int ratingCount = 0;
  int avgRating = 0;
  int isActive = 0;
  String createdAt = "";
  String updatedAt = "";
  String catNm = "";
  List<ProductVariations>? variations;

  Product({
    this.id = "",
    this.groupId = 0,
    this.langId = 0,
    this.name = "",
    this.description = "",
    this.categoryId = "",
    this.indicator = 0,
    this.sku = "",
    this.tags = "",
    this.vendor = "",
    this.madeIn = "",
    this.manufacturer = "",
    this.manufacturerPartNo = "",
    this.brandIds = "",
    this.weight = 0,
    this.length = 0,
    this.width = 0,
    this.height = 0,
    this.returnStatus = 0,
    this.promoStatus = 0,
    this.cancelableStatus = 0,
    this.tillStatus = "",
    this.bstatus = 0,
    this.image = "",
    this.videoURL = "",
    this.brochure = "",
    this.seoPageNm = "",
    this.sMetaTitle = "",
    this.sMetaKeywords = "",
    this.sMetaDescription = "",
    this.publishedStatus = 0,
    this.showHomePageStatus = 0,
    this.reviewStatus = 0,
    this.availableStartDt = "",
    this.availableEndDt = "",
    this.markAsNewStatus = 0,
    this.topsellerStatus = 0,
    this.indemandStatus = 0,
    this.bapprovalst = 0,
    this.approvalDt = "",
    this.blockProductStatus = 0,
    this.blockComment = "",
    this.adminComment = "",
    this.approveStatus = 0,
    this.ratingCount = 0,
    this.avgRating = 0,
    this.isActive = 0,
    this.createdAt = "",
    this.updatedAt = "",
    this.catNm = "",
    this.variations,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = ParsingHelper.parseStringMethod(json['id']);
    groupId = ParsingHelper.parseIntMethod(json['group_id']);
    langId = ParsingHelper.parseIntMethod(json['lang_id']);
    name = ParsingHelper.parseStringMethod(json['name']);
    description = ParsingHelper.parseStringMethod(json['description']);
    categoryId = ParsingHelper.parseStringMethod(json['category_id']);
    indicator = ParsingHelper.parseIntMethod(json['indicator']);
    sku = ParsingHelper.parseStringMethod(json['sku']);
    tags = ParsingHelper.parseStringMethod(json['tags']);
    vendor = ParsingHelper.parseStringMethod(json['vendor']);
    madeIn = ParsingHelper.parseStringMethod(json['made_in']);
    manufacturer = ParsingHelper.parseStringMethod(json['manufacturer']);
    manufacturerPartNo = ParsingHelper.parseStringMethod(json['manufacturer_part_no']);
    brandIds = ParsingHelper.parseStringMethod(json['brand_ids']);
    weight = ParsingHelper.parseIntMethod(json['weight']);
    length = ParsingHelper.parseIntMethod(json['length']);
    width = ParsingHelper.parseIntMethod(json['width']);
    height = ParsingHelper.parseIntMethod(json['height']);
    returnStatus = ParsingHelper.parseIntMethod(json['return_status']);
    promoStatus = ParsingHelper.parseIntMethod(json['promo_status']);
    cancelableStatus = ParsingHelper.parseIntMethod(json['cancelable_status']);
    tillStatus = ParsingHelper.parseStringMethod(json['till_status']);
    bstatus = ParsingHelper.parseIntMethod(json['bstatus']);
    image = ParsingHelper.parseStringMethod(json['image']);
    videoURL = ParsingHelper.parseStringMethod(json['videoURL']);
    brochure = ParsingHelper.parseStringMethod(json['brochure']);
    seoPageNm = ParsingHelper.parseStringMethod(json['seoPageNm']);
    sMetaTitle = ParsingHelper.parseStringMethod(json['sMetaTitle']);
    sMetaKeywords = ParsingHelper.parseStringMethod(json['sMetaKeywords']);
    sMetaDescription = ParsingHelper.parseStringMethod(json['sMetaDescription']);
    publishedStatus = ParsingHelper.parseIntMethod(json['published_status']);
    showHomePageStatus = ParsingHelper.parseIntMethod(json['show_home_page_status']);
    reviewStatus = ParsingHelper.parseIntMethod(json['review_status']);
    availableStartDt = ParsingHelper.parseStringMethod(json['availableStartDt']);
    availableEndDt = ParsingHelper.parseStringMethod(json['availableEndDt']);
    markAsNewStatus = ParsingHelper.parseIntMethod(json['mark_as_new_status']);
    topsellerStatus = ParsingHelper.parseIntMethod(json['topseller_status']);
    indemandStatus = ParsingHelper.parseIntMethod(json['indemand_status']);
    bapprovalst = ParsingHelper.parseIntMethod(json['bapprovalst']);
    approvalDt = ParsingHelper.parseStringMethod(json['approvalDt']);
    blockProductStatus = ParsingHelper.parseIntMethod(json['block_product_status']);
    blockComment = ParsingHelper.parseStringMethod(json['block_comment']);
    adminComment = ParsingHelper.parseStringMethod(json['adminComment']);
    approveStatus = ParsingHelper.parseIntMethod(json['approve_status']);
    ratingCount = ParsingHelper.parseIntMethod(json['rating_count']);
    avgRating = ParsingHelper.parseIntMethod(json['avg_rating']);
    isActive = ParsingHelper.parseIntMethod(json['is_active']);
    createdAt = ParsingHelper.parseStringMethod(json['created_at']);
    updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
    catNm = ParsingHelper.parseStringMethod(json['catNm']);
    if (json['variations'] != null) {
      variations = <ProductVariations>[];
      json['variations'].forEach((v) {
        variations!.add(new ProductVariations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['lang_id'] = this.langId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['indicator'] = this.indicator;
    data['sku'] = this.sku;
    data['tags'] = this.tags;
    data['vendor'] = this.vendor;
    data['made_in'] = this.madeIn;
    data['manufacturer'] = this.manufacturer;
    data['manufacturer_part_no'] = this.manufacturerPartNo;
    data['brand_ids'] = this.brandIds;
    data['weight'] = this.weight;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['return_status'] = this.returnStatus;
    data['promo_status'] = this.promoStatus;
    data['cancelable_status'] = this.cancelableStatus;
    data['till_status'] = this.tillStatus;
    data['bstatus'] = this.bstatus;
    data['image'] = this.image;
    data['videoURL'] = this.videoURL;
    data['brochure'] = this.brochure;
    data['seoPageNm'] = this.seoPageNm;
    data['sMetaTitle'] = this.sMetaTitle;
    data['sMetaKeywords'] = this.sMetaKeywords;
    data['sMetaDescription'] = this.sMetaDescription;
    data['published_status'] = this.publishedStatus;
    data['show_home_page_status'] = this.showHomePageStatus;
    data['review_status'] = this.reviewStatus;
    data['availableStartDt'] = this.availableStartDt;
    data['availableEndDt'] = this.availableEndDt;
    data['mark_as_new_status'] = this.markAsNewStatus;
    data['topseller_status'] = this.topsellerStatus;
    data['indemand_status'] = this.indemandStatus;
    data['bapprovalst'] = this.bapprovalst;
    data['approvalDt'] = this.approvalDt;
    data['block_product_status'] = this.blockProductStatus;
    data['block_comment'] = this.blockComment;
    data['adminComment'] = this.adminComment;
    data['approve_status'] = this.approveStatus;
    data['rating_count'] = this.ratingCount;
    data['avg_rating'] = this.avgRating;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['catNm'] = this.catNm;

    if (this.variations != null) {
      data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductVariationsAppFormat {
  String? zoneId;
  double? defaultPrice;
  List<ProductZoneWiseVariations>? zoneWiseVariations;

  ProductVariationsAppFormat({this.zoneId, this.defaultPrice, this.zoneWiseVariations});

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
      data['zone_wise_variations'] = this.zoneWiseVariations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductVariations {
  int id = 0;
  String productId = "";
  int groupId = 0;
  String packetMeasurementAttributeId = "";
  String packetMeasurementAttributeValue = "";
  double? packetMeasurementSellPrice;
  String packetMeasurementCostPrice = "";
  String packetMeasurementDiscountPrice = "";
  String packetMeasurementShelfLifeVal = "";
  String packetMeasurementShelfLifeUnit = "";
  String packetMeasurementBarcode = "";
  String packetMeasurementFssaiNumber = "";
  int packetMeasurementQty = 0;
  String? packetMeasurementImages;
  String createdAt = "";
  String updatedAt = "";

  ProductVariations(
      {this.id = 0,
      this.productId = "",
      this.groupId = 0,
      this.packetMeasurementAttributeId = "",
      this.packetMeasurementAttributeValue = "",
      this.packetMeasurementSellPrice = 0,
      this.packetMeasurementCostPrice = "",
      this.packetMeasurementDiscountPrice = "",
      this.packetMeasurementShelfLifeVal = "",
      this.packetMeasurementShelfLifeUnit = "",
      this.packetMeasurementBarcode = "",
      this.packetMeasurementFssaiNumber = "",
      this.packetMeasurementQty = 0,
      this.packetMeasurementImages = "",
      this.createdAt = "",
      this.updatedAt = ""});

  ProductVariations.fromJson(Map<String, dynamic> json) {
    id = ParsingHelper.parseIntMethod(json['id']);
    productId = ParsingHelper.parseStringMethod(json['product_id']);
    groupId = ParsingHelper.parseIntMethod(json['group_id']);
    packetMeasurementAttributeId = ParsingHelper.parseStringMethod(json['packate_measurement_attribute_id']);
    packetMeasurementAttributeValue = ParsingHelper.parseStringMethod(json['packate_measurement_attribute_value']);
    packetMeasurementSellPrice = ParsingHelper.parseDoubleMethod(json['packate_measurement_sell_price']);
    packetMeasurementCostPrice = ParsingHelper.parseStringMethod(json['packate_measurement_cost_price']);
    packetMeasurementDiscountPrice = ParsingHelper.parseStringMethod(json['packate_measurement_discount_price']);
    packetMeasurementShelfLifeVal = ParsingHelper.parseStringMethod(json['packate_measurement_shelf_life_val']);
    packetMeasurementShelfLifeUnit = ParsingHelper.parseStringMethod(json['packate_measurement_shelf_life_unit']);
    packetMeasurementBarcode = ParsingHelper.parseStringMethod(json['packate_measurement_barcode']);
    packetMeasurementFssaiNumber = ParsingHelper.parseStringMethod(json['packate_measurement_fssai_number']);
    packetMeasurementQty = ParsingHelper.parseIntMethod(json['packate_measurement_qty']);
    packetMeasurementImages = ParsingHelper.parseStringMethod(json['packate_measurement_images']);
    createdAt = ParsingHelper.parseStringMethod(json['created_at']);
    updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['group_id'] = this.groupId;
    data['packate_measurement_attribute_id'] = this.packetMeasurementAttributeId;
    data['packate_measurement_attribute_value'] = this.packetMeasurementAttributeValue;
    data['packate_measurement_sell_price'] = this.packetMeasurementSellPrice;
    data['packate_measurement_cost_price'] = this.packetMeasurementCostPrice;
    data['packate_measurement_discount_price'] = this.packetMeasurementDiscountPrice;
    data['packate_measurement_shelf_life_val'] = this.packetMeasurementShelfLifeVal;
    data['packate_measurement_shelf_life_unit'] = this.packetMeasurementShelfLifeUnit;
    data['packate_measurement_barcode'] = this.packetMeasurementBarcode;
    data['packate_measurement_fssai_number'] = this.packetMeasurementFssaiNumber;
    data['packate_measurement_qty'] = this.packetMeasurementQty;
    data['packate_measurement_images'] = this.packetMeasurementImages;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProductZoneWiseVariations {
  String? variantKey;
  String? variantName;
  num? price;

  ProductZoneWiseVariations({
    this.variantKey,
    this.variantName,
    this.price,
  });

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

  ProductCategory({
    this.id,
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

  ProductZonesBasicInfo({this.id, this.name, this.coordinates, this.isActive, this.createdAt, this.updatedAt, this.pivot});

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

  ProductFaqs({this.id, this.question, this.answer, this.serviceId, this.isActive, this.createdAt, this.updatedAt});

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

  ProductDiscount({this.id, this.discountId, this.discountType, this.typeWiseId, this.createdAt, this.updatedAt, this.productDiscount});

  ProductDiscount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountId = json['discount_id'];
    discountType = json['discount_type'];
    typeWiseId = json['type_wise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productDiscount = json['discount'] != null ? new CouponProductDiscount.fromJson(json['discount']) : null;
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
