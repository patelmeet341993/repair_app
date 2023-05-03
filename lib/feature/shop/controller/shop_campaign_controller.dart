import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/features/products/controller/product_controller.dart';
import 'package:repair/feature/shop/features/shop_category/controller/shop_category_controller.dart';

import '../features/products/model/product_model.dart';
import '../model/shop_campaign_model.dart';
import '../repository/shop_campaign_repo.dart';

class ShopCampaignController extends GetxController implements GetxService {
  final ShopCampaignRepo shopCampaignRepo;
  ShopCampaignController({required this.shopCampaignRepo});

  List<ShopCampaignData>? _campaignList;
  List<Product>? _itemCampaignList;
  int? _currentIndex = 0;
  bool? _isLoading = false;

  List<ShopCampaignData>? get campaignList => _campaignList;
  List<Product>? get itemCampaignList => _itemCampaignList;
  int? get currentIndex => _currentIndex;
  bool? get isLoading => _isLoading;

  Future<void> getCampaignList(bool reload) async {
    if (_campaignList == null || reload) {
      Response? response = await shopCampaignRepo.getcampaignList();
      if (response!.statusCode == 200) {
        _campaignList = [];
        response.body['content']['data'].forEach(
            (campaign) => _campaignList!.add(ShopCampaignData.fromJson(campaign)));
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }

  Future<void> navigateFromCampaign(
      String campaignID, String discountType) async {
    printLog("discountType:$discountType");
    _isLoading = true;
    update();
    if (discountType == 'category') {
      Get.find<ShopCategoryController>()
          .getCampaignBasedCategoryList(campaignID, false);
    } else if (discountType == 'mixed') {
      Get.find<ProductController>().getMixedCampaignList(campaignID, false);
    } else {
      Get.find<ProductController>()
          .getCampaignBasedProductList(campaignID, true);
    }
    _isLoading = false;
    update();
  }
}
