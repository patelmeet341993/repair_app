import 'package:repair/feature/company/repository/company_details_repo.dart';
import 'package:get/get.dart';
import 'package:repair/data/provider/checker_api.dart';
import 'package:repair/feature/company/repository/company_repo.dart';
import 'package:repair/feature/service/model/service_model.dart';

import '../../../core/helper/help_me.dart';
import '../model/company_model.dart';

class CompanyDetailsController extends GetxController {
  final CompanyDetailsRepo serviceDetailsRepo;
  final CompanyRepo? companyRepo;
  CompanyDetailsController({required this.serviceDetailsRepo, this.companyRepo});

  Service? _service;
  bool? _isLoading;
  int? _offset = 1;
  List<CompanyData>? _companyContent;
  int? _pageSize;

  List<CompanyData>? get companyContent => _companyContent;
  int? get pageSize => _pageSize;
  int? get offset => _offset;
  Service? get service => _service;
  bool get isLoading => _isLoading!;

  ///discount and discount type based on category discount and service discount
  double? _serviceDiscount = 0.0;
  double get serviceDiscount => _serviceDiscount!;

  String? _discountType;
  String get discountType => _discountType!;

  ///call service details data based on service id
  Future<void> getServiceDetails(String serviceID) async {
    _service = null;
    Response response = await serviceDetailsRepo.getServiceDetails(serviceID);
    if (response.body['response_code'] == 'default_200') {
      _service = Service.fromJson(response.body['content']);
    } else {
      _service = Service();
      if (response.statusCode != 200) {
        ApiChecker.checkApi(response);
      }
    }
    _isLoading = false;

    update();
  }

  Future<void> getCompanyList(int offset, bool reload, String serviceID, String subCategoryId) async {

    print("in get company list");
    _offset = offset;
    try {
      if (_companyContent == null || reload) {
        print("===> subCategoryId: ${subCategoryId}");

        Response response = await companyRepo!.getCompanyList(offset, subCategoryId);
        print("===> Response: ${response.body}");
        // print("===> Request: ${response.request}");
        if (response.statusCode == 200) {
          _companyContent = [];
          // _service = Service.fromJson(response.body['content']);
          printLog('====> _service: ${_service?.id}');

          response.body['content'].forEach((element){
            // ['data'].forEach((company) {
            // if(element != null || element.length != 0) {
              _companyContent!.add(CompanyData.fromJson(element[0]));
            // }
            // });
          });
          // _pageSize = response.body['content']['last_page'];
        } else {
          ApiChecker.checkApi(response);
        }
        printLog('====> company: $_companyContent $_isLoading');

        _isLoading = false;
        update();
      }
    } catch(e,s){
      printLog('====> Error: $e $s');
    }
  }

  Future<void> getServiceDiscount() async {
    Service service = _service!;

    ///if category discount not null then calculate category discount
    if (service.campaignDiscount != null) {
      ///service based campaign discount
      _serviceDiscount = service.campaignDiscount!.length > 0
          ? service.campaignDiscount!
              .elementAt(0)
              .discount!
              .discountAmount!
              .toDouble()
          : 0.0;
      _discountType = service.campaignDiscount!.length > 0
          ? service.campaignDiscount!.elementAt(0).discount!.discountType!
          : 'amount';
    } else if (service.category!.campaignDiscount != null) {
      ///category based campaign discount
      _serviceDiscount = service.category!.campaignDiscount!.length > 0
          ? service.category!.campaignDiscount!
              .elementAt(0)
              .discount!
              .discountAmount!
              .toDouble()
          : 0.0;
      _discountType = service.category!.campaignDiscount!.length > 0
          ? service.category!.campaignDiscount!
              .elementAt(0)
              .discount!
              .discountAmountType!
          : 'amount';
    } else if (service.serviceDiscount != null) {
      ///service based service discount
      _serviceDiscount = service.serviceDiscount!.length > 0
          ? service.serviceDiscount!
              .elementAt(0)
              .discount!
              .discountAmount!
              .toDouble()
          : 0.0;
      _discountType = service.serviceDiscount!.length > 0
          ? service.serviceDiscount!.elementAt(0).discount!.discountType!
          : 'amount';
    } else {
      ///category based category discount
      _serviceDiscount = service.category!.categoryDiscount!.length > 0
          ? service.category!.categoryDiscount!
              .elementAt(0)
              .discount!
              .discountAmount!
              .toDouble()
          : 0.0;
      _discountType = service.category!.categoryDiscount!.length > 0
          ? service.category!.categoryDiscount!
              .elementAt(0)
              .discount!
              .discountAmountType!
          : 'amount';
    }
    update();
  }
}
