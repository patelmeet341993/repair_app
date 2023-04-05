import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';

import '../model/shop_banner_model.dart';
import '../repository/shop_banner_repo.dart';

class ShopBannerController extends GetxController implements GetxService {
  final ShopBannerRepo shopBannerRepo;
  ShopBannerController({required this.shopBannerRepo});

  List<ShopBannerModel>? _banners;
  List<ShopBannerModel>? get banners => _banners;

  int? _currentIndex = 0;
  int? get currentIndex => _currentIndex;

  Future<void> getShopBannerList(bool reload) async {
    if (_banners == null || reload) {
      Response response = await shopBannerRepo.getBannerList();
      if (response.statusCode == 200) {
        _banners = [];
        response.body['content']['data'].forEach((banner) {
          _banners!.add(ShopBannerModel.fromJson(banner));
        });
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

  /// if resource type is category then show list of sub-category and if resource type is link then lunch link out of device
  Future<void> navigateFromBanner(
      String resourceType, String bannerID, String link, String resourceID,
      {String categoryName = ''}) async {
    switch (resourceType) {
      case 'category':
        Get.toNamed(
            RouteHelper.shopSubCategoryScreenRoute(categoryName, bannerID, 0));
        break;

      case 'link':
        if (await canLaunchUrl(Uri.parse(link))) {
          await launchUrl(Uri.parse(link));
        } else {
          throw 'Could not launch $link';
        }
        break;
      case 'product':
        Get.toNamed(RouteHelper.getProductRoute(resourceID));
        break;
      default:
    }
  }
}
