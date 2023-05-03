import 'package:get/get_connect/http/src/response/response.dart';
import 'package:repair/core/core_export.dart';

class ShopBannerRepo {
  final ApiClient apiClient;
  ShopBannerRepo({required this.apiClient});

  Future<Response> getBannerList() async {
    return await apiClient.getData(AppConstants.SHOP_BANNER_URI);
  }
}
