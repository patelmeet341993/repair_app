import 'package:repair/core/core_export.dart';
import 'package:repair/feature/notification/repository/notification_repo.dart';

class ServiceBookingRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  ServiceBookingRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> placeBookingRequest(
      {required String paymentMethod,
      required String userId,
      required String serviceAddressID,
      required String schedule,
      required String providerSelectedIds,
      required String zoneId}) async {
    return await apiClient.postData(AppConstants.PLACE_REQUEST, {
      "payment_method": paymentMethod,
      "user_id": userId,
      "service_address_id": serviceAddressID,
      "service_schedule": schedule,
      "zone_id": zoneId,
      "provider_selected_ids": providerSelectedIds
    });
  }

  Future<Response> placeProductBookingRequest({
    required String paymentMethod,
    required String userId,
    required String serviceAddressID,
    required String schedule,
    required String zoneId,
    required String productId,
    required String variantId,
    required int quantity
  }) async {
    String url = "${AppConstants.PRODUCT_PLACE_REQUEST}?payment_method=$paymentMethod&zone_id=$zoneId&service_address_id=$serviceAddressID&service_schedule=2023-04-07";
    print("placeProductBookingRequest url => : ${url}");
    return await apiClient.postData(url, {
      "product_id": productId,
      "variant_id": variantId,
      "quantity": quantity,
      // "service_schedule": "schedule",
      // "zone_id": zoneId,
    });
  }

  Future<Response> getBookingList({required int offset, required String bookingStatus}) async {
    return await apiClient.getData(AppConstants.BOOKING_LIST + "?limit=10&offset=$offset&booking_status=$bookingStatus");
  }

  Future<Response> getBookingDetails({required String bookingID}) async {
    return await apiClient.getData(AppConstants.BOOKING_DETAILS + "/$bookingID");
  }

  Future<Response> getProductBookingList({required int offset, required String bookingStatus}) async {
    return await apiClient.getData(AppConstants.PRODUCT_BOOKING_LIST + "?limit=10&offset=$offset&booking_status=$bookingStatus");
  }

  Future<Response> getProductBookingDetails({required String bookingID}) async {
    return await apiClient.getData(AppConstants.PRODUCT_BOOKING_DETAILS + "/$bookingID");
  }
}
