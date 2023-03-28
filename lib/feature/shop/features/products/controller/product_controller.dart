import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/campaign/model/service_types.dart';
import 'package:repair/feature/shop/features/products/model/product_model.dart';

class ProductController extends GetxController implements GetxService {
  final ServiceRepo serviceRepo;
  ProductController({required this.serviceRepo});

  ProductContent? _productContent;
  ProductContent? _offerBasedProductContent;
  ProductContent? _popularBasedProductContent;
  List<Product>? _popularProductList;
  ProductContent? _recommendedProductContent;
  List<Product>? _recommendedProductList;
  List<Product>? _subCategoryBasedProductList;
  List<Product>? _campaignBasedProductList;
  List<Product>? _offerBasedProductList;
  List<Product>? _allProduct;
  List<Product>? get allService => _allProduct;

  bool _isLoading = false;
  List<int>? _variationIndex;
  int? _quantity = 1;
  List<bool>? _addOnActiveList = [];
  List<int>? _addOnQtyList = [];
  int _cartIndex = -1;

  ProductContent? get productContent => _productContent;
  ProductContent? get offerBasedProductContent => _offerBasedProductContent;
  ProductContent? get popularBasedProductContent => _popularBasedProductContent;
  List<Product>? get popularProductList => _popularProductList;
  List<Product>? get recommendedProductList => _recommendedProductList;
  ProductContent? get recommendedProductContent =>
      _recommendedProductContent;
  List<Product>? get subCategoryBasedProductList =>
      _subCategoryBasedProductList;
  List<Product>? get campaignBasedProductList => _campaignBasedProductList;
  List<Product>? get offerBasedProductList => _offerBasedProductList;

  bool get isLoading => _isLoading;
  List<int>? get variationIndex => _variationIndex;
  int? get quantity => _quantity;
  List<bool>? get addOnActiveList => _addOnActiveList;
  List<int>? get addOnQtyList => _addOnQtyList;
  int get cartIndex => _cartIndex;

  double? _serviceDiscount = 0.0;
  double get serviceDiscount => _serviceDiscount!;

  String? _discountType;
  String get discountType => _discountType!;

  String? _fromPage;
  String? get fromPage => _fromPage!;

