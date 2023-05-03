import '../../../core/core_export.dart';
import '../../notification/repository/notification_repo.dart';

class ProductBookingDetailsRepo{
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;
  ProductBookingDetailsRepo({required this.sharedPreferences,required this.apiClient});


  Future<Response> getBookingDetails({required String bookingID})async{
    return await apiClient.getData(AppConstants.PRODUCT_BOOKING_DETAILS+"/$bookingID");
  }


  Future<Response> bookingCancel({required String bookingID}) async {
    return await apiClient.postData('${AppConstants.BOOKING_CANCEL}/$bookingID', {
      "booking_status" :"canceled",
      "_method" : "put"});
  }

}