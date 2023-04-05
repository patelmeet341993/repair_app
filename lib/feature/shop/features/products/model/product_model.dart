import 'package:repair/utils/parsing_helper.dart';

class ProductModel {
  String responseCode = "";
  String message = "";
  ProductContent? content;
  List<String> errors = [];

  ProductModel({
    this.responseCode = "",
    this.message = "",
    this.content,
    this.errors = const [],
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    responseCode = ParsingHelper.parseStringMethod(json['response_code']);
    message = ParsingHelper.parseStringMethod(json['message']);
    content = json['content'] != null ? new ProductContent.fromJson(json['content']) : null;
    errors = ParsingHelper.parseListMethod(json['errors']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['errors'] = this.errors;
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
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
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
      ParsingHelper.parseListMethod(json['links']).forEach((v) {
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
  String catName = "";
  String companyName = "";
  String productId = "";
  String packateMeasurementAttributeId = "";
  String packateMeasurementAttributeValue = "";
  String packateMeasurementSellPrice = "";
  String packateMeasurementCostPrice = "";
  String packateMeasurementDiscountPrice = "";
  String packateMeasurementShelfLifeVal = "";
  String packateMeasurementShelfLifeUnit = "";
  String packateMeasurementBarcode = "";
  String packateMeasurementFssaiNumber = "";
  int packateMeasurementQty = 0;
  String packateMeasurementImages = "";
  String catNm = "";
  int countOrder = 0;
  List<ProductVariations>? variations;
  List<Features>? features;
  List<Specifications>? specifications;
  List<Shipping>? shipping;
  List<Media>? media;
  List<Subcategory>? subcategory;

  Product(
      {this.id = "",
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
      this.catName = "",
      this.companyName = "",
      this.variations,
      this.features,
      this.specifications,
      this.shipping,
      this.media,
      this.subcategory,
      this.productId = "",
      this.packateMeasurementAttributeId = "",
      this.packateMeasurementAttributeValue = "",
      this.packateMeasurementSellPrice = "",
      this.packateMeasurementCostPrice = "",
      this.packateMeasurementDiscountPrice = "",
      this.packateMeasurementShelfLifeVal = "",
      this.packateMeasurementShelfLifeUnit = "",
      this.packateMeasurementBarcode = "",
      this.packateMeasurementFssaiNumber = "",
      this.packateMeasurementQty = 0,
      this.packateMeasurementImages = "",
      this.catNm = "",
      this.countOrder = 0});

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
    catName = ParsingHelper.parseStringMethod(json['catName']);
    companyName = ParsingHelper.parseStringMethod(json['company_name']);
    productId = ParsingHelper.parseStringMethod(json['product_id']);
    packateMeasurementAttributeId = ParsingHelper.parseStringMethod(json['packate_measurement_attribute_id']);
    packateMeasurementAttributeValue = ParsingHelper.parseStringMethod(json['packate_measurement_attribute_value']);
    packateMeasurementSellPrice = ParsingHelper.parseStringMethod(json['packate_measurement_sell_price']);
    packateMeasurementCostPrice = ParsingHelper.parseStringMethod(json['packate_measurement_cost_price']);
    packateMeasurementDiscountPrice = ParsingHelper.parseStringMethod(json['packate_measurement_discount_price']);
    packateMeasurementShelfLifeVal = ParsingHelper.parseStringMethod(json['packate_measurement_shelf_life_val']);
    packateMeasurementShelfLifeUnit = ParsingHelper.parseStringMethod(json['packate_measurement_shelf_life_unit']);
    packateMeasurementBarcode = ParsingHelper.parseStringMethod(json['packate_measurement_barcode']);
    packateMeasurementFssaiNumber = ParsingHelper.parseStringMethod(json['packate_measurement_fssai_number']);
    packateMeasurementQty = ParsingHelper.parseIntMethod(json['packate_measurement_qty']);
    packateMeasurementImages = ParsingHelper.parseStringMethod(json['packate_measurement_images']);
    catNm = ParsingHelper.parseStringMethod(json['catNm']);
    countOrder = ParsingHelper.parseIntMethod(json['count_order']);
    if (json['variations'] != null) {
      variations = <ProductVariations>[];
      json['variations'].forEach((v) {
        variations!.add(new ProductVariations.fromJson(v));
      });
    }
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    if (json['specifications'] != null) {
      specifications = <Specifications>[];
      json['specifications'].forEach((v) {
        specifications!.add(new Specifications.fromJson(v));
      });
    }
    if (json['shipping'] != null) {
      shipping = <Shipping>[];
      json['shipping'].forEach((v) {
        shipping!.add(new Shipping.fromJson(v));
      });
    }
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(new Subcategory.fromJson(v));
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
    data['catName'] = this.catName;
    data['company_name'] = this.companyName;
    data['product_id'] = this.productId;
    data['packate_measurement_attribute_id'] = this.packateMeasurementAttributeId;
    data['packate_measurement_attribute_value'] = this.packateMeasurementAttributeValue;
    data['packate_measurement_sell_price'] = this.packateMeasurementSellPrice;
    data['packate_measurement_cost_price'] = this.packateMeasurementCostPrice;
    data['packate_measurement_discount_price'] = this.packateMeasurementDiscountPrice;
    data['packate_measurement_shelf_life_val'] = this.packateMeasurementShelfLifeVal;
    data['packate_measurement_shelf_life_unit'] = this.packateMeasurementShelfLifeUnit;
    data['packate_measurement_barcode'] = this.packateMeasurementBarcode;
    data['packate_measurement_fssai_number'] = this.packateMeasurementFssaiNumber;
    data['packate_measurement_qty'] = this.packateMeasurementQty;
    data['packate_measurement_images'] = this.packateMeasurementImages;
    data['catNm'] = this.catNm;
    data['count_order'] = this.countOrder;
    if (this.variations != null) {
      data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    if (this.specifications != null) {
      data['specifications'] = this.specifications!.map((v) => v.toJson()).toList();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.map((v) => v.toJson()).toList();
    }
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductVariations {
  int id = 0;
  String productId = "";
  int groupId = 0;
  String packateMeasurementAttributeId = "";
  String packateMeasurementAttributeValue = "";
  double packateMeasurementSellPrice = 0;
  String packateMeasurementCostPrice = "";
  String packateMeasurementDiscountPrice = "";
  String packateMeasurementShelfLifeVal = "";
  String packateMeasurementShelfLifeUnit = "";
  String packateMeasurementBarcode = "";
  String packateMeasurementFssaiNumber = "";
  int packateMeasurementQty = 0;
  String packateMeasurementImages = "";
  String createdAt = "";
  String updatedAt = "";
  String attributeName = "";
  String attributeValue = "";

  ProductVariations(
      {this.id = 0,
      this.productId = "",
      this.groupId = 0,
      this.packateMeasurementAttributeId = "",
      this.packateMeasurementAttributeValue = "",
      this.packateMeasurementSellPrice = 0,
      this.packateMeasurementCostPrice = "",
      this.packateMeasurementDiscountPrice = "",
      this.packateMeasurementShelfLifeVal = "",
      this.packateMeasurementShelfLifeUnit = "",
      this.packateMeasurementBarcode = "",
      this.packateMeasurementFssaiNumber = "",
      this.packateMeasurementQty = 0,
      this.packateMeasurementImages = "",
      this.createdAt = "",
      this.updatedAt = "",
      this.attributeName = "",
      this.attributeValue = ""});

  ProductVariations.fromJson(Map<String, dynamic> json) {
    id = ParsingHelper.parseIntMethod(json['id']);
    productId = ParsingHelper.parseStringMethod(json['product_id']);
    groupId = ParsingHelper.parseIntMethod(json['group_id']);
    packateMeasurementAttributeId = ParsingHelper.parseStringMethod(json['packate_measurement_attribute_id']);
    packateMeasurementAttributeValue = ParsingHelper.parseStringMethod(json['packate_measurement_attribute_value']);
    packateMeasurementSellPrice = ParsingHelper.parseDoubleMethod(json['packate_measurement_sell_price']);
    packateMeasurementCostPrice = ParsingHelper.parseStringMethod(json['packate_measurement_cost_price']);
    packateMeasurementDiscountPrice = ParsingHelper.parseStringMethod(json['packate_measurement_discount_price']);
    packateMeasurementShelfLifeVal = ParsingHelper.parseStringMethod(json['packate_measurement_shelf_life_val']);
    packateMeasurementShelfLifeUnit = ParsingHelper.parseStringMethod(json['packate_measurement_shelf_life_unit']);
    packateMeasurementBarcode = ParsingHelper.parseStringMethod(json['packate_measurement_barcode']);
    packateMeasurementFssaiNumber = ParsingHelper.parseStringMethod(json['packate_measurement_fssai_number']);
    packateMeasurementQty = ParsingHelper.parseIntMethod(json['packate_measurement_qty']);
    packateMeasurementImages = ParsingHelper.parseStringMethod(json['packate_measurement_images']);
    createdAt = ParsingHelper.parseStringMethod(json['created_at']);
    updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
    attributeName = ParsingHelper.parseStringMethod(json['attribute_name']);
    attributeValue = ParsingHelper.parseStringMethod(json['attribute_value']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['group_id'] = this.groupId;
    data['packate_measurement_attribute_id'] = this.packateMeasurementAttributeId;
    data['packate_measurement_attribute_value'] = this.packateMeasurementAttributeValue;
    data['packate_measurement_sell_price'] = this.packateMeasurementSellPrice;
    data['packate_measurement_cost_price'] = this.packateMeasurementCostPrice;
    data['packate_measurement_discount_price'] = this.packateMeasurementDiscountPrice;
    data['packate_measurement_shelf_life_val'] = this.packateMeasurementShelfLifeVal;
    data['packate_measurement_shelf_life_unit'] = this.packateMeasurementShelfLifeUnit;
    data['packate_measurement_barcode'] = this.packateMeasurementBarcode;
    data['packate_measurement_fssai_number'] = this.packateMeasurementFssaiNumber;
    data['packate_measurement_qty'] = this.packateMeasurementQty;
    data['packate_measurement_images'] = this.packateMeasurementImages;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['attribute_name'] = this.attributeName;
    data['attribute_value'] = this.attributeValue;
    return data;
  }
}

class Features {
  int id = 0;
  String productId = "";
  int groupId = 0;
  String featuresName = "";
  int featuresStatus = 0;
  String createdAt = "";
  String updatedAt = "";

  Features({
    this.id = 0,
    this.productId = "",
    this.groupId = 0,
    this.featuresName = "",
    this.featuresStatus = 0,
    this.createdAt = "",
    this.updatedAt = "",
  });

  Features.fromJson(Map<String, dynamic> json) {
    id = ParsingHelper.parseIntMethod(json['id']);
    productId = ParsingHelper.parseStringMethod(json['product_id']);
    groupId = ParsingHelper.parseIntMethod(json['group_id']);
    featuresName = ParsingHelper.parseStringMethod(json['features_name']);
    featuresStatus = ParsingHelper.parseIntMethod(json['features_status']);
    createdAt = ParsingHelper.parseStringMethod(json['created_at']);
    updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['group_id'] = this.groupId;
    data['features_name'] = this.featuresName;
    data['features_status'] = this.featuresStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Specifications {
  int id = 0;
  String productId = "";
  int groupId = 0;
  String specificationType = "";
  String specificationName = "";
  int specificationStatus = 0;
  String createdAt = "";
  String updatedAt = "";

  Specifications({
    this.id = 0,
    this.productId = "",
    this.groupId = 0,
    this.specificationType = "",
    this.specificationName = "",
    this.specificationStatus = 0,
    this.createdAt = "",
    this.updatedAt = "",
  });

  Specifications.fromJson(Map<String, dynamic> json) {
    id = ParsingHelper.parseIntMethod(json['id']);
    productId = ParsingHelper.parseStringMethod(json['product_id']);
    groupId = ParsingHelper.parseIntMethod(json['group_id']);
    specificationType = ParsingHelper.parseStringMethod(json['specification_type']);
    specificationName = ParsingHelper.parseStringMethod(json['specification_name']);
    specificationStatus = ParsingHelper.parseIntMethod(json['specification_status']);
    createdAt = ParsingHelper.parseStringMethod(json['created_at']);
    updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['group_id'] = this.groupId;
    data['specification_type'] = this.specificationType;
    data['specification_name'] = this.specificationName;
    data['specification_status'] = this.specificationStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Shipping {
  int id = 0;
  int groupId = 0;
  String productId = "";
  String zoneId = "";
  String deliveryCharge = "";
  String createdAt = "";
  String updatedAt = "";

  Shipping({
    this.id = 0,
    this.groupId = 0,
    this.productId = "",
    this.zoneId = "",
    this.deliveryCharge = "",
    this.createdAt = "",
    this.updatedAt = "",
  });

  Shipping.fromJson(Map<String, dynamic> json) {
    id = ParsingHelper.parseIntMethod(json['id']);
    groupId = ParsingHelper.parseIntMethod(json['group_id']);
    productId = ParsingHelper.parseStringMethod(json['product_id']);
    zoneId = ParsingHelper.parseStringMethod(json['zone_id']);
    deliveryCharge = ParsingHelper.parseStringMethod(json['delivery_charge']);
    createdAt = ParsingHelper.parseStringMethod(json['created_at']);
    updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['product_id'] = this.productId;
    data['zone_id'] = this.zoneId;
    data['delivery_charge'] = this.deliveryCharge;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Media {
  int id = 0;
  String productId = "";
  int groupId = 0;
  String otherImages = "";
  String createdAt = "";
  String updatedAt = "";

  Media({
    this.id = 0,
    this.productId = "",
    this.groupId = 0,
    this.otherImages = "",
    this.createdAt = "",
    this.updatedAt = "",
  });

  Media.fromJson(Map<String, dynamic> json) {
    id = ParsingHelper.parseIntMethod(json['id']);
    productId = ParsingHelper.parseStringMethod(json['product_id']);
    groupId = ParsingHelper.parseIntMethod(json['group_id']);
    otherImages = ParsingHelper.parseStringMethod(json['other_images']);
    createdAt = ParsingHelper.parseStringMethod(json['created_at']);
    updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['group_id'] = this.groupId;
    data['other_images'] = this.otherImages;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Subcategory {
  int id = 0;
  String productId = "";
  int groupId = 0;
  String subcategoryId = "";
  String createdAt = "";
  String updatedAt = "";

  Subcategory({
    this.id = 0,
    this.productId = "",
    this.groupId = 0,
    this.subcategoryId = "",
    this.createdAt = "",
    this.updatedAt = "",
  });

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = ParsingHelper.parseIntMethod(json['id']);
    productId = ParsingHelper.parseStringMethod(json['product_id']);
    groupId = ParsingHelper.parseIntMethod(json['group_id']);
    subcategoryId = ParsingHelper.parseStringMethod(json['subcategory_id']);
    createdAt = ParsingHelper.parseStringMethod(json['created_at']);
    updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['group_id'] = this.groupId;
    data['subcategory_id'] = this.subcategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String url = "";
  String label = "";
  bool active = false;

  Links({
    this.url = "",
    this.label = "",
    this.active = false,
  });

  Links.fromJson(Map<String, dynamic> json) {
    url = ParsingHelper.parseStringMethod(json['url']);
    label = ParsingHelper.parseStringMethod(json['label']);
    active = ParsingHelper.parseBoolMethod(json['active']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
