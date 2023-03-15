import 'package:repair/components/custom_snackbar.dart';
import 'package:repair/core/helper/responsive_helper.dart';
import 'package:repair/core/helper/route_helper.dart';
import 'package:repair/data/provider/checker_api.dart';
import 'package:repair/feature/cart/controller/cart_controller.dart';
import 'package:repair/feature/checkout/controller/checkout_controller.dart';
import 'package:repair/feature/location/controller/location_controller.dart';
import 'package:repair/feature/service_booking/model/service_booking_model.dart';
import 'package:repair/feature/service_booking/repo/service_booking_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum BookingStatusTabs { all, pending, accepted, ongoing, completed, canceled }

class ServiceBookingController extends GetxController implements GetxService {
  final ServiceBookingRepo serviceBookingRepo;
  ServiceBookingController({required this.serviceBookingRepo});

  bool _isPlacedOrdersuccessfully = false;
  bool get isPlacedOrdersuccessfully => _isPlacedOrdersuccessfully;
  List<BookingModel>? _bookingList;
  List<BookingModel>? get bookingList => _bookingList;
  int _offset = 1;
  int? get offset => _offset;
  BookingContent? _bookingContent;
  BookingContent? get bookingContent => _bookingContent;

  int _bookingListPageSize = 0;
  int _bookingListCurrentPage = 0;
  int get bookingListPageSize => _bookingListPageSize;
  int get bookingListCurrentPage => _bookingListCurrentPage;
  BookingStatusTabs _selectedBookingStatus = BookingStatusTabs.all;
  BookingStatusTabs get selectedBookingStatus => _selectedBookingStatus;

  @override
  void onInit() {
    super.onInit();
    /* bookingScreenScrollController.addListener(() {
      if(bookingScreenScrollController.position.pixels == bookingScreenScrollController.position.maxScrollExtent) {
       if(offset! < bookingListPageSize){
          getAllBookingService(bookingStatus: selectedBookingStatus.name.toLowerCase(),offset: offset! + 1,isFromPagination:true);
        }
      }
    });*/
  }

  void updateBookingStatusTabs(BookingStatusTabs bookingStatusTabs,
      {bool firstTimeCall = true, bool fromMenu = false}) {
    _selectedBookingStatus = bookingStatusTabs;
    if (firstTimeCall) {
      getAllBookingService(
          offset: 1,
          bookingStatus: _selectedBookingStatus.name.toLowerCase(),
          isFromPagination: false);
    }
  }

  Future<void> placeBookingRequest(
      {required String paymentMethod,
      required String userID,
      required String serviceAddressId,
      required String schedule}) async {
    String zoneId =
        Get.find<LocationController>().getUserAddress()!.zoneId.toString();
    Response response = await serviceBookingRepo.placeBookingRequest(
      paymentMethod: paymentMethod,
      userId: userID,
      schedule: schedule,
      serviceAddressID: serviceAddressId,
      zoneId: zoneId,
    );

    if (response.statusCode == 200) {
      _isPlacedOrdersuccessfully = true;
      Get.find<CheckOutController>().updateState(PageState.complete);

      ///navigate replace
      if (ResponsiveHelper.isWeb())
        Get.toNamed(RouteHelper.getCheckoutRoute(
            'cart', Get.find<CheckOutController>().currentPage.name, "null"));
      customSnackBar('service_booking_successfully'.tr,
          isError: false, margin: 55);
      Get.find<CartController>().getCartListFromServer();
      update();
    }
  }

  Future<void> getAllBookingService(
      {required int offset,
      required String bookingStatus,
      required bool isFromPagination,
      bool fromMenu = false}) async {
    print("inside_get_all_booking_service");
    _offset = offset;
    if (!isFromPagination) {
      _bookingList = null;
    }
    Response response = await serviceBookingRepo.getBookingList(
        offset: offset, bookingStatus: bookingStatus);
    if (response.statusCode == 200) {
      ServiceBookingList _serviceBookingModel =
          ServiceBookingList.fromJson(response.body);
      if (!isFromPagination) {
        _bookingList = [];
      }
      _serviceBookingModel.content!.bookingModel!.forEach((element) {
        _bookingList!.add(element);
      });
      _bookingListPageSize = response.body['content']['last_page'];
      _bookingContent = _serviceBookingModel.content!;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
