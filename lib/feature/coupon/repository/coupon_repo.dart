import 'package:get/get_connect/http/src/response/response.dart';
import 'package:repair/data/provider/client_api.dart';
import 'package:repair/utils/app_constants.dart';

class CouponRepo {
  final ApiClient apiClient;
  CouponRepo({required this.apiClient});

  Future<Response> getCouponList() async {
    return await apiClient.getData(AppConstants.COUPON_URI);
  }

  Future<Response> applyCoupon(String couponCode) async {
    return await apiClient
        .postData('${AppConstants.APPLY_COUPON}', {'coupon_code': couponCode});
  }
}
