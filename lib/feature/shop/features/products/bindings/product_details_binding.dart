import 'package:get/get.dart';
import 'package:repair/feature/shop/features/products/controller/product_details_controller.dart';
import 'package:repair/feature/shop/features/products/controller/product_details_tab_controller.dart';
import 'package:repair/feature/shop/features/products/repository/product_details_repo.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => ProductDetailsController(
        productDetailsRepo: ProductDetailsRepo(apiClient: Get.find())));
    Get.lazyPut(() => ProductTabController(
        productDetailsRepo: ProductDetailsRepo(apiClient: Get.find())));
  }
}
