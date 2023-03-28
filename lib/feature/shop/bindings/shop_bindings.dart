import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/controller/shop_banner_controller.dart';

import '../repository/shop_banner_repo.dart';

class ShopBottomNavBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(
        () => ShopBannerController(shopBannerRepo: ShopBannerRepo(apiClient: Get.find())));
    Get.lazyPut(() =>
        CampaignController(campaignRepo: CampaignRepo(apiClient: Get.find())));
    Get.lazyPut(() =>
        CategoryController(categoryRepo: CategoryRepo(apiClient: Get.find())));
    Get.lazyPut(() =>
        ServiceController(serviceRepo: ServiceRepo(apiClient: Get.find())));
    Get.lazyPut(
        () => UserController(userRepo: UserRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServiceBookingController(
        serviceBookingRepo: ServiceBookingRepo(
            sharedPreferences: Get.find(), apiClient: Get.find())));
  }
}
