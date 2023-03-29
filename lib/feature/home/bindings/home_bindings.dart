import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/features/shop_category/controller/shop_category_controller.dart';
import 'package:repair/feature/shop/features/shop_category/repository/shop_category_repo.dart';

import '../../shop/controller/shop_banner_controller.dart';
import '../../shop/repository/shop_banner_repo.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(() => BannerController(bannerRepo: BannerRepo(apiClient: Get.find())));
    Get.lazyPut(() => ShopBannerController(shopBannerRepo: ShopBannerRepo(apiClient: Get.find())));
    Get.lazyPut(() => ShopCategoryController(shopCategoryRepo: ShopCategoryRepo(apiClient: Get.find())));
    Get.lazyPut(() => CampaignController(campaignRepo: CampaignRepo(apiClient: Get.find())));
    Get.lazyPut(() => CategoryController(categoryRepo: CategoryRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServiceController(serviceRepo: ServiceRepo(apiClient: Get.find())));
    Get.lazyPut(() => UserController(userRepo: UserRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServiceBookingController(serviceBookingRepo: ServiceBookingRepo(sharedPreferences: Get.find(), apiClient: Get.find())));
  }
}
