import 'package:repair/utils/parsing_helper.dart';

import 'package:repair/utils/parsing_helper.dart';

class ProductBookingModel {
  String responseCode = "";
  String message = "";
  ProductBookingContent? content;
  List<String> errors = [];

  ProductBookingModel({this.responseCode = "", this.message = "", this.content, this.errors = const []});

  ProductBookingModel.fromJson(Map<String, dynamic> json) {
    responseCode = ParsingHelper.parseStringMethod(json['response_code']);
    message = ParsingHelper.parseStringMethod(json['message']);
    content = json['content'] != null ? new ProductBookingContent.fromJson(json['content']) : null;
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

class ProductBookingContent {
  int currentPage = 0;
  List<BookingData> data = [];
  String firstPageUrl = "";
  int from = 0;
  int lastPage = 0;
  String lastPageUrl = "";
  List<Links> links = [];
  String nextPageUrl = '';
  String path = "";
  String perPage = "";
  String prevPageUrl = '';
  int to = 0;
  int total = 0;

  ProductBookingContent(
      {this.currentPage = 0,
      this.data = const [],
      this.firstPageUrl = "",
      this.from = 0,
      this.lastPage = 0,
      this.lastPageUrl = "",
      this.links = const [],
      this.nextPageUrl = "",
      this.path = "",
      this.perPage = "",
      this.prevPageUrl = "",
      this.to = 0,
      this.total = 0});

  ProductBookingContent.fromJson(Map<String, dynamic> json) {
    currentPage = ParsingHelper.parseIntMethod(json['current_page']);
    if (json['data'] != null) {
      data = <BookingData>[];
      ParsingHelper.parseListMethod(json['data']).forEach((v) {
        data.add(new BookingData.fromJson(v));
      });
    }
    firstPageUrl = ParsingHelper.parseStringMethod(json['first_page_url']);
    from = ParsingHelper.parseIntMethod(json['from']);
    lastPage = ParsingHelper.parseIntMethod(json['last_page']);
    lastPageUrl = ParsingHelper.parseStringMethod(json['last_page_url']);
    if (json['links'] != null) {
      links = <Links>[];
      ParsingHelper.parseListMethod(json['links']).forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = ParsingHelper.parseStringMethod(json['next_page_url']);
    path = ParsingHelper.parseStringMethod(json['path']);
    perPage = ParsingHelper.parseStringMethod(json['per_page']);
    prevPageUrl = ParsingHelper.parseStringMethod(json['prev_page_url']);
    to = ParsingHelper.parseIntMethod(json['to']);
    total = ParsingHelper.parseIntMethod(json['total']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['links'] = this.links.map((v) => v.toJson()).toList();
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class BookingData {
  String id = "";
  int readableId = 0;
  String customerId = "";
  String providerId = "";
  String providerSelectedIds = "";
  String zoneId = "";
  String bookingStatus = "";
  int isPaid = 0;
  String paymentMethod = "";
  String transactionId = "";
  double totalBookingAmount = 0.0;
  int totalTaxAmount = 0;
  double totalDiscountAmount = 0.0;
  String serviceSchedule = "";
  String serviceAddressId = "";
  String createdAt = "";
  String updatedAt = "";
  String categoryId = "";
  String subCategoryId = "";
  String servicemanId = "";
  int totalCampaignDiscountAmount = 0;
  int totalCouponDiscountAmount = 0;
  String couponCode = "";
  int isChecked = 0;
  Customer? customer;

  BookingData(
      {this.id = "",
      this.readableId = 0,
      this.customerId = "",
      this.providerId = "",
      this.providerSelectedIds = "",
      this.zoneId = "",
      this.bookingStatus = "",
      this.isPaid = 0,
      this.paymentMethod = "",
      this.transactionId = "",
      this.totalBookingAmount = 0,
      this.totalTaxAmount = 0,
      this.totalDiscountAmount = 0,
      this.serviceSchedule = "",
      this.serviceAddressId = "",
      this.createdAt = "",
      this.updatedAt = "",
      this.categoryId = "",
      this.subCategoryId = "",
      this.servicemanId = "",
      this.totalCampaignDiscountAmount = 0,
      this.totalCouponDiscountAmount = 0,
      this.couponCode = "",
      this.isChecked = 0,
      this.customer});

  BookingData.fromJson(Map<String, dynamic> json) {
    id = ParsingHelper.parseStringMethod(json['id']);
    readableId = ParsingHelper.parseIntMethod(json['readable_id']);
    customerId = ParsingHelper.parseStringMethod(json['customer_id']);
    providerId = ParsingHelper.parseStringMethod(json['provider_id']);
    providerSelectedIds = ParsingHelper.parseStringMethod(json['provider_selected_ids']);
    zoneId = ParsingHelper.parseStringMethod(json['zone_id']);
    bookingStatus = ParsingHelper.parseStringMethod(json['booking_status']);
    isPaid = ParsingHelper.parseIntMethod(json['is_paid']);
    paymentMethod = ParsingHelper.parseStringMethod(json['payment_method']);
    transactionId = ParsingHelper.parseStringMethod(json['transaction_id']);
    totalBookingAmount = ParsingHelper.parseDoubleMethod(json['total_booking_amount']);
    totalTaxAmount = ParsingHelper.parseIntMethod(json['total_tax_amount']);
    totalDiscountAmount = ParsingHelper.parseDoubleMethod(json['total_discount_amount']);
    serviceSchedule = ParsingHelper.parseStringMethod(json['service_schedule']);
    serviceAddressId = ParsingHelper.parseStringMethod(json['service_address_id']);
    createdAt = ParsingHelper.parseStringMethod(json['created_at']);
    updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
    categoryId = ParsingHelper.parseStringMethod(json['category_id']);
    subCategoryId = ParsingHelper.parseStringMethod(json['sub_category_id']);
    servicemanId = ParsingHelper.parseStringMethod(json['serviceman_id']);
    totalCampaignDiscountAmount = ParsingHelper.parseIntMethod(json['total_campaign_discount_amount']);
    totalCouponDiscountAmount = ParsingHelper.parseIntMethod(json['total_coupon_discount_amount']);
    couponCode = ParsingHelper.parseStringMethod(json['coupon_code']);
    isChecked = ParsingHelper.parseIntMethod(json['is_checked']);
    customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['readable_id'] = this.readableId;
    data['customer_id'] = this.customerId;
    data['provider_id'] = this.providerId;
    data['provider_selected_ids'] = this.providerSelectedIds;
    data['zone_id'] = this.zoneId;
    data['booking_status'] = this.bookingStatus;
    data['is_paid'] = this.isPaid;
    data['payment_method'] = this.paymentMethod;
    data['transaction_id'] = this.transactionId;
    data['total_booking_amount'] = this.totalBookingAmount;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['total_discount_amount'] = this.totalDiscountAmount;
    data['service_schedule'] = this.serviceSchedule;
    data['service_address_id'] = this.serviceAddressId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['serviceman_id'] = this.servicemanId;
    data['total_campaign_discount_amount'] = this.totalCampaignDiscountAmount;
    data['total_coupon_discount_amount'] = this.totalCouponDiscountAmount;
    data['coupon_code'] = this.couponCode;
    data['is_checked'] = this.isChecked;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
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
  List<String> identificationImage = [];
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

class Links {
  String url = "";
  String label = "";
  bool active = false;

  Links({this.url = "", this.label = "", this.active = false});

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
