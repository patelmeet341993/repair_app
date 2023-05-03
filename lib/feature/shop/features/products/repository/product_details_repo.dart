import 'package:repair/data/provider/client_api.dart';
import 'package:get/get.dart';
import 'package:repair/utils/app_constants.dart';

class ProductDetailsRepo extends GetxService {
  final ApiClient apiClient;
  ProductDetailsRepo({required this.apiClient});

  Future<Response> getProductDetails(String productID) async {
    return await apiClient
        .getData('${AppConstants.PRODUCT_DETAILS_URI}$productID');
  }

  Future<Response> getProductReviewList(String serviceID, int offset) async {
    return await apiClient.getData(
        '${AppConstants.GET_PRODUCT_REVIEW_LIST}$serviceID?offset=$offset&limit=10');
  }
}
