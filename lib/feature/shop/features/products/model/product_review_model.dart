

import 'package:repair/core/core_export.dart';
import 'package:repair/data/model/response/config_model.dart';

class ProductReviewModel {
  String? responseCode;
  String? message;
  ProductReviewContent? content;

  ProductReviewModel({this.responseCode, this.message, this.content});

  ProductReviewModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? new ProductReviewContent.fromJson(json['content']) : null;
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

class ProductReviewContent {
  ProductReviews? reviews;
  ProductRating? rating;

  ProductReviewContent({this.reviews, this.rating});

  ProductReviewContent.fromJson(Map<String, dynamic> json) {
    reviews =
    json['reviews'] != null ? new ProductReviews.fromJson(json['reviews']) : null;
    rating =
    json['rating'] != null ? new ProductRating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.toJson();
    }
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    return data;
  }
}

class ProductReviews {
  int? currentPage;
  List<ProductReviewData>? reviewList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  String? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  ProductReviews(
      {this.currentPage,
        this.reviewList,
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

  ProductReviews.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      reviewList = <ProductReviewData>[];
      json['data'].forEach((v) {
        reviewList!.add(new ProductReviewData.fromJson(v));
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
    if (this.reviewList != null) {
      data['data'] = this.reviewList!.map((v) => v.toJson()).toList();
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

class ProductReviewData {
  String? id;
  String? bookingId;
  String? serviceId;
  String? providerId;
  double? reviewRating;
  String? reviewComment;
  String? bookingDate;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  Customer? customer;

  ProductReviewData(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.providerId,
        this.reviewRating,
        this.reviewComment,
        this.bookingDate,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.customer,
      });

  ProductReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    providerId = json['provider_id'];
    reviewRating = json['review_rating'].toDouble();
    reviewComment = json['review_comment'];
    bookingDate = json['booking_date'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['service_id'] = this.serviceId;
    data['provider_id'] = this.providerId;
    data['review_rating'] = this.reviewRating;
    data['review_comment'] = this.reviewComment;
    data['booking_date'] = this.bookingDate;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class ProductRating {
  num? ratingCount;
  num? averageRating;
  List<ProductRatingGroupCount>? ratingGroupCount;

  ProductRating({this.ratingCount, this.averageRating, this.ratingGroupCount});

  ProductRating.fromJson(Map<String, dynamic> json) {
    ratingCount = json['rating_count'];
    averageRating = json['average_rating'];
    if (json['rating_group_count'] != null) {
      ratingGroupCount = <ProductRatingGroupCount>[];
      json['rating_group_count'].forEach((v) {
        ratingGroupCount!.add(new ProductRatingGroupCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating_count'] = this.ratingCount;
    data['average_rating'] = this.averageRating;
    if (this.ratingGroupCount != null) {
      data['rating_group_count'] =
          this.ratingGroupCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductRatingGroupCount {
  double? reviewRating;
  double? total;

  ProductRatingGroupCount({this.reviewRating, this.total});

  ProductRatingGroupCount.fromJson(Map<String, dynamic> json) {
    reviewRating = json['review_rating'] != null ? double.parse(json['review_rating'].toString()) : null;
    total = json['total'] != null ? double.parse(json['total'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_rating'] = this.reviewRating;
    data['total'] = this.total;
    return data;
  }
}