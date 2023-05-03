import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/features/products/controller/product_controller.dart';

import '../repository/product_repo.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);
    Get.lazyPut(() => ProductController(
        productRepo: ProductRepo(
            apiClient: ApiClient(
                appBaseUrl: AppConstants.BASE_URL,
                sharedPreferences: sharedPreferences))));
  }
}
