import 'package:repair/data/provider/client_api.dart';
import 'package:repair/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ShopCampaignRepo {
  final ApiClient apiClient;
  ShopCampaignRepo({required this.apiClient});

  Future<Response?> getcampaignList() async {
    return await apiClient.getData(AppConstants.CAMPAIGN_URI);
  }
}
