import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';

import '../../products/controller/product_controller.dart';
import '../../products/repository/product_repo.dart';

class ShopCategoryBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() =>
        ProductController(productRepo: ProductRepo(apiClient: Get.find())));
  }
}
