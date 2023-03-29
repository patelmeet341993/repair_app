import 'package:repair/data/provider/client_api.dart';
import 'package:repair/feature/review/model/review_body.dart';
import 'package:get/get.dart';
import 'package:repair/utils/app_constants.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});

  Future<Response> getAllProductList(int offset) async {
    return await apiClient
        .getData('${AppConstants.SHOP_ALL_PRODUCT_URI}?offset=$offset&limit=10');
  }

  Future<Response> getPopularProductList(int offset) async {
    return await apiClient
        .getData('${AppConstants.SHOP_POPULAR_SERVICE_URI}?offset=$offset&limit=10');
  }

  Future<Response> getRecommendedProductList(int offset) async {
    return await apiClient.getData(
        '${AppConstants.RECOMMENDED_PRODUCT_URI}?limit=10&offset=$offset');
  }

  Future<Response> getOffersList(int offset) async {
    return await apiClient
        .getData('${AppConstants.OFFER_LIST_URI}?limit=10&offset=$offset');
  }

  Future<Response> getProductListBasedOnSubCategory(
      {required String subCategoryID, required int offset}) async {
    return await apiClient.getData(
        '${AppConstants.PRODUCT_BASED_ON_SUB_CATEGORY}$subCategoryID?limit=10&offset=$offset');
  }

  Future<Response> getItemsBasedOnCampaignId(
      {required String campaignID}) async {
    return await apiClient.getData(
        '${AppConstants.ITEMS_BASED_ON_CAMPAIGN_ID}$campaignID&limit=100&offset=1');
  }

  Future<Response> getProductDetails(String serviceID) async {
    return await apiClient
        .getData('${AppConstants.SERVICE_DETAILS_URI}/$serviceID');
  }

  Future<Response> submitReview(ReviewBody reviewBody) async {
    return await apiClient.postData(
        AppConstants.SERVICE_REVIEW, reviewBody.toJson());
  }
}
