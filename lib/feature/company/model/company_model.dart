import 'dart:convert';

import 'package:repair/data/model/response/error_response.dart';

/// response_code : "default_200"
/// message : "successfully loaded"
/// content : {"current_page":1,"data":[{"id":"3cd000af-a717-492d-88dc-fd5d6ab19bed","user_id":"eb994476-c070-484c-8dae-8e5394e350b4","company_name":"Test Company","company_name_arabic":"شركة الاختبار","company_phone":"919988776655","company_address":"Test Company Address","company_email":"testcomapny@gmail.com","logo":"2023-02-27-63fc3ef15a406.png","about_company":"<p>About Company</p>","start_time":"12:20:25","end_time":"01:20:25","working_with":"test company","company_commission_type":null,"company_commission":0,"estimation_commission_type":null,"estimation_commission":0,"contact_person_name":"Test Company Contact Name","contact_person_phone":"918877665544","contact_person_email":"testcompanycontact@gmail.com","order_count":0,"service_man_count":0,"service_capacity_per_day":0,"rating_count":0,"avg_rating":0,"commission_status":0,"commission_percentage":0,"is_active":1,"created_at":"2023-02-27T04:56:09.000000Z","updated_at":"2023-02-27T05:05:59.000000Z","is_approved":1,"zone_id":"bd565e2a-9072-403f-bdcf-ad2cce73bf43","subscribed_services_count":0,"bookings_count":0,"owner":{"id":"eb994476-c070-484c-8dae-8e5394e350b4","first_name":"Testfirst","last_name":"Testlast","email":"testcomapny@gmail.com","phone":"91776655443","identification_number":"ABCD12345678","identification_type":"driving_licence","identification_image":["2023-02-27-63fc3ef156826.png","2023-02-27-63fc3ef1598a1.png"],"date_of_birth":null,"gender":"male","profile_image":"default.png","fcm_token":null,"is_phone_verified":0,"is_email_verified":0,"phone_verified_at":null,"email_verified_at":null,"is_active":1,"user_type":"provider-admin","remember_token":null,"deleted_at":null,"created_at":"2023-02-27T04:56:09.000000Z","updated_at":"2023-02-27T05:05:59.000000Z"},"zone":{"id":"bd565e2a-9072-403f-bdcf-ad2cce73bf43","group_id":1,"country_id":"cda4ae0f-b677-49b6-bb08-739ce4ca949d","name":"All Area in kuwait","coordinates":[{"lat":40.681479988598,"lng":27.900406752335},{"lat":40.011637507133,"lng":104.18946925233},{"lat":-4.2576611649406,"lng":103.48634425233},{"lat":4.5227731433747,"lng":28.603531752335},{"lat":40.681479988598,"lng":27.900406752335}],"lang_id":1,"is_active":1,"created_at":"2022-12-16T17:36:23.000000Z","updated_at":"2023-03-01T07:28:57.000000Z"}}],"first_page_url":"?offset=1","from":1,"last_page":1,"last_page_url":"?offset=1","links":[{"url":null,"label":"&laquo; Previous","active":false},{"url":"?offset=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}],"next_page_url":null,"path":"","per_page":"20","prev_page_url":null,"to":1,"total":1}
/// errors : []

CompanyDetailsModel CompanyDetailsModelFromJson(String str) =>
    CompanyDetailsModel.fromJson(json.decode(str));
String CompanyDetailsModelToJson(CompanyDetailsModel data) =>
    json.encode(data.toJson());

class CompanyDetailsModel {
  CompanyDetailsModel({
    String? responseCode,
    String? message,
    Content? content,
    List<Errors>? errors,
  }) {
    _responseCode = responseCode;
    _message = message;
    _content = content;
    _errors = errors;
  }

  CompanyDetailsModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    if (json['errors'] != null) {
      _errors = <Errors>[];
      json['errors'].forEach((v) {
        _errors?.add(Errors.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _message;
  Content? _content;
  List<Errors>? _errors;
  CompanyDetailsModel copyWith({
    String? responseCode,
    String? message,
    Content? content,
    List<Errors>? errors,
  }) =>
      CompanyDetailsModel(
        responseCode: responseCode ?? _responseCode,
        message: message ?? _message,
        content: content ?? _content,
        errors: errors ?? _errors,
      );
  String? get responseCode => _responseCode;
  String? get message => _message;
  Content? get content => _content;
  List<dynamic>? get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    if (_content != null) {
      map['content'] = _content?.toJson();
    }
    if (_errors != null) {
      map['errors'] = _errors?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// current_page : 1
/// data : [{"id":"3cd000af-a717-492d-88dc-fd5d6ab19bed","user_id":"eb994476-c070-484c-8dae-8e5394e350b4","company_name":"Test Company","company_name_arabic":"شركة الاختبار","company_phone":"919988776655","company_address":"Test Company Address","company_email":"testcomapny@gmail.com","logo":"2023-02-27-63fc3ef15a406.png","about_company":"<p>About Company</p>","start_time":"12:20:25","end_time":"01:20:25","working_with":"test company","company_commission_type":null,"company_commission":0,"estimation_commission_type":null,"estimation_commission":0,"contact_person_name":"Test Company Contact Name","contact_person_phone":"918877665544","contact_person_email":"testcompanycontact@gmail.com","order_count":0,"service_man_count":0,"service_capacity_per_day":0,"rating_count":0,"avg_rating":0,"commission_status":0,"commission_percentage":0,"is_active":1,"created_at":"2023-02-27T04:56:09.000000Z","updated_at":"2023-02-27T05:05:59.000000Z","is_approved":1,"zone_id":"bd565e2a-9072-403f-bdcf-ad2cce73bf43","subscribed_services_count":0,"bookings_count":0,"owner":{"id":"eb994476-c070-484c-8dae-8e5394e350b4","first_name":"Testfirst","last_name":"Testlast","email":"testcomapny@gmail.com","phone":"91776655443","identification_number":"ABCD12345678","identification_type":"driving_licence","identification_image":["2023-02-27-63fc3ef156826.png","2023-02-27-63fc3ef1598a1.png"],"date_of_birth":null,"gender":"male","profile_image":"default.png","fcm_token":null,"is_phone_verified":0,"is_email_verified":0,"phone_verified_at":null,"email_verified_at":null,"is_active":1,"user_type":"provider-admin","remember_token":null,"deleted_at":null,"created_at":"2023-02-27T04:56:09.000000Z","updated_at":"2023-02-27T05:05:59.000000Z"},"zone":{"id":"bd565e2a-9072-403f-bdcf-ad2cce73bf43","group_id":1,"country_id":"cda4ae0f-b677-49b6-bb08-739ce4ca949d","name":"All Area in kuwait","coordinates":[{"lat":40.681479988598,"lng":27.900406752335},{"lat":40.011637507133,"lng":104.18946925233},{"lat":-4.2576611649406,"lng":103.48634425233},{"lat":4.5227731433747,"lng":28.603531752335},{"lat":40.681479988598,"lng":27.900406752335}],"lang_id":1,"is_active":1,"created_at":"2022-12-16T17:36:23.000000Z","updated_at":"2023-03-01T07:28:57.000000Z"}}]
/// first_page_url : "?offset=1"
/// from : 1
/// last_page : 1
/// last_page_url : "?offset=1"
/// links : [{"url":null,"label":"&laquo; Previous","active":false},{"url":"?offset=1","label":"1","active":true},{"url":null,"label":"Next &raquo;","active":false}]
/// next_page_url : null
/// path : ""
/// per_page : "20"
/// prev_page_url : null
/// to : 1
/// total : 1

Content contentFromJson(String str) => Content.fromJson(json.decode(str));
String contentToJson(Content data) => json.encode(data.toJson());

class Content {
  Content({
    int? currentPage,
    List<Data>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Links>? links,
    dynamic nextPageUrl,
    String? path,
    String? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) {
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
  }

  Content.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  int? _currentPage;
  List<Data>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  dynamic _nextPageUrl;
  String? _path;
  String? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;
  Content copyWith({
    int? currentPage,
    List<Data>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Links>? links,
    dynamic nextPageUrl,
    String? path,
    String? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      Content(
        currentPage: currentPage ?? _currentPage,
        data: data ?? _data,
        firstPageUrl: firstPageUrl ?? _firstPageUrl,
        from: from ?? _from,
        lastPage: lastPage ?? _lastPage,
        lastPageUrl: lastPageUrl ?? _lastPageUrl,
        links: links ?? _links,
        nextPageUrl: nextPageUrl ?? _nextPageUrl,
        path: path ?? _path,
        perPage: perPage ?? _perPage,
        prevPageUrl: prevPageUrl ?? _prevPageUrl,
        to: to ?? _to,
        total: total ?? _total,
      );
  int? get currentPage => _currentPage;
  List<Data>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  String? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }
}

/// url : null
/// label : "&laquo; Previous"
/// active : false

Links linksFromJson(String str) => Links.fromJson(json.decode(str));
String linksToJson(Links data) => json.encode(data.toJson());

class Links {
  Links({
    dynamic url,
    String? label,
    bool? active,
  }) {
    _url = url;
    _label = label;
    _active = active;
  }

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;
  Links copyWith({
    dynamic url,
    String? label,
    bool? active,
  }) =>
      Links(
        url: url ?? _url,
        label: label ?? _label,
        active: active ?? _active,
      );
  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }
}

/// id : "3cd000af-a717-492d-88dc-fd5d6ab19bed"
/// user_id : "eb994476-c070-484c-8dae-8e5394e350b4"
/// company_name : "Test Company"
/// company_name_arabic : "شركة الاختبار"
/// company_phone : "919988776655"
/// company_address : "Test Company Address"
/// company_email : "testcomapny@gmail.com"
/// logo : "2023-02-27-63fc3ef15a406.png"
/// about_company : "<p>About Company</p>"
/// start_time : "12:20:25"
/// end_time : "01:20:25"
/// working_with : "test company"
/// company_commission_type : null
/// company_commission : 0
/// estimation_commission_type : null
/// estimation_commission : 0
/// contact_person_name : "Test Company Contact Name"
/// contact_person_phone : "918877665544"
/// contact_person_email : "testcompanycontact@gmail.com"
/// order_count : 0
/// service_man_count : 0
/// service_capacity_per_day : 0
/// rating_count : 0
/// avg_rating : 0
/// commission_status : 0
/// commission_percentage : 0
/// is_active : 1
/// created_at : "2023-02-27T04:56:09.000000Z"
/// updated_at : "2023-02-27T05:05:59.000000Z"
/// is_approved : 1
/// zone_id : "bd565e2a-9072-403f-bdcf-ad2cce73bf43"
/// subscribed_services_count : 0
/// bookings_count : 0
/// owner : {"id":"eb994476-c070-484c-8dae-8e5394e350b4","first_name":"Testfirst","last_name":"Testlast","email":"testcomapny@gmail.com","phone":"91776655443","identification_number":"ABCD12345678","identification_type":"driving_licence","identification_image":["2023-02-27-63fc3ef156826.png","2023-02-27-63fc3ef1598a1.png"],"date_of_birth":null,"gender":"male","profile_image":"default.png","fcm_token":null,"is_phone_verified":0,"is_email_verified":0,"phone_verified_at":null,"email_verified_at":null,"is_active":1,"user_type":"provider-admin","remember_token":null,"deleted_at":null,"created_at":"2023-02-27T04:56:09.000000Z","updated_at":"2023-02-27T05:05:59.000000Z"}
/// zone : {"id":"bd565e2a-9072-403f-bdcf-ad2cce73bf43","group_id":1,"country_id":"cda4ae0f-b677-49b6-bb08-739ce4ca949d","name":"All Area in kuwait","coordinates":[{"lat":40.681479988598,"lng":27.900406752335},{"lat":40.011637507133,"lng":104.18946925233},{"lat":-4.2576611649406,"lng":103.48634425233},{"lat":4.5227731433747,"lng":28.603531752335},{"lat":40.681479988598,"lng":27.900406752335}],"lang_id":1,"is_active":1,"created_at":"2022-12-16T17:36:23.000000Z","updated_at":"2023-03-01T07:28:57.000000Z"}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    String? userId,
    String? companyName,
    String? companyNameArabic,
    String? companyPhone,
    String? companyAddress,
    String? companyEmail,
    String? logo,
    String? aboutCompany,
    String? startTime,
    String? endTime,
    String? workingWith,
    dynamic companyCommissionType,
    int? companyCommission,
    dynamic estimationCommissionType,
    int? estimationCommission,
    String? contactPersonName,
    String? contactPersonPhone,
    String? contactPersonEmail,
    int? orderCount,
    int? serviceManCount,
    int? serviceCapacityPerDay,
    int? ratingCount,
    int? avgRating,
    int? commissionStatus,
    int? commissionPercentage,
    int? isActive,
    String? createdAt,
    String? updatedAt,
    int? isApproved,
    String? zoneId,
    int? subscribedServicesCount,
    int? bookingsCount,
    Owner? owner,
    Zone? zone,
  }) {
    _id = id;
    _userId = userId;
    _companyName = companyName;
    _companyNameArabic = companyNameArabic;
    _companyPhone = companyPhone;
    _companyAddress = companyAddress;
    _companyEmail = companyEmail;
    _logo = logo;
    _aboutCompany = aboutCompany;
    _startTime = startTime;
    _endTime = endTime;
    _workingWith = workingWith;
    _companyCommissionType = companyCommissionType;
    _companyCommission = companyCommission;
    _estimationCommissionType = estimationCommissionType;
    _estimationCommission = estimationCommission;
    _contactPersonName = contactPersonName;
    _contactPersonPhone = contactPersonPhone;
    _contactPersonEmail = contactPersonEmail;
    _orderCount = orderCount;
    _serviceManCount = serviceManCount;
    _serviceCapacityPerDay = serviceCapacityPerDay;
    _ratingCount = ratingCount;
    _avgRating = avgRating;
    _commissionStatus = commissionStatus;
    _commissionPercentage = commissionPercentage;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _isApproved = isApproved;
    _zoneId = zoneId;
    _subscribedServicesCount = subscribedServicesCount;
    _bookingsCount = bookingsCount;
    _owner = owner;
    _zone = zone;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _companyName = json['company_name'];
    _companyNameArabic = json['company_name_arabic'];
    _companyPhone = json['company_phone'];
    _companyAddress = json['company_address'];
    _companyEmail = json['company_email'];
    _logo = json['logo'];
    _aboutCompany = json['about_company'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _workingWith = json['working_with'];
    _companyCommissionType = json['company_commission_type'];
    _companyCommission = json['company_commission'];
    _estimationCommissionType = json['estimation_commission_type'];
    _estimationCommission = json['estimation_commission'];
    _contactPersonName = json['contact_person_name'];
    _contactPersonPhone = json['contact_person_phone'];
    _contactPersonEmail = json['contact_person_email'];
    _orderCount = json['order_count'];
    _serviceManCount = json['service_man_count'];
    _serviceCapacityPerDay = json['service_capacity_per_day'];
    _ratingCount = json['rating_count'];
    _avgRating = json['avg_rating'];
    _commissionStatus = json['commission_status'];
    _commissionPercentage = json['commission_percentage'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _isApproved = json['is_approved'];
    _zoneId = json['zone_id'];
    _subscribedServicesCount = json['subscribed_services_count'];
    _bookingsCount = json['bookings_count'];
    _owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    _zone = json['zone'] != null ? Zone.fromJson(json['zone']) : null;
  }
  String? _id;
  String? _userId;
  String? _companyName;
  String? _companyNameArabic;
  String? _companyPhone;
  String? _companyAddress;
  String? _companyEmail;
  String? _logo;
  String? _aboutCompany;
  String? _startTime;
  String? _endTime;
  String? _workingWith;
  dynamic _companyCommissionType;
  int? _companyCommission;
  dynamic _estimationCommissionType;
  int? _estimationCommission;
  String? _contactPersonName;
  String? _contactPersonPhone;
  String? _contactPersonEmail;
  int? _orderCount;
  int? _serviceManCount;
  int? _serviceCapacityPerDay;
  int? _ratingCount;
  int? _avgRating;
  int? _commissionStatus;
  int? _commissionPercentage;
  int? _isActive;
  String? _createdAt;
  String? _updatedAt;
  int? _isApproved;
  String? _zoneId;
  int? _subscribedServicesCount;
  int? _bookingsCount;
  Owner? _owner;
  Zone? _zone;
  Data copyWith({
    String? id,
    String? userId,
    String? companyName,
    String? companyNameArabic,
    String? companyPhone,
    String? companyAddress,
    String? companyEmail,
    String? logo,
    String? aboutCompany,
    String? startTime,
    String? endTime,
    String? workingWith,
    dynamic companyCommissionType,
    int? companyCommission,
    dynamic estimationCommissionType,
    int? estimationCommission,
    String? contactPersonName,
    String? contactPersonPhone,
    String? contactPersonEmail,
    int? orderCount,
    int? serviceManCount,
    int? serviceCapacityPerDay,
    int? ratingCount,
    int? avgRating,
    int? commissionStatus,
    int? commissionPercentage,
    int? isActive,
    String? createdAt,
    String? updatedAt,
    int? isApproved,
    String? zoneId,
    int? subscribedServicesCount,
    int? bookingsCount,
    Owner? owner,
    Zone? zone,
  }) =>
      Data(
        id: id ?? _id,
        userId: userId ?? _userId,
        companyName: companyName ?? _companyName,
        companyNameArabic: companyNameArabic ?? _companyNameArabic,
        companyPhone: companyPhone ?? _companyPhone,
        companyAddress: companyAddress ?? _companyAddress,
        companyEmail: companyEmail ?? _companyEmail,
        logo: logo ?? _logo,
        aboutCompany: aboutCompany ?? _aboutCompany,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        workingWith: workingWith ?? _workingWith,
        companyCommissionType: companyCommissionType ?? _companyCommissionType,
        companyCommission: companyCommission ?? _companyCommission,
        estimationCommissionType:
            estimationCommissionType ?? _estimationCommissionType,
        estimationCommission: estimationCommission ?? _estimationCommission,
        contactPersonName: contactPersonName ?? _contactPersonName,
        contactPersonPhone: contactPersonPhone ?? _contactPersonPhone,
        contactPersonEmail: contactPersonEmail ?? _contactPersonEmail,
        orderCount: orderCount ?? _orderCount,
        serviceManCount: serviceManCount ?? _serviceManCount,
        serviceCapacityPerDay: serviceCapacityPerDay ?? _serviceCapacityPerDay,
        ratingCount: ratingCount ?? _ratingCount,
        avgRating: avgRating ?? _avgRating,
        commissionStatus: commissionStatus ?? _commissionStatus,
        commissionPercentage: commissionPercentage ?? _commissionPercentage,
        isActive: isActive ?? _isActive,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        isApproved: isApproved ?? _isApproved,
        zoneId: zoneId ?? _zoneId,
        subscribedServicesCount:
            subscribedServicesCount ?? _subscribedServicesCount,
        bookingsCount: bookingsCount ?? _bookingsCount,
        owner: owner ?? _owner,
        zone: zone ?? _zone,
      );
  String? get id => _id;
  String? get userId => _userId;
  String? get companyName => _companyName;
  String? get companyNameArabic => _companyNameArabic;
  String? get companyPhone => _companyPhone;
  String? get companyAddress => _companyAddress;
  String? get companyEmail => _companyEmail;
  String? get logo => _logo;
  String? get aboutCompany => _aboutCompany;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get workingWith => _workingWith;
  dynamic get companyCommissionType => _companyCommissionType;
  int? get companyCommission => _companyCommission;
  dynamic get estimationCommissionType => _estimationCommissionType;
  int? get estimationCommission => _estimationCommission;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonPhone => _contactPersonPhone;
  String? get contactPersonEmail => _contactPersonEmail;
  int? get orderCount => _orderCount;
  int? get serviceManCount => _serviceManCount;
  int? get serviceCapacityPerDay => _serviceCapacityPerDay;
  int? get ratingCount => _ratingCount;
  int? get avgRating => _avgRating;
  int? get commissionStatus => _commissionStatus;
  int? get commissionPercentage => _commissionPercentage;
  int? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get isApproved => _isApproved;
  String? get zoneId => _zoneId;
  int? get subscribedServicesCount => _subscribedServicesCount;
  int? get bookingsCount => _bookingsCount;
  Owner? get owner => _owner;
  Zone? get zone => _zone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['company_name'] = _companyName;
    map['company_name_arabic'] = _companyNameArabic;
    map['company_phone'] = _companyPhone;
    map['company_address'] = _companyAddress;
    map['company_email'] = _companyEmail;
    map['logo'] = _logo;
    map['about_company'] = _aboutCompany;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['working_with'] = _workingWith;
    map['company_commission_type'] = _companyCommissionType;
    map['company_commission'] = _companyCommission;
    map['estimation_commission_type'] = _estimationCommissionType;
    map['estimation_commission'] = _estimationCommission;
    map['contact_person_name'] = _contactPersonName;
    map['contact_person_phone'] = _contactPersonPhone;
    map['contact_person_email'] = _contactPersonEmail;
    map['order_count'] = _orderCount;
    map['service_man_count'] = _serviceManCount;
    map['service_capacity_per_day'] = _serviceCapacityPerDay;
    map['rating_count'] = _ratingCount;
    map['avg_rating'] = _avgRating;
    map['commission_status'] = _commissionStatus;
    map['commission_percentage'] = _commissionPercentage;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['is_approved'] = _isApproved;
    map['zone_id'] = _zoneId;
    map['subscribed_services_count'] = _subscribedServicesCount;
    map['bookings_count'] = _bookingsCount;
    if (_owner != null) {
      map['owner'] = _owner?.toJson();
    }
    if (_zone != null) {
      map['zone'] = _zone?.toJson();
    }
    return map;
  }
}

/// id : "bd565e2a-9072-403f-bdcf-ad2cce73bf43"
/// group_id : 1
/// country_id : "cda4ae0f-b677-49b6-bb08-739ce4ca949d"
/// name : "All Area in kuwait"
/// coordinates : [{"lat":40.681479988598,"lng":27.900406752335},{"lat":40.011637507133,"lng":104.18946925233},{"lat":-4.2576611649406,"lng":103.48634425233},{"lat":4.5227731433747,"lng":28.603531752335},{"lat":40.681479988598,"lng":27.900406752335}]
/// lang_id : 1
/// is_active : 1
/// created_at : "2022-12-16T17:36:23.000000Z"
/// updated_at : "2023-03-01T07:28:57.000000Z"

Zone zoneFromJson(String str) => Zone.fromJson(json.decode(str));
String zoneToJson(Zone data) => json.encode(data.toJson());

class Zone {
  Zone({
    String? id,
    int? groupId,
    String? countryId,
    String? name,
    List<Coordinates>? coordinates,
    int? langId,
    int? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _groupId = groupId;
    _countryId = countryId;
    _name = name;
    _coordinates = coordinates;
    _langId = langId;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Zone.fromJson(dynamic json) {
    _id = json['id'];
    _groupId = json['group_id'];
    _countryId = json['country_id'];
    _name = json['name'];
    if (json['coordinates'] != null) {
      _coordinates = [];
      json['coordinates'].forEach((v) {
        _coordinates?.add(Coordinates.fromJson(v));
      });
    }
    _langId = json['lang_id'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  int? _groupId;
  String? _countryId;
  String? _name;
  List<Coordinates>? _coordinates;
  int? _langId;
  int? _isActive;
  String? _createdAt;
  String? _updatedAt;
  Zone copyWith({
    String? id,
    int? groupId,
    String? countryId,
    String? name,
    List<Coordinates>? coordinates,
    int? langId,
    int? isActive,
    String? createdAt,
    String? updatedAt,
  }) =>
      Zone(
        id: id ?? _id,
        groupId: groupId ?? _groupId,
        countryId: countryId ?? _countryId,
        name: name ?? _name,
        coordinates: coordinates ?? _coordinates,
        langId: langId ?? _langId,
        isActive: isActive ?? _isActive,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  int? get groupId => _groupId;
  String? get countryId => _countryId;
  String? get name => _name;
  List<Coordinates>? get coordinates => _coordinates;
  int? get langId => _langId;
  int? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['group_id'] = _groupId;
    map['country_id'] = _countryId;
    map['name'] = _name;
    if (_coordinates != null) {
      map['coordinates'] = _coordinates?.map((v) => v.toJson()).toList();
    }
    map['lang_id'] = _langId;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

/// lat : 40.681479988598
/// lng : 27.900406752335

Coordinates coordinatesFromJson(String str) =>
    Coordinates.fromJson(json.decode(str));
String coordinatesToJson(Coordinates data) => json.encode(data.toJson());

class Coordinates {
  Coordinates({
    double? lat,
    double? lng,
  }) {
    _lat = lat;
    _lng = lng;
  }

  Coordinates.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }
  double? _lat;
  double? _lng;
  Coordinates copyWith({
    double? lat,
    double? lng,
  }) =>
      Coordinates(
        lat: lat ?? _lat,
        lng: lng ?? _lng,
      );
  double? get lat => _lat;
  double? get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }
}

/// id : "eb994476-c070-484c-8dae-8e5394e350b4"
/// first_name : "Testfirst"
/// last_name : "Testlast"
/// email : "testcomapny@gmail.com"
/// phone : "91776655443"
/// identification_number : "ABCD12345678"
/// identification_type : "driving_licence"
/// identification_image : ["2023-02-27-63fc3ef156826.png","2023-02-27-63fc3ef1598a1.png"]
/// date_of_birth : null
/// gender : "male"
/// profile_image : "default.png"
/// fcm_token : null
/// is_phone_verified : 0
/// is_email_verified : 0
/// phone_verified_at : null
/// email_verified_at : null
/// is_active : 1
/// user_type : "provider-admin"
/// remember_token : null
/// deleted_at : null
/// created_at : "2023-02-27T04:56:09.000000Z"
/// updated_at : "2023-02-27T05:05:59.000000Z"

Owner ownerFromJson(String str) => Owner.fromJson(json.decode(str));
String ownerToJson(Owner data) => json.encode(data.toJson());

class Owner {
  Owner({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? identificationNumber,
    String? identificationType,
    List<String>? identificationImage,
    dynamic dateOfBirth,
    String? gender,
    String? profileImage,
    dynamic fcmToken,
    int? isPhoneVerified,
    int? isEmailVerified,
    dynamic phoneVerifiedAt,
    dynamic emailVerifiedAt,
    int? isActive,
    String? userType,
    dynamic rememberToken,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phone = phone;
    _identificationNumber = identificationNumber;
    _identificationType = identificationType;
    _identificationImage = identificationImage;
    _dateOfBirth = dateOfBirth;
    _gender = gender;
    _profileImage = profileImage;
    _fcmToken = fcmToken;
    _isPhoneVerified = isPhoneVerified;
    _isEmailVerified = isEmailVerified;
    _phoneVerifiedAt = phoneVerifiedAt;
    _emailVerifiedAt = emailVerifiedAt;
    _isActive = isActive;
    _userType = userType;
    _rememberToken = rememberToken;
    _deletedAt = deletedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Owner.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _phone = json['phone'];
    _identificationNumber = json['identification_number'];
    _identificationType = json['identification_type'];
    _identificationImage = json['identification_image'] != null
        ? json['identification_image'].cast<String>()
        : [];
    _dateOfBirth = json['date_of_birth'];
    _gender = json['gender'];
    _profileImage = json['profile_image'];
    _fcmToken = json['fcm_token'];
    _isPhoneVerified = json['is_phone_verified'];
    _isEmailVerified = json['is_email_verified'];
    _phoneVerifiedAt = json['phone_verified_at'];
    _emailVerifiedAt = json['email_verified_at'];
    _isActive = json['is_active'];
    _userType = json['user_type'];
    _rememberToken = json['remember_token'];
    _deletedAt = json['deleted_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _identificationNumber;
  String? _identificationType;
  List<String>? _identificationImage;
  dynamic _dateOfBirth;
  String? _gender;
  String? _profileImage;
  dynamic _fcmToken;
  int? _isPhoneVerified;
  int? _isEmailVerified;
  dynamic _phoneVerifiedAt;
  dynamic _emailVerifiedAt;
  int? _isActive;
  String? _userType;
  dynamic _rememberToken;
  dynamic _deletedAt;
  String? _createdAt;
  String? _updatedAt;
  Owner copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? identificationNumber,
    String? identificationType,
    List<String>? identificationImage,
    dynamic dateOfBirth,
    String? gender,
    String? profileImage,
    dynamic fcmToken,
    int? isPhoneVerified,
    int? isEmailVerified,
    dynamic phoneVerifiedAt,
    dynamic emailVerifiedAt,
    int? isActive,
    String? userType,
    dynamic rememberToken,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
  }) =>
      Owner(
        id: id ?? _id,
        firstName: firstName ?? _firstName,
        lastName: lastName ?? _lastName,
        email: email ?? _email,
        phone: phone ?? _phone,
        identificationNumber: identificationNumber ?? _identificationNumber,
        identificationType: identificationType ?? _identificationType,
        identificationImage: identificationImage ?? _identificationImage,
        dateOfBirth: dateOfBirth ?? _dateOfBirth,
        gender: gender ?? _gender,
        profileImage: profileImage ?? _profileImage,
        fcmToken: fcmToken ?? _fcmToken,
        isPhoneVerified: isPhoneVerified ?? _isPhoneVerified,
        isEmailVerified: isEmailVerified ?? _isEmailVerified,
        phoneVerifiedAt: phoneVerifiedAt ?? _phoneVerifiedAt,
        emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
        isActive: isActive ?? _isActive,
        userType: userType ?? _userType,
        rememberToken: rememberToken ?? _rememberToken,
        deletedAt: deletedAt ?? _deletedAt,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phone => _phone;
  String? get identificationNumber => _identificationNumber;
  String? get identificationType => _identificationType;
  List<String>? get identificationImage => _identificationImage;
  dynamic get dateOfBirth => _dateOfBirth;
  String? get gender => _gender;
  String? get profileImage => _profileImage;
  dynamic get fcmToken => _fcmToken;
  int? get isPhoneVerified => _isPhoneVerified;
  int? get isEmailVerified => _isEmailVerified;
  dynamic get phoneVerifiedAt => _phoneVerifiedAt;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  int? get isActive => _isActive;
  String? get userType => _userType;
  dynamic get rememberToken => _rememberToken;
  dynamic get deletedAt => _deletedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['identification_number'] = _identificationNumber;
    map['identification_type'] = _identificationType;
    map['identification_image'] = _identificationImage;
    map['date_of_birth'] = _dateOfBirth;
    map['gender'] = _gender;
    map['profile_image'] = _profileImage;
    map['fcm_token'] = _fcmToken;
    map['is_phone_verified'] = _isPhoneVerified;
    map['is_email_verified'] = _isEmailVerified;
    map['phone_verified_at'] = _phoneVerifiedAt;
    map['email_verified_at'] = _emailVerifiedAt;
    map['is_active'] = _isActive;
    map['user_type'] = _userType;
    map['remember_token'] = _rememberToken;
    map['deleted_at'] = _deletedAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
