import 'package:repair/feature/company/controller/company_details_controller.dart';
import 'package:repair/feature/company//controller/company_details_tab_controller.dart';
import 'package:repair/feature/company/repository/company_details_repo.dart';
import 'package:get/get.dart';

class CompanyDetailsBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => CompanyDetailsController(
        serviceDetailsRepo: CompanyDetailsRepo(apiClient: Get.find())));
    Get.lazyPut(() => CompanyTabController(
        companyDetailsRepo: CompanyDetailsRepo(apiClient: Get.find())));
  }
}
