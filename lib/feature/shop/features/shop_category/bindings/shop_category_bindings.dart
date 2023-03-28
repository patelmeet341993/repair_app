import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';

class ShopCategoryBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() =>
        ServiceController(serviceRepo: ServiceRepo(apiClient: Get.find())));
  }
}
