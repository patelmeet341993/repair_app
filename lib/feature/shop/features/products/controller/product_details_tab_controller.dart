import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/features/products/repository/product_details_repo.dart';

import '../model/product_review_model.dart';

enum ProductTabControllerState { serviceOverview, faq, review }

class ProductTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ProductDetailsRepo productDetailsRepo;
  ProductTabController({required this.productDetailsRepo});

  TabController? controller;
  var productPageCurrentState = ProductTabControllerState.serviceOverview;
  void updateServicePageCurrentState(
      ProductTabControllerState productDetailsTabControllerState) {
    productPageCurrentState = productDetailsTabControllerState;
    update();
  }

  bool? _isLoading;
  int? _pageSize = 0;
  ProductReviewContent? reviewContent;
  List<ProductReviewData>? _reviewList;
  List<ProductReviewData>? get reviewList => _reviewList;
  bool get isLoading => _isLoading!;
  int? get pageSize => _pageSize!;
  ProductRating? _rating;
  String? _productID;
  int? _offset = 1;
  ProductRating get rating => _rating!;
  int? get offset => _offset;
  String? get productID => _productID;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 4);
  }

  Future<void> getProductReview(
    String productID,
    int offset, {
    bool reload = true,
  }) async {
    _offset = offset;
    Response response =
        await productDetailsRepo.getProductReviewList(productID, offset);
    if (response.statusCode == 200 &&
        response.body['response_code'] == 'default_200') {
      if (reload) {
        _reviewList = [];
      }
      reviewContent = ProductReviewContent.fromJson(response.body['content']);
      if (_reviewList != null && offset != 1) {
        _reviewList!.addAll(reviewContent!.reviews!.reviewList!);
      } else {
        _reviewList = [];
        _reviewList!.addAll(reviewContent!.reviews!.reviewList!);
      }
      _rating = reviewContent!.rating;
      _pageSize = response.body['content']['reviews']['last_page'] ?? 0;
    }
    update();
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }
}
