import 'package:repair/core/core_export.dart';
import '../../notification/repository/notification_repo.dart';

class SubmitReviewRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  SubmitReviewRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> submitReview({required ReviewBody reviewBody}) async {
    return await apiClient.postData(
        AppConstants.SERVICE_REVIEW, reviewBody.toJson());
  }
}