  List<double> _lowestPriceList = [];
  List<double> get lowestPriceList => _lowestPriceList;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (Get.find<AuthController>().isLoggedIn()) {
      await Get.find<UserController>().getUserInfo();
      await Get.find<CartController>().getCartData();
      // await Get.find<CartController>().addMultipleCartToServer();
      await Get.find<CartController>().getCartListFromServer();
    }
  }

  Future<void> getAllServiceList(int offset, bool reload) async {
    print("getAllServiceList_offset:$offset");
    if (offset != 1 || _allProduct == null || reload) {
      if (reload) {
        _allProduct = null;
      }
      Response response = await serviceRepo.getAllServiceList(offset);
      if (response.statusCode == 200) {
        if (reload) {
          _allProduct = [];
        }
        _productContent = ProductModel.fromJson(response.body).content;
        if (_allProduct != null && offset != 1) {
          _allProduct!.addAll(
              ProductModel.fromJson(response.body).content!.serviceList!);
        } else {
          _allProduct = [];
          _allProduct!.addAll(
              ProductModel.fromJson(response.body).content!.serviceList!);
        }
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  Future<void> getPopularServiceList(int offset, bool reload) async {
    print(offset);
    print("offset");
    if (offset != 1 || _popularProductList == null || reload) {
      Response response = await serviceRepo.getPopularServiceList(offset);
      if (response.statusCode == 200) {
        if (reload) {
          _popularProductList = [];
        }
        _popularBasedProductContent =
            ProductModel.fromJson(response.body).content;

        if (_popularProductList != null && offset != 1) {
          _popularProductList!
              .addAll(_popularBasedProductContent!.serviceList!);
        } else {
          _popularProductList = [];
          _popularProductList!
              .addAll(_popularBasedProductContent!.serviceList!);
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  Future<void> getRecommendedServiceList(int offset, bool reload) async {
    if (offset != 1 || _recommendedProductList == null || reload) {
      Response response = await serviceRepo.getRecommendedServiceList(offset);
      if (response.statusCode == 200) {
        if (reload) {
          _recommendedProductList = [];
        }
        _recommendedProductContent =
            ProductModel.fromJson(response.body).content;
        if (_recommendedProductList != null && offset != 1) {
          _recommendedProductList!.addAll(
              ProductModel.fromJson(response.body).content!.serviceList!);
        } else {
          _recommendedProductList = [];
          _recommendedProductList!
              .addAll(_recommendedProductContent!.serviceList!);
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  cleanSubCategory() {
    _subCategoryBasedProductList = null;
    update();
  }

  Future<void> getSubCategoryBasedServiceList(
      String subCategoryID, bool isWithPagination,
      {bool isShouldUpdate = true}) async {
    Response response = await serviceRepo.getServiceListBasedOnSubCategory(
        subCategoryID: subCategoryID, offset: 1);
    if (response.statusCode == 200) {
      if (!isWithPagination) {
        _subCategoryBasedProductList = [];
      }
      if(ServiceModel.fromJson(response.body).content != null) {
        _subCategoryBasedProductList!
            .addAll(ProductModel
            .fromJson(response.body)
            .content!
            .serviceList!);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    if (isShouldUpdate) {
      update();
    }
  }

  Future<void> getCampaignBasedServiceList(
      String campaignID, bool reload) async {
    Response response =
        await serviceRepo.getItemsBasedOnCampaignId(campaignID: campaignID);
    if (response.body['response_code'] == 'default_200') {
      if (reload) {
        _campaignBasedProductList = [];
      }
      response.body['content']['data'].forEach((serviceTypesModel) {
        if (ServiceTypesModel.fromJson(serviceTypesModel).service != null) {
          _campaignBasedProductList!
              .add(ServiceTypesModel.fromJson(serviceTypesModel).service);
        }
      });
      Get.toNamed(RouteHelper.allServiceScreenRoute("fromCampaign",
          campaignID: campaignID));
    } else {
      customSnackBar('campaign_is_not_available_for_this_service'.tr);
      if (response.statusCode != 200) {
        ApiChecker.checkApi(response);
      }
    }
    update();
  }

  Future<void> getEmptyCampaignService() async {
    _campaignBasedProductList = null;
  }

  Future<void> getMixedCampaignList(
      String campaignID, bool isWithPagination) async {
    if (!isWithPagination) {
      _campaignBasedProductList = [];
    }
    Response response =
        await serviceRepo.getItemsBasedOnCampaignId(campaignID: campaignID);
    if (response.body['response_code'] == 'default_200') {
      response.body['content']['data'].forEach((serviceTypesModel) {
        if (ServiceTypesModel.fromJson(serviceTypesModel).service != null) {
          _campaignBasedProductList!
              .add(ServiceTypesModel.fromJson(serviceTypesModel).service);
        }
      });
      _isLoading = false;
      if (_campaignBasedProductList!.length == 0) {
        Get.find<CategoryController>()
            .getCampaignBasedCategoryList(campaignID, false);
      } else {
        Get.toNamed(RouteHelper.allServiceScreenRoute("fromCampaign",
            campaignID: campaignID));
      }
    } else {
      if (response.statusCode != 200) {
        ApiChecker.checkApi(response);
      } else {
        customSnackBar('campaign_is_not_available_for_this_service'.tr);
      }
    }
    update();
  }

  Future<void> getOffersList(int offset, bool reload) async {
    print("offset_from_offer_list:$offset");
    Response response = await serviceRepo.getOffersList(offset);
    if (response.statusCode == 200) {
      if (reload) {
        _offerBasedProductList = [];
      }
      _offerBasedProductContent = ProductModel.fromJson(response.body).content;
      if (_offerBasedProductList != null && offset != 1) {
        _offerBasedProductList!.addAll(_offerBasedProductContent!.serviceList!);
      } else {
        _offerBasedProductList = [];
        _offerBasedProductList!.addAll(_offerBasedProductContent!.serviceList!);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  int setExistInCart(Service service, {bool notify = true}) {
    List<String> _variationList = [];
    for (int index = 0;
        index < service.variationsAppFormat!.zoneWiseVariations!.length;
        index++) {
      _variationList.add(
          service.variationsAppFormat!.zoneWiseVariations![index].variantName!);
    }
    String variationType = '';
    bool isFirst = true;
    _variationList.forEach((variation) {
      if (isFirst) {
        variationType = '$variationType$variation';
        isFirst = false;
      } else {
        variationType = '$variationType-$variation';
      }
    });
    if (_cartIndex != -1) {
      _quantity = Get.find<CartController>().cartList[_cartIndex].quantity;
      _addOnActiveList = [];
      _addOnQtyList = [];
    }
    return _cartIndex;
  }

  void setAddOnQuantity(bool isIncrement, int index) {
    if (isIncrement) {
      _addOnQtyList![index] = _addOnQtyList![index] + 1;
    } else {
      _addOnQtyList![index] = _addOnQtyList![index] - 1;
    }
    update();
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = _quantity! + 1;
    } else {
      _quantity = _quantity! - 1;
    }
    update();
  }

  void setCartVariationIndex(int index, int i, Service product) {
    _variationIndex![index] = i;
    _quantity = 1;
    setExistInCart(product);
    update();
  }

  void addAddOn(bool isAdd, int index) {
    _addOnActiveList![index] = isAdd;
    update();
  }

  Future<void> getServiceDiscount(Service service) async {
    if (service.campaignDiscount != null) {
      _serviceDiscount = service.campaignDiscount!.length > 0
          ? service.campaignDiscount!
              .elementAt(0)
              .discount!
              .discountAmount!
              .toDouble()
          : 0.0;
      _discountType = service.campaignDiscount!.length > 0
          ? service.campaignDiscount!.elementAt(0).discount!.discountType!
          : 'amount';
    } else if (service.category!.campaignDiscount != null) {
      _serviceDiscount = service.category!.campaignDiscount!.length > 0
          ? service.category!.campaignDiscount!
              .elementAt(0)
              .discount!
              .discountAmount!
              .toDouble()
          : 0.0;
      _discountType = service.category!.campaignDiscount!.length > 0
          ? service.category!.campaignDiscount!
              .elementAt(0)
              .discount!
              .discountAmountType!
          : 'amount';
    } else if (service.serviceDiscount != null) {
      _serviceDiscount = service.serviceDiscount!.length > 0
          ? service.serviceDiscount!
              .elementAt(0)
              .discount!
              .discountAmount!
              .toDouble()
          : 0.0;
      _discountType = service.serviceDiscount!.length > 0
          ? service.serviceDiscount!.elementAt(0).discount!.discountType!
          : 'amount';
    } else {
      _serviceDiscount = service.category!.categoryDiscount!.length > 0
          ? service.category!.categoryDiscount!
              .elementAt(0)
              .discount!
              .discountAmount!
              .toDouble()
          : 0.0;
      _discountType = service.category!.categoryDiscount!.length > 0
          ? service.category!.categoryDiscount!
              .elementAt(0)
              .discount!
              .discountAmountType!
          : 'amount';
    }
  }
}
