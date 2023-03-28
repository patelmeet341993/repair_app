import 'package:repair/data/provider/client_api.dart';
import 'package:get/get.dart';
import 'package:repair/utils/app_constants.dart';

class ProductDetailsRepo extends GetxService {
  final ApiClient apiClient;
  ProductDetailsRepo({required this.apiClient});

  Future<Response> getProductDetails(String serviceID) async {
    return await apiClient
        .getData('${AppConstants.SERVICE_DETAILS_URI}/$serviceID');
  }

  Future<Response> getProductReviewList(String serviceID, int offset) async {
    return await apiClient.getData(
        '${AppConstants.GET_SERVICE_REVIEW_LIST}$serviceID?offset=$offset&limit=10');
  }
}
