import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/campaign/model/service_types.dart';
import 'package:repair/feature/shop/features/product_campaign/model/product_types.dart';
import 'package:repair/feature/shop/features/products/model/product_model.dart';
import 'package:repair/feature/shop/features/products/repository/product_repo.dart';

class ProductController extends GetxController implements GetxService {
  final ProductRepo productRepo;
  ProductController({required this.productRepo});

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
  List<Product>? get allProduct => _allProduct;
  ProductContent? _recommendedBasedProductContent;

  ProductContent? get recommendedBasedProductContent =>
      _recommendedBasedProductContent;
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

  double? _productDiscount = 0.0;
  double get productDiscount => _productDiscount!;

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

  Future<void> getAllProductList(int offset, bool reload) async {
    print("getAllProductList_offset:$offset");
    if (offset != 1 || _allProduct == null || reload) {
      if (reload) {
        _allProduct = null;
      }
      Response response = await productRepo.getAllProductList(offset);
      if (response.statusCode == 200) {
        if (reload) {
          _allProduct = [];
        }
        _productContent = ProductModel.fromJson(response.body).content;
        if (_allProduct != null && offset != 1) {
          _allProduct!.addAll(
              ProductModel.fromJson(response.body).content!.productList!);
        } else {
          _allProduct = [];
          _allProduct!.addAll(
              ProductModel.fromJson(response.body).content!.productList!);
        }
        update();
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  Future<void> getPopularProductList(int offset, bool reload) async {
    print(offset);
    print("offset");
    if (offset != 1 || _popularProductList == null || reload) {
      Response response = await productRepo.getPopularProductList(offset);
      if (response.statusCode == 200) {
        if (reload) {
          _popularProductList = [];
        }
        _popularBasedProductContent =
            ProductModel.fromJson(response.body).content;

        if (_popularProductList != null && offset != 1) {
          _popularProductList!
              .addAll(_popularBasedProductContent!.productList!);
        } else {
          _popularProductList = [];
          _popularProductList!
              .addAll(_popularBasedProductContent!.productList!);
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  Future<void> getRecommendedProductList(int offset, bool reload) async {
    if (offset != 1 || _recommendedProductList == null || reload) {
      Response response = await productRepo.getRecommendedProductList(offset);
      if (response.statusCode == 200) {
        if (reload) {
          _recommendedProductList = [];
        }
        _recommendedProductContent =
            ProductModel.fromJson(response.body).content;
        if (_recommendedProductList != null && offset != 1) {
          _recommendedProductList!.addAll(
              ProductModel.fromJson(response.body).content!.productList!);
        } else {
          _recommendedProductList = [];
          _recommendedProductList!
              .addAll(_recommendedProductContent!.productList!);
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

  Future<void> getSubCategoryBasedProductList(
      String subCategoryID, bool isWithPagination,
      {bool isShouldUpdate = true}) async {
    Response response = await productRepo.getProductListBasedOnSubCategory(
        subCategoryID: subCategoryID, offset: 1);
    if (response.statusCode == 200) {
      if (!isWithPagination) {
        _subCategoryBasedProductList = [];
      }
      if(ProductModel.fromJson(response.body).content != null) {
        _subCategoryBasedProductList!
            .addAll(ProductModel
            .fromJson(response.body)
            .content!
            .productList!);
      }
    } else {
      ApiChecker.checkApi(response);
    }
    if (isShouldUpdate) {
      update();
    }
  }

  Future<void> getCampaignBasedProductList(
      String campaignID, bool reload) async {
    Response response =
        await productRepo.getItemsBasedOnCampaignId(campaignID: campaignID);
    if (response.body['response_code'] == 'default_200') {
      if (reload) {
        _campaignBasedProductList = [];
      }
      response.body['content']['data'].forEach((productTypesModel) {
        if (ProductTypesModel.fromJson(productTypesModel).product != null) {
          _campaignBasedProductList!
              .add(ProductTypesModel.fromJson(productTypesModel).product);
        }
      });
      Get.toNamed(RouteHelper.allProductScreenRoute("fromCampaign",
          campaignID: campaignID));
    } else {
      customSnackBar('campaign_is_not_available_for_this_service'.tr);
      if (response.statusCode != 200) {
        ApiChecker.checkApi(response);
      }
    }
    update();
  }

  Future<void> getEmptyCampaignProduct() async {
    _campaignBasedProductList = null;
  }

  Future<void> getMixedCampaignList(
      String campaignID, bool isWithPagination) async {
    if (!isWithPagination) {
      _campaignBasedProductList = [];
    }
    Response response =
        await productRepo.getItemsBasedOnCampaignId(campaignID: campaignID);
    if (response.body['response_code'] == 'default_200') {
      response.body['content']['data'].forEach((productTypesModel) {
        if (ProductTypesModel.fromJson(productTypesModel).product != null) {
          _campaignBasedProductList!
              .add(ProductTypesModel.fromJson(productTypesModel).product);
        }
      });
      _isLoading = false;
      if (_campaignBasedProductList!.length == 0) {
        Get.find<CategoryController>()
            .getCampaignBasedCategoryList(campaignID, false);
      } else {
        Get.toNamed(RouteHelper.allProductScreenRoute("fromCampaign",
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
    Response response = await productRepo.getOffersList(offset);
    if (response.statusCode == 200) {
      if (reload) {
        _offerBasedProductList = [];
      }
      _offerBasedProductContent = ProductModel.fromJson(response.body).content;
      if (_offerBasedProductList != null && offset != 1) {
        _offerBasedProductList!.addAll(_offerBasedProductContent!.productList!);
      } else {
        _offerBasedProductList = [];
        _offerBasedProductList!.addAll(_offerBasedProductContent!.productList!);
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

  int setExistInCart(Product product, {bool notify = true}) {
    List<String> _variationList = [];
    // for (int index = 0;
    //     index < product.variationsAppFormat!.zoneWiseVariations!.length;
    //     index++) {
    //   _variationList.add(
    //       product.variationsAppFormat!.zoneWiseVariations![index].variantName!);
    // }
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

  void setCartVariationIndex(int index, int i, Product product) {
    _variationIndex![index] = i;
    _quantity = 1;
    setExistInCart(product);
    update();
  }

  void addAddOn(bool isAdd, int index) {
    _addOnActiveList![index] = isAdd;
    update();
  }

  Future<void> getProductDiscount(Product product) async {
    // if (product.campaignDiscount != null) {
    //   _productDiscount = product.campaignDiscount!.length > 0
    //       ? product.campaignDiscount!
    //           .elementAt(0)
    //           .productDiscount!
    //           .discountAmount!
    //           .toDouble()
    //       : 0.0;
    //   _discountType = product.campaignDiscount!.length > 0
    //       ? product.campaignDiscount!.elementAt(0).productDiscount!.discountType!
    //       : 'amount';
    // } else if (product.category!.campaignDiscount != null) {
    //   _productDiscount = product.category!.campaignDiscount!.length > 0
    //       ? product.category!.campaignDiscount!
    //           .elementAt(0)
    //           .productDiscount!
    //           .discountAmount!
    //           .toDouble()
    //       : 0.0;
    //   _discountType = product.category!.campaignDiscount!.length > 0
    //       ? product.category!.campaignDiscount!
    //           .elementAt(0)
    //           .productDiscount!
    //           .discountAmountType!
    //       : 'amount';
    // } else if (product.productDiscount != null) {
    //   _productDiscount = product.productDiscount!.length > 0
    //       ? product.productDiscount!
    //           .elementAt(0)
    //           .productDiscount!
    //           .discountAmount!
    //           .toDouble()
    //       : 0.0;
    //   _discountType = product.productDiscount!.length > 0
    //       ? product.productDiscount!.elementAt(0).productDiscount!.discountType!
    //       : 'amount';
    // } else {
    //   _productDiscount = product.category!.categoryDiscount!.length > 0
    //       ? product.category!.categoryDiscount!
    //           .elementAt(0)
    //           .productDiscount!
    //           .discountAmount!
    //           .toDouble()
    //       : 0.0;
    //   _discountType = product.category!.categoryDiscount!.length > 0
    //       ? product.category!.categoryDiscount!
    //           .elementAt(0)
    //           .productDiscount!
    //           .discountAmountType!
    //       : 'amount';
    // }
  }
}
