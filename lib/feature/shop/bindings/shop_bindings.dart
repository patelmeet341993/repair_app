import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/controller/shop_banner_controller.dart';
import 'package:repair/feature/shop/features/products/controller/product_controller.dart';
import 'package:repair/feature/shop/features/products/repository/product_repo.dart';

import '../controller/shop_campaign_controller.dart';
import '../features/shop_category/controller/shop_category_controller.dart';
import '../features/shop_category/repository/shop_category_repo.dart';
import '../repository/shop_banner_repo.dart';
import '../repository/shop_campaign_repo.dart';

class ShopBottomNavBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(
        () => ShopBannerController(shopBannerRepo: ShopBannerRepo(apiClient: Get.find())));
    Get.lazyPut(() =>
        ShopCampaignController(shopCampaignRepo: ShopCampaignRepo(apiClient: Get.find())));
    Get.lazyPut(() =>
        ShopCategoryController(shopCategoryRepo: ShopCategoryRepo(apiClient: Get.find())));
    Get.lazyPut(() =>
        ProductController(productRepo: ProductRepo(apiClient: Get.find())));
    Get.lazyPut(
        () => UserController(userRepo: UserRepo(apiClient: Get.find())));
    Get.lazyPut(() => ServiceBookingController(
        serviceBookingRepo: ServiceBookingRepo(
            sharedPreferences: Get.find(), apiClient: Get.find())));
  }
}
