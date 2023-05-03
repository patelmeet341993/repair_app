import 'package:repair/utils/parsing_helper.dart';

class ProductCartModel {
  String responseCode = "";
  String message = "";
  ProductContent? content;
  List<String> errors = [];

  ProductCartModel({this.responseCode = "", this.message = "", this.content, this.errors = const []});

  ProductCartModel.fromJson(Map<String, dynamic> json) {
    responseCode = ParsingHelper.parseStringMethod(json['response_code']);
    message = ParsingHelper.parseStringMethod(json['message']);
    content = json['content'] != null ? new ProductContent.fromJson(json['content']) : null;
    errors = json['errors'].cast<String>();
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
  List<CartProductModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  String? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  ProductContent(
      {this.currentPage,
      this.data,
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
      data = <CartProductModel>[];
      json['data'].forEach((v) {
        data!.add(new CartProductModel.fromJson(v));
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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

class CartProductModel {
  String id = "";
  String productId = "";
  String orderNo = "";
  String orderNoVendor = "";
  String userId = "";
  int orderId = 0;
  int pvID = 0;
  int productVariantId = 0;
  int quantity = 0;
  double price = 0.0;
  double discountedPrice = 0.0;
  double campaignDiscount = 0.0;
  double couponDiscount = 0.0;
  double taxAmount = 0.0;
  int discount = 0;
  double subTotal = 0.0;
  String deliverBy = "";
  String status = "";
  String activeStatus = "";
  int cartStatus = 0;
  String dateAdded = "";
  int isActive = 0;
  bool isFromSubCategory = false;
  String createdAt = "";
  String updatedAt = "";
  String productName = "";
  Customer? customer;
  ProductVariant? productVariant;

  CartProductModel(
      {this.id = "",
      this.productId = "",
      this.orderNo = "",
      this.orderNoVendor = "",
      this.userId = "",
      this.orderId = 0,
      this.pvID = 0,
      this.productVariantId = 0,
      this.quantity = 0,
      this.price = 0,
      this.discountedPrice = 0,
      this.campaignDiscount = 0,
      this.couponDiscount = 0,
      this.taxAmount = 0,
      this.discount = 0,
      this.subTotal = 0,
      this.deliverBy = "",
      this.status = "",
      this.activeStatus = "",
      this.cartStatus = 0,
      this.dateAdded = "",
      this.isActive = 0,
      this.createdAt = "",
      this.updatedAt = "",
      this.isFromSubCategory = false,
      this.productName = "",
      this.customer,
      this.productVariant});

  CartProductModel.fromJson(Map<String, dynamic> json) {
    id = ParsingHelper.parseStringMethod(json['id']);
    orderNo = ParsingHelper.parseStringMethod(json['order_no']);
    orderNoVendor = ParsingHelper.parseStringMethod(json['order_no_vendor']);
    userId = ParsingHelper.parseStringMethod(json['user_id']);
    orderId = ParsingHelper.parseIntMethod(json['order_id']);
    productVariantId = ParsingHelper.parseIntMethod(json['product_variant_id']);
    quantity = ParsingHelper.parseIntMethod(json['quantity']);
    price = ParsingHelper.parseDoubleMethod(json['price']);
    discountedPrice = ParsingHelper.parseDoubleMethod(json['discounted_price']);
    campaignDiscount = ParsingHelper.parseDoubleMethod(json['campaign_discount']);
    couponDiscount = ParsingHelper.parseDoubleMethod(json['coupon_discount']);
    taxAmount = ParsingHelper.parseDoubleMethod(json['tax_amount']);
    discount = ParsingHelper.parseIntMethod(json['discount']);
    subTotal = ParsingHelper.parseDoubleMethod(json['sub_total']);
    deliverBy = ParsingHelper.parseStringMethod(json['deliver_by']);
    status = ParsingHelper.parseStringMethod(json['status']);
    activeStatus = ParsingHelper.parseStringMethod(json['active_status']);
    cartStatus = ParsingHelper.parseIntMethod(json['cart_status']);
    dateAdded = ParsingHelper.parseStringMethod(json['date_added']);
    isActive = ParsingHelper.parseIntMethod(json['is_active']);
    productId = ParsingHelper.parseStringMethod(json['product_id']);
    createdAt = ParsingHelper.parseStringMethod(json['created_at']);
    updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
    productName = ParsingHelper.parseStringMethod(json['product_name']);
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
    productVariant = json['productvariant'] != null ? new ProductVariant.fromJson(json['productvariant']) : null;
  }

  CartProductModel copyWith({String? cartId, int? cartQuantity, bool subisFromSubCategory = false }) {
    if (cartId != null) {
      id = cartId;
    }

    if (cartQuantity != null) {
      quantity = cartQuantity;
    }
    if(subisFromSubCategory) {
      isFromSubCategory = subisFromSubCategory;
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    data['order_no_vendor'] = this.orderNoVendor;
    data['user_id'] = this.userId;
    data['order_id'] = this.orderId;
    data['product_variant_id'] = this.productVariantId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['discounted_price'] = this.discountedPrice;
    data['discount'] = this.discount;
    data['campaign_discount'] = this.campaignDiscount;
    data['coupon_discount'] = this.couponDiscount;
    data['tax_amount'] = this.taxAmount;
    data['sub_total'] = this.subTotal;
    data['deliver_by'] = this.deliverBy;
    data['status'] = this.status;
    data['active_status'] = this.activeStatus;
    data['cart_status'] = this.cartStatus;
    data['date_added'] = this.dateAdded;
    data['is_active'] = this.isActive;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_name'] = this.productName;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.productVariant != null) {
      data['productvariant'] = this.productVariant!.toJson();
    }
    return data;
  }
}

class Customer {
  String id = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String phone = "";
  String identificationNumber = "";
  String identificationType = "";
  List<String>? identificationImage;
  String dateOfBirth = "";
  String gender = "";
  String profileImage = "";
  String fcmToken = "";
  int isPhoneVerified = 0;
  int isEmailVerified = 0;
  String phoneVerifiedAt = "";
  String emailVerifiedAt = "";
  int isActive = 0;
  String userType = "";
  String rememberToken = "";
  String deletedAt = "";
  String createdAt = "";
  String updatedAt = "";

  Customer(
      {this.id = "",
      this.firstName = "",
      this.lastName = "",
      this.email = "",
      this.phone = "",
      this.identificationNumber = "",
      this.identificationType = "",
      this.identificationImage = const [],
      this.dateOfBirth = "",
      this.gender = "",
      this.profileImage = "",
      this.fcmToken = "",
      this.isPhoneVerified = 0,
      this.isEmailVerified = 0,
      this.phoneVerifiedAt = "",
      this.emailVerifiedAt = "",
      this.isActive = 0,
      this.userType = "",
      this.rememberToken = "",
      this.deletedAt = "",
      this.createdAt = "",
      this.updatedAt = ""});

  Customer.fromJson(Map<String, dynamic> json) {
    id = ParsingHelper.parseStringMethod(json['id']);
    firstName = ParsingHelper.parseStringMethod(json['first_name']);
    lastName = ParsingHelper.parseStringMethod(json['last_name']);
    email = ParsingHelper.parseStringMethod(json['email']);
    phone = ParsingHelper.parseStringMethod(json['phone']);
    identificationNumber = ParsingHelper.parseStringMethod(json['identification_number']);
    identificationType = ParsingHelper.parseStringMethod(json['identification_type']);
    identificationImage = ParsingHelper.parseListMethod(json['identification_image']);
    dateOfBirth = ParsingHelper.parseStringMethod(json['date_of_birth']);
    gender = ParsingHelper.parseStringMethod(json['gender']);
    profileImage = ParsingHelper.parseStringMethod(json['profile_image']);
    fcmToken = ParsingHelper.parseStringMethod(json['fcm_token']);
    isPhoneVerified = ParsingHelper.parseIntMethod(json['is_phone_verified']);
    isEmailVerified = ParsingHelper.parseIntMethod(json['is_email_verified']);
    phoneVerifiedAt = ParsingHelper.parseStringMethod(json['phone_verified_at']);
    emailVerifiedAt = ParsingHelper.parseStringMethod(json['email_verified_at']);
    isActive = ParsingHelper.parseIntMethod(json['is_active']);
    userType = ParsingHelper.parseStringMethod(json['user_type']);
    rememberToken = ParsingHelper.parseStringMethod(json['remember_token']);
    deletedAt = ParsingHelper.parseStringMethod(json['deleted_at']);
    createdAt = ParsingHelper.parseStringMethod(json['created_at']);
    updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['identification_number'] = this.identificationNumber;
    data['identification_type'] = this.identificationType;
    data['identification_image'] = this.identificationImage;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['fcm_token'] = this.fcmToken;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['is_email_verified'] = this.isEmailVerified;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['is_active'] = this.isActive;
    data['user_type'] = this.userType;
    data['remember_token'] = this.rememberToken;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProductVariant {
  int id = 0;
  String productId = "";
  int groupId = 0;
  String packateMeasurementAttributeId = "";
  String packateMeasurementAttributeValue = "";
  double packateMeasurementSellPrice = 0.0;
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

  ProductVariant(
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
      this.updatedAt = ""});

  ProductVariant.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
