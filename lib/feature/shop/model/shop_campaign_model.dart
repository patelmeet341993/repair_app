class ShopCampaignContent {
  int? currentPage;
  List<ShopCampaignData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<ShopLinks>? links;
  var nextPageUrl;
  String? path;
  String? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  ShopCampaignContent(
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

  ShopCampaignContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ShopCampaignData>[];
      json['data'].forEach((v) {
        data!.add(new ShopCampaignData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <ShopLinks>[];
      json['links'].forEach((v) {
        links!.add(new ShopLinks.fromJson(v));
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

class ShopCampaignData {
  String? id;
  String? campaignName;
  String? coverImage;
  String? thumbnail;
  String? discountId;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  ShopDiscount? discount;

  ShopCampaignData(
      {this.id,
        this.campaignName,
        this.coverImage,
        this.thumbnail,
        this.discountId,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.discount});

  ShopCampaignData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campaignName = json['campaign_name'];
    coverImage = json['cover_image'];
    thumbnail = json['thumbnail'];
    discountId = json['discount_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discount = json['discount'] != null
        ? new ShopDiscount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['campaign_name'] = this.campaignName;
    data['cover_image'] = this.coverImage;
    data['thumbnail'] = this.thumbnail;
    data['discount_id'] = this.discountId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.discount != null) {
      data['discount'] = this.discount!.toJson();
    }
    return data;
  }
}

class ShopDiscount {
  String? id;
  String? discountTitle;
  String? discountType;
  int? discountAmount;
  String? discountAmountType;
  int? minPurchase;
  int? maxDiscountAmount;
  int? limitPerUser;
  String? promotionType;
  int? isActive;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  ShopDiscount(
      {this.id,
        this.discountTitle,
        this.discountType,
        this.discountAmount,
        this.discountAmountType,
        this.minPurchase,
        this.maxDiscountAmount,
        this.limitPerUser,
        this.promotionType,
        this.isActive,
        this.startDate,
        this.endDate,
        this.createdAt,
        this.updatedAt});

  ShopDiscount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountTitle = json['discount_title'];
    discountType = json['discount_type'];
    discountAmount = json['discount_amount'];
    discountAmountType = json['discount_amount_type'];
    minPurchase = json['min_purchase'];
    maxDiscountAmount = json['max_discount_amount'];
    limitPerUser = json['limit_per_user'];
    promotionType = json['promotion_type'];
    isActive = json['is_active'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount_title'] = this.discountTitle;
    data['discount_type'] = this.discountType;
    data['discount_amount'] = this.discountAmount;
    data['discount_amount_type'] = this.discountAmountType;
    data['min_purchase'] = this.minPurchase;
    data['max_discount_amount'] = this.maxDiscountAmount;
    data['limit_per_user'] = this.limitPerUser;
    data['promotion_type'] = this.promotionType;
    data['is_active'] = this.isActive;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ShopLinks {
  String? url;
  String? label;
  bool? active;

  ShopLinks({this.url, this.label, this.active});

  ShopLinks.fromJson(Map<String, dynamic> json) {
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