import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:repair/core/core_export.dart';

class ShopCategoryRepo {
  final ApiClient apiClient;

  ShopCategoryRepo({required this.apiClient});

  Future<Response> getCategoryList(int offset) async {
    // print("languageeeee: ${Get.find<LocalizationController>().locale.languageCode}");
    // String language_id = Get.find<LocalizationController>().locale.languageCode == "en" ? AppConstants.englishLanguageId : AppConstants.arabicLabnguageId;
    return await apiClient.getData('${AppConstants.SHOP_CATEGORY_URI}&limit=100&offset=$offset');
  }

  Future<Response> getItemsBasedOnCampaignId({required String campaignID}) async {
    return await apiClient.getData('${AppConstants.ITEMS_BASED_ON_SHOP_CAMPAIGN_ID}$campaignID&limit=100&offset=1');
  }

  Future<Response> getSubCategoryList(String parentID) async {
    return await apiClient.getData('${AppConstants.SHOP_SUB_CATEGORY_URI}$parentID');
  }

  Future<Response> getCategoryServiceList(String categoryID, int offset, String type) async {
    return await apiClient.getData('${AppConstants.CATEGORY_SERVICE_URI}$categoryID?limit=10&offset=$offset&type=$type');
  }

  Future<Response> getSearchData(String query, String categoryID, String type) async {
    return await apiClient.getData(
      '${AppConstants.SEARCH_URI}services/search?name=$query&category_id=$categoryID&type=$type&offset=1&limit=50',
    );
  }
}