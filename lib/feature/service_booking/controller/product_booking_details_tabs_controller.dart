import 'package:get/get.dart';
import 'package:repair/feature/service_booking/model/invoice.dart';
import 'package:repair/feature/service_booking/repo/booking_details_repo.dart';
import '../../../core/core_export.dart';
import '../repo/product_booking_details_repo.dart';

enum ProductBookingDetailsTabs { BookingDetails, Status }

class ProductBookingDetailsTabsController extends GetxController with GetSingleTickerProviderStateMixin {
  ProductBookingDetailsRepo bookingDetailsRepo;

  ProductBookingDetailsTabsController({required this.bookingDetailsRepo});

  ProductBookingDetailsTabs _selectedDetailsTabs = ProductBookingDetailsTabs.BookingDetails;

  ProductBookingDetailsTabs get selectedBookingStatus => _selectedDetailsTabs;
  TabController? detailsTabController;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool _isCancelling = false;

  bool get isCancelling => _isCancelling;
  BookingDetailsContent? _productBookingDetailsContent;

  BookingDetailsContent? get productBookingDetailsContent => _productBookingDetailsContent;
  List<InvoiceItem> _invoiceItems = [];

  List<InvoiceItem> get invoiceItems => _invoiceItems;
  double _invoiceGrandTotal = 0.0;

  double get invoiceGrandTotal => _invoiceGrandTotal;

  List<double> _unitTotalCost = [];
  double _allTotalCost = 0;
  double _totalDiscount = 0;
  double _totalDiscountWithCoupon = 0;

  List<double> get unitTotalCost => _unitTotalCost;

  double get allTotalCost => _allTotalCost;

  double get totalDiscount => _totalDiscount;

  double get totalDiscountWithCoupon => _totalDiscountWithCoupon;

  void updateBookingStatusTabs(ProductBookingDetailsTabs bookingDetailsTabs) {
    _selectedDetailsTabs = bookingDetailsTabs;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    detailsTabController = TabController(length: BookingDetailsTabs.values.length, vsync: this);
  }

  Future<void> bookingCancel({required String bookingId}) async {
    _isCancelling = true;
    update();
    Response? response = await bookingDetailsRepo.bookingCancel(bookingID: bookingId);
    if (response.statusCode == 200) {
      _isCancelling = false;
      customSnackBar('booking_cancelled_successfully'.tr, isError: false);
      getBookingDetails(bookingId: bookingId);
    } else {
      _isCancelling = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getBookingDetails({required String bookingId}) async {
    _invoiceGrandTotal = 0;
    _invoiceItems = [];
    _productBookingDetailsContent = null;
    Response response = await bookingDetailsRepo.getBookingDetails(bookingID: bookingId);
    print(response.statusCode);
    if (response.statusCode == 200) {
      _allTotalCost = 0.0;
      _unitTotalCost = [];
      _productBookingDetailsContent = BookingDetailsContent.fromJson(response.body['content']);
      if (_productBookingDetailsContent!.detail != null) {
        _productBookingDetailsContent!.detail!.forEach((element) {
          _unitTotalCost.add(element.discountAmount.toDouble() * element.quantity);
        });
        _unitTotalCost.forEach((element) {
          _allTotalCost = _allTotalCost + element;
        });
      }

      double? discount = _productBookingDetailsContent!.totalDiscountAmount!.toDouble();
      double? campaignDiscount = _productBookingDetailsContent!.totalCampaignDiscountAmount!.toDouble();
      _totalDiscount = (discount + campaignDiscount);
      _totalDiscountWithCoupon = discount + campaignDiscount + (_productBookingDetailsContent!.totalCouponDiscountAmount!);
      _productBookingDetailsContent!.detail?.forEach((element) {
        _invoiceItems.add(InvoiceItem(
          discountAmount: (element.discountAmount + element.campaignDiscountAmount.toDouble() + element.overallCouponDiscountAmount.toDouble()),
          tax: element.taxAmount.toDouble(),
          unitAllTotal: element.totalCost.toDouble(),
          quantity: element.quantity,
          serviceName: "${element.service?.name ?? 'service_deleted'.tr} \n ${element.variantKey ?? 'variantKey_not_available'.tr}",
          unitPrice: element.serviceCost.toDouble(),
        ));
      });
      print("Invoice item : ${_invoiceItems.length}");
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  String calculateDiscount(double? discountAmount, double? campaignDiscount, int qty) {
    return ((discountAmount! + campaignDiscount!) * qty).toStringAsFixed(3);
  }

  String calculateTex(double? tax, int qty) {
    return (tax! * qty).toStringAsFixed(3);
  }

  double calculateTotalCost(BookingContentDetailsItem element) {
    double? discount = element.discountAmount.toDouble();
    double? campaignDiscount = element.campaignDiscountAmount.toDouble();
    double? totalDiscount = discount + campaignDiscount;
    double? tex = element.taxAmount.toDouble();
    int? qty = element.quantity;
    double? total = element.serviceCost.toDouble();
    double texQ = tex * qty;
    double discountQ = totalDiscount * qty;
    double totalQ = total * qty;
    double? allTotal = (totalQ + texQ) - discountQ;
    printLog("=========>$allTotal");
    _invoiceGrandTotal = _invoiceGrandTotal + allTotal;
    return allTotal;
  }

  @override
  void onClose() {
    detailsTabController!.dispose();
    super.onClose();
  }
}
