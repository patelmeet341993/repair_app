import 'package:repair/data/provider/client_api.dart';
import 'package:repair/utils/app_constants.dart';
import 'package:get/get.dart';

class CompanyRepo extends GetxService {
  final ApiClient apiClient;
  CompanyRepo({required this.apiClient});

  Future<Response> getCompanyList(int offset, String subCategoryId) async {
    return await apiClient
        .getData('${AppConstants.COMPANY_LIST}?offset=$offset&limit=20&subcategory_id=$subCategoryId');
  }
}
