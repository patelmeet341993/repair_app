import 'package:get/get.dart';
import 'package:repair/data/provider/checker_api.dart';
import 'package:repair/feature/service/model/service_model.dart';
import 'package:repair/feature/service/repository/service_details_repo.dart';

import '../model/product_model.dart';
import '../repository/product_details_repo.dart';

class ProductDetailsController extends GetxController {
  final ProductDetailsRepo productDetailsRepo;
  ProductDetailsController({required this.productDetailsRepo});

  Product? _product;
  bool? _isLoading;
  Product? get product => _product;
  bool get isLoading => _isLoading!;

  ///discount and discount type based on category discount and service discount
  double? _productDiscount = 0.0;
  double get productDiscount => _productDiscount!;

  String? _discountType;
  String get discountType => _discountType!;

  ///call service details data based on service id
  Future<void> getProductDetails(String productID) async {
    _product = null;
    Response response = await productDetailsRepo.getProductDetails(productID);
    if (response.body['response_code'] == 'default_200') {
      _product = Product.fromJson(response.body['content']);
    } else {
      _product = Product();
      if (response.statusCode != 200) {
        ApiChecker.checkApi(response);
      }
    }
    _isLoading = false;

    update();
  }

  // Future<void> getServiceDiscount() async {
  //   Product product = _product!;
  //
  //   ///if category discount not null then calculate category discount
  //   if (product.campaignDiscount != null) {
  //     ///product based campaign discount
  //     _productDiscount = product.campaignDiscount!.length > 0
  //         ? product.campaignDiscount!
  //             .elementAt(0)
  //             .productDiscount!
  //             .discountAmount!
  //             .toDouble()
  //         : 0.0;
  //     _discountType = product.campaignDiscount!.length > 0
  //         ? product.campaignDiscount!.elementAt(0).productDiscount!.discountType!
  //         : 'amount';
  //   } else if (product.category!.campaignDiscount != null) {
  //     ///category based campaign discount
  //     _productDiscount = product.category!.campaignDiscount!.length > 0
  //         ? product.category!.campaignDiscount!
  //             .elementAt(0)
  //             .productDiscount!
  //             .discountAmount!
  //             .toDouble()
  //         : 0.0;
  //     _discountType = product.category!.campaignDiscount!.length > 0
  //         ? product.category!.campaignDiscount!
  //             .elementAt(0)
  //             .productDiscount!
  //             .discountAmountType!
  //         : 'amount';
  //   } else if (product.productDiscount != null) {
  //     ///product based product discount
  //     _productDiscount = product.productDiscount!.length > 0
  //         ? product.productDiscount!
  //             .elementAt(0)
  //             .productDiscount!
  //             .discountAmount!
  //             .toDouble()
  //         : 0.0;
  //     _discountType = product.productDiscount!.length > 0
  //         ? product.productDiscount!.elementAt(0).productDiscount!.discountType!
  //         : 'amount';
  //   } else {
  //     ///category based category discount
  //     _productDiscount = product.category!.categoryDiscount!.length > 0
  //         ? product.category!.categoryDiscount!
  //             .elementAt(0)
  //             .productDiscount!
  //             .discountAmount!
  //             .toDouble()
  //         : 0.0;
  //     _discountType = product.category!.categoryDiscount!.length > 0
  //         ? product.category!.categoryDiscount!
  //             .elementAt(0)
  //             .productDiscount!
  //             .discountAmountType!
  //         : 'amount';
  //   }
  //   update();
  // }
}
