import 'package:repair/utils/parsing_helper.dart';

class ServiceBookingList {
  String? responseCode;
  String? message;
  BookingContent? content;

  ServiceBookingList({
    this.responseCode,
    this.message,
    this.content,
  });

  ServiceBookingList.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? new BookingContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }

    return data;
  }
}

class BookingContent {
  int? currentPage;
  List<BookingModel>? bookingModel;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  String? perPage;
  int? to;
  int? total;

  BookingContent(
      {this.currentPage, this.bookingModel, this.firstPageUrl, this.from, this.lastPage, this.lastPageUrl, this.path, this.perPage, this.to, this.total});

  BookingContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      bookingModel = <BookingModel>[];
      json['data'].forEach((v) {
        bookingModel!.add(new BookingModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.bookingModel != null) {
      data['data'] = this.bookingModel!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class BookingModel {
  String id = "";
  int readableId = 0;
  String customerId = "";
  String providerId = "";
  String zoneId = "";
  String bookingStatus = "";
  int isPaid = 0;
  String paymentMethod = "";
  String transactionId = "";
  double totalBookingAmount = 0.0;
  double totalTaxAmount = 0.0;
  double totalDiscountAmount = 0.0;
  String serviceSchedule = "";
  String serviceAddressId = "";
  String createdAt = "";
  String updatedAt = "";
  String categoryId = "";
  String subCategoryId = "";
  String servicemanId = "";

  BookingModel(
      {this.id = "",
      this.readableId = 0,
      this.customerId = "",
      this.providerId = "",
      this.zoneId = "",
      this.bookingStatus = "",
      this.isPaid = 0,
      this.paymentMethod = "",
      this.transactionId = "",
      this.totalBookingAmount = 0.0,
      this.totalTaxAmount = 0.0,
      this.totalDiscountAmount = 0.0,
      this.serviceSchedule = "",
      this.serviceAddressId = "",
      this.createdAt = "",
      this.updatedAt = "",
      this.categoryId = "",
      this.subCategoryId = "",
      this.servicemanId = ""});

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = ParsingHelper.parseStringMethod(json['id']);
    readableId = ParsingHelper.parseIntMethod(json['readable_id']);
    customerId = ParsingHelper.parseStringMethod(json['customer_id']);
    providerId = ParsingHelper.parseStringMethod(json['provider_id']);
    zoneId = ParsingHelper.parseStringMethod(json['zone_id']);
    bookingStatus = ParsingHelper.parseStringMethod(json['booking_status']);
    isPaid = ParsingHelper.parseIntMethod(json['is_paid']);
    paymentMethod = ParsingHelper.parseStringMethod(json['payment_method']);
    transactionId = ParsingHelper.parseStringMethod(json['transaction_id']);
    totalBookingAmount = ParsingHelper.parseDoubleMethod(json['total_booking_amount']);
    totalTaxAmount = ParsingHelper.parseDoubleMethod(json['total_tax_amount']);
    totalDiscountAmount = ParsingHelper.parseDoubleMethod(json['total_discount_amount']);
    serviceSchedule = ParsingHelper.parseStringMethod(json['service_schedule']);
    serviceAddressId = ParsingHelper.parseStringMethod(json['service_address_id']);
    createdAt = ParsingHelper.parseStringMethod(json['created_at']);
    updatedAt = ParsingHelper.parseStringMethod(json['updated_at']);
    categoryId = ParsingHelper.parseStringMethod(json['category_id']);
    subCategoryId = ParsingHelper.parseStringMethod(json['sub_category_id']);
    servicemanId = ParsingHelper.parseStringMethod(json['serviceman_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['readable_id'] = this.readableId;
    data['customer_id'] = this.customerId;
    data['provider_id'] = this.providerId;
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
    return data;
  }
}
