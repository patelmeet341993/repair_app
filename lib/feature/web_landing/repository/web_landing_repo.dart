import 'package:repair/data/provider/client_api.dart';
import 'package:repair/feature/notification/repository/notification_repo.dart';
import 'package:repair/utils/app_constants.dart';

class WebLandingRepo {
  final ApiClient apiClient;

  WebLandingRepo({required this.apiClient});

  Future<Response> getWebLandingContents() async {
    return await apiClient.getData('${AppConstants.WEB_LANDING_CONTENTS}',
        headers: AppConstants.configHeader);
  }
}
