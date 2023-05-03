import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/campaign/model/category_types_model.dart';
import 'package:repair/feature/shop/features/products/model/product_model.dart';
import 'package:repair/feature/shop/features/shop_category/model/shop_category_model.dart';

import '../repository/shop_category_repo.dart';

class ShopCategoryController extends GetxController implements GetxService {
  final ShopCategoryRepo shopCategoryRepo;
  ShopCategoryController({required this.shopCategoryRepo});

  List<ShopCategoryModel>? _categoryList;
  List<ShopCategoryModel>? _subCategoryList;
  List<Product>? _searchProductList = [];
  List<ShopCategoryModel>? _campaignBasedCategoryList;

  bool _isLoading = false;
  int? _pageSize;
  bool? _isSearching = false;
  String? _type = 'all';
  String? _searchText = '';
  int? _offset = 1;

  List<ShopCategoryModel>? get categoryList => _categoryList;
  List<ShopCategoryModel>? get campaignBasedCategoryList =>
      _campaignBasedCategoryList;
  List<ShopCategoryModel>? get subCategoryList => _subCategoryList;
  List<Product>? get searchServiceList => _searchProductList;
  bool get isLoading => _isLoading;
  int? get pageSize => _pageSize;
  bool? get isSearching => _isSearching;
  String? get type => _type;
  String? get searchText => _searchText;
  int? get offset => _offset;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<ShopCategoryController>().pageSize!;
        if (Get.find<ShopCategoryController>().offset! < pageSize) {
          Get.find<ShopCategoryController>().showBottomLoader();
          getCategoryList(Get.find<ShopCategoryController>().offset! + 1, false);
        }
      }
    });
  }

  Future<void> getCategoryList(int offset, bool reload) async {
    _offset = offset;
    if (_categoryList == null || reload) {
      Response response = await shopCategoryRepo.getCategoryList(offset);
      if (response.statusCode == 200) {
        _categoryList = [];
        response.body['content']['data'].forEach((category) {
          _categoryList!.add(ShopCategoryModel.fromJson(category));
        });
        _pageSize = response.body['content']['last_page'];
      } else {
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }
  }

  Future<void> getSubCategoryList(String categoryID, int subCategoryIndex,
      {bool shouldUpdate = true}) async {
    _subCategoryList = null;
    if (shouldUpdate) {
      update();
    }
    Response response = await shopCategoryRepo.getSubCategoryList(categoryID);
    if (response.statusCode == 200) {
      _subCategoryList = [];
      response.body['content']['data'].forEach((category) => _subCategoryList!
          .addIf(ShopCategoryModel.fromJson(category).isActive,
              ShopCategoryModel.fromJson(category)));
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getCampaignBasedCategoryList(
      String campaignID, bool isWithPagination) async {
    printLog("inside_campaign_based_category !");
    Response response =
        await shopCategoryRepo.getItemsBasedOnCampaignId(campaignID: campaignID);

    if (response.body['response_code'] == 'default_200') {
      if (!isWithPagination) {
        _campaignBasedCategoryList = [];
      }
      response.body['content']['data'].forEach((categoryTypesModel) {
        if (CategoryTypesModel.fromJson(categoryTypesModel).category != null) {
          _campaignBasedCategoryList!
              .add(CategoryTypesModel.fromJson(categoryTypesModel).category);
        }
      });
      _isLoading = false;
      Get.toNamed(RouteHelper.getCategoryRoute('fromCampaign', campaignID));
    } else {
      if (response.statusCode != 200) {
        ApiChecker.checkApi(response);
      } else {
        customSnackBar('campaign_is_not_available_for_this_service'.tr);
      }
    }
    update();
  }

  void toggleSearch() {
    _isSearching = !_isSearching!;
    _searchProductList = [];
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }
}
