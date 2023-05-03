import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:repair/components/custom_snackbar.dart';
import 'package:repair/core/helper/responsive_helper.dart';
import 'package:repair/core/helper/route_helper.dart';
import 'package:repair/data/provider/checker_api.dart';
import 'package:repair/data/provider/company_provider.dart';
import 'package:repair/feature/cart/controller/cart_controller.dart';
import 'package:repair/feature/checkout/controller/checkout_controller.dart';
import 'package:repair/feature/location/controller/location_controller.dart';
import 'package:repair/feature/service_booking/model/product_booking_model.dart';
import 'package:repair/feature/service_booking/model/product_booking_model.dart';
import 'package:repair/feature/service_booking/model/service_booking_model.dart';
import 'package:repair/feature/service_booking/repo/service_booking_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repair/feature/shop/features/cart/controller/product_cart_controller.dart';

enum BookingStatusTabs { all, pending, accepted, ongoing, completed, canceled }
enum ProductBookingStatusTabs { all, processed, shipped, delivered, received, cancelled }

class ServiceBookingController extends GetxController implements GetxService {
  final ServiceBookingRepo serviceBookingRepo;

  ServiceBookingController({required this.serviceBookingRepo});

  bool _isPlacedOrderSuccessfully = false;

  bool get isPlacedOrdersuccessfully => _isPlacedOrderSuccessfully;
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

  //Product Booking
  List<BookingData>? _productBookingList;

  List<BookingData>? get productBookingList => _productBookingList;

  ProductBookingStatusTabs _selectedProductBookingStatus = ProductBookingStatusTabs.all;

  ProductBookingStatusTabs get selectedProductBookingStatus => _selectedProductBookingStatus;

  int _productOffset = 1;

  int? get productOffset => _productOffset;
  ProductBookingContent? _productBookingContent;

  ProductBookingContent? get productBookingContent => _productBookingContent;

  int _productBookingListPageSize = 0;
  int _productBookingListCurrentPage = 0;

  int get productBookingListPageSize => _productBookingListPageSize;

  int get productBookingListCurrentPage => _productBookingListCurrentPage;

  // bool _isPlacedOrderSuccessfully = false;
  //
  // bool get isPlacedOrdersuccessfully => _isPlacedOrderSuccessfully;


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

  void updateBookingStatusTabs(BookingStatusTabs bookingStatusTabs, {bool firstTimeCall = true, bool fromMenu = false}) {
    _selectedBookingStatus = bookingStatusTabs;
    if (firstTimeCall) {
      getAllBookingService(offset: 1, bookingStatus: _selectedBookingStatus.name.toLowerCase(), isFromPagination: false);
    }
  }

  void updateProductBookingStatusTabs(ProductBookingStatusTabs bookingStatusTabs, {bool firstTimeCall = true, bool fromMenu = false}) {
    _selectedProductBookingStatus = bookingStatusTabs;
    if (firstTimeCall) {
      getAllBookingProduct(offset: 1, bookingStatus: _selectedProductBookingStatus.name.toLowerCase(), isFromPagination: false);
    }
  }

  Future<void> placeBookingRequest(
      {required BuildContext context,
      required String paymentMethod,
      required String userID,
      required String serviceAddressId,
      required String schedule}) async {
    CompanyProvider companyProvider = Provider.of<CompanyProvider>(context, listen: false);
    String providerIds = companyProvider.getSelectedCompany.join(",");
    print("providerIds, $providerIds");
    String zoneId = Get.find<LocationController>().getUserAddress()!.zoneId.toString();
    Response response = await serviceBookingRepo.placeBookingRequest(
        paymentMethod: paymentMethod, userId: userID, schedule: schedule, serviceAddressID: serviceAddressId, zoneId: zoneId, providerSelectedIds: providerIds);
    print("response, ${response.body}");
    if (response.statusCode == 200) {
      _isPlacedOrderSuccessfully = true;
      Get.find<CheckOutController>().updateState(PageState.complete);

      ///navigate replace
      if (ResponsiveHelper.isWeb()) Get.toNamed(RouteHelper.getCheckoutRoute('cart', Get.find<CheckOutController>().currentPage.name, "null"));
      customSnackBar('service_booking_successfully'.tr, isError: false, margin: 55);
      Get.find<CartController>().getCartListFromServer();
      // Get.find<ProductCartController>().getCartListFromServer();
      update();
    }
  }

  Future<void> placeProductBookingRequest(
      {required BuildContext context,
      required String paymentMethod,
      required String userID,
      required String serviceAddressId,
      required String schedule,
      required String productId,
      required String variantId,
      required int quantity}) async {
    print("in  placeProductBookingRequest");

    String zoneId = Get.find<LocationController>().getUserAddress()!.zoneId.toString();
    Response response = await serviceBookingRepo.placeProductBookingRequest(
        paymentMethod: paymentMethod,
        userId: userID,
        schedule: schedule,
        serviceAddressID: serviceAddressId,
        zoneId: zoneId,
        productId: productId,
        quantity: quantity,
        variantId: variantId);
    print("response, ${response.body}");
    if (response.statusCode == 200) {
      _isPlacedOrderSuccessfully = true;
      Get.find<CheckOutController>().updateState(PageState.complete);

      ///navigate replace
      if (ResponsiveHelper.isWeb()) Get.toNamed(RouteHelper.getCheckoutRoute('cart', Get.find<CheckOutController>().currentPage.name, "null"));
      customSnackBar('product_booking_successfully'.tr, isError: false, margin: 55);
      Get.find<ProductCartController>().getCartListFromServer();
      update();
    }
  }

  Future<void> getAllBookingService({required int offset, required String bookingStatus, required bool isFromPagination, bool fromMenu = false}) async {
    print("inside_get_all_booking_service");
    _offset = offset;
    if (!isFromPagination) {
      _bookingList = null;
    }
    Response response = await serviceBookingRepo.getBookingList(offset: offset, bookingStatus: bookingStatus);
    if (response.statusCode == 200) {
      ServiceBookingList _serviceBookingModel = ServiceBookingList.fromJson(response.body);
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

  Future<void> getAllBookingProduct({required int offset, required String bookingStatus, required bool isFromPagination, bool fromMenu = false}) async {
    print("inside_get_all_booking_service");
    _offset = offset;
    if (!isFromPagination) {
      _productBookingList = null;
    }
    Response response = await serviceBookingRepo.getProductBookingList(offset: offset, bookingStatus: bookingStatus);
    if (response.statusCode == 200) {
      ProductBookingModel _productBookingModel = ProductBookingModel.fromJson(response.body);
      if (!isFromPagination) {
        _productBookingList = [];
      }
      _productBookingModel.content!.data.forEach((element) {
        _productBookingList!.add(element);
      });
      _productBookingListPageSize = response.body['content']['last_page'];
      _productBookingContent = _productBookingModel.content!;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}
