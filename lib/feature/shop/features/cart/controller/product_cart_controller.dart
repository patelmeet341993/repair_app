import 'package:file_picker/file_picker.dart';
import 'package:repair/core/common_model/common_success_model.dart';
import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/features/cart/model/product_cart_model_body.dart';
import 'package:repair/feature/shop/features/products/model/product_model.dart';
import 'package:repair/feature/voucher/controller/coupon_controller.dart';
import 'package:repair/utils/parsing_helper.dart';

import '../model/product_cart_model.dart';
import '../repository/product_cart_repo.dart';

class ProductCartController extends GetxController implements GetxService {
  final ProductCartRepo productCartRepo;

  ProductCartController({required this.productCartRepo});

  List<CartProductModel> _cartList = [];
  List<CartProductModel> _initialCartList = [];

  List<XFile>? _pickedImageFiles = [];

  List<XFile>? get pickedImageFile => _pickedImageFiles;

  File? _selectedVideoFile;

  File? get selectedVideoFile => _selectedVideoFile;

  PlatformFile? _selectedDocumentFile;

  PlatformFile? get selectedDocumentFile => _selectedDocumentFile;

  FilePickerResult? _otherFile;

  FilePickerResult? get otherFile => _otherFile;

  File? _file;
  PlatformFile? objFile;

  File? get file => _file;
  List<MultipartBody> _selectedImageList = [];

  List<MultipartBody> get selectedImageList => _selectedImageList;
  bool _isLoading = false;
  RxBool isNewLoading = false.obs;
  double _amount = 0.0;
  bool _isOthersInfoValid = false;
  double _totalPrice = 0;
  bool _isButton = false;

  List<CartProductModel> get cartList => _cartList;

  List<CartProductModel> get initialCartList => _initialCartList;

  double get amount => _amount;

  bool get isLoading => _isLoading;

  bool get isOthersInfoValid => _isOthersInfoValid;

  double get totalPrice => _totalPrice;

  bool get isButton => _isButton;

  @override
  void onInit() {
    if (Get.find<AuthController>().isLoggedIn()) {
      getCartListFromServer();
    } else {
      getCartData();
    }
    super.onInit();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    update();
  }

  Future<List<CartProductModel>> getCartData() async {
    try {
      print("in getCarData");
      _isLoading = false;
      _cartList = [];
      _cartList.addAll(productCartRepo.getCartList());
      _cartList.forEach((cart) {
        _amount = _amount + (cart.discountedPrice * cart.quantity);
      });

      _isLoading = false;
      _cartTotalCost();
      update();
    } catch (e, s) {
      print("error in getCartData $e ");
    }
    return _cartList;
  }

  _cartTotalCost() {
    _totalPrice = 0.0;
    _cartList.forEach((cartModel) {
      _totalPrice = _totalPrice + (cartModel.price * cartModel.quantity);
    });
    print("total price : $totalPrice");
  }

  Future<void> getCartListFromServer({bool shouldUpdate = true}) async {
    _isLoading = true;
    try {
      print("in getCartListFromServer");

      Response response = await productCartRepo.getCartListFromServer();
      if (response.statusCode == 200) {
        _cartList = [];
        response.body['content']['data'].forEach((cart) {
          _cartList.add(CartProductModel.fromJson(cart));
        });
      } else {
        ApiChecker.checkApi(response);
      }

      _totalPrice = 0.0;
      double _couponDiscount = 0.0;
      _cartList.forEach((cartModel) {
        _totalPrice = _totalPrice + cartModel.subTotal;
        _couponDiscount = _couponDiscount + cartModel.discountedPrice;

      });
      if (_couponDiscount == 0) {
        Get.find<CouponController>().removeCouponData(false);
      }

      _isLoading = false;
      if (shouldUpdate) {
        update();
      }
    } catch (e, s) {
      print("error in getCartListFromServer $e ");
      print("$s");
    }
  }

  Future<void> removeCartFromServer(String cartID) async {
    _isLoading = true;
    Response response = await productCartRepo.removeCartFromServer(cartID);
    if (response.statusCode == 200) {
      getCartListFromServer();
    }
    _isLoading = false;
    update();
  }

  Future<void> removeAllCartItem() async {
    Response response = await productCartRepo.removeAllCartFromServer();
    if (response.statusCode == 200) {
      _isLoading = false;
      getCartListFromServer(shouldUpdate: false);
    }
  }

  Future<void> updateCartQuantityToApi(String cartID, int quantity) async {
    print("In updateCartQuantity api");
    _isLoading = true;
    Response response = await productCartRepo.updateCartQuantity(cartID, quantity);
    if (response.statusCode == 200) {
      getCartListFromServer();
    }
    _isLoading = false;
    update();
  }

  void removeFromCartVariation(CartProductModel? cartModel) {
    if (cartModel == null) {
      _initialCartList = [];
    } else {
      _initialCartList.remove(cartModel);
      update();
    }
  }

  void removeFromCartList(int cartIndex) {
    _cartList[cartIndex].quantity = _cartList[cartIndex].quantity - 1;
    update();
  }

  void updateQuantity(int index, bool isIncrement) {
    if (isIncrement) {
      _initialCartList[index].quantity += 1;
    } else {
      if (_initialCartList[index].quantity > -1) {
        _initialCartList[index].quantity -= 1;
      }
    }
    _isButton = _isQuantity();
    update();
  }

  bool _isQuantity() {
    int _count = 0;
    _initialCartList.forEach((cart) {
      _count += cart.quantity;
    });
    return _count > 0;
  }

  void setQuantity(bool isIncrement, CartProductModel cart) {
    int index = _cartList.indexWhere((element) => element == cart);
    if (isIncrement) {
      _cartList[index].quantity = _cartList[index].quantity + 1;
      _amount = _amount + _cartList[index].discountedPrice;
    } else {
      _cartList[index].quantity = _cartList[index].quantity - 1;
      _amount = _amount - _cartList[index].discountedPrice;
    }
    productCartRepo.addToCartList(_cartList);

    _cartTotalCost();

    update();
  }

  void removeFromCart(int index) {
    _amount = _amount - (_cartList[index].discountedPrice * _cartList[index].quantity);
    _cartList.removeAt(index);
    productCartRepo.addToCartList(_cartList);
    update();
  }

  void clearCartList() {
    _cartList = [];
    _amount = 0;
    productCartRepo.addToCartList(_cartList);
    update();
  }

  // void addDataToCart(String? productId, String varientId) {
  void addDataToCart() {
    if (_cartList.length > 0 && _initialCartList.first.id != _cartList.first.id) {
      Get.back();
      Get.dialog(ConfirmationDialog(
        icon: Images.warning,
        title: "are_you_sure_to_reset".tr,
        description: 'you_have_service_from_other_sub_category'.tr,
        onNoPressed: () {
          Get.back();
        },
        onYesPressed: () async {
          _initialCartList.removeWhere((_cart) => _cart.quantity < 1);
          productCartRepo.addToCartList(_initialCartList);
          _cartList = _initialCartList;
          _cartTotalCost();
          update();
          onDemandToast("successfully_added_to_cart".tr, Colors.green);
          // Get.toNamed(RouteHelper.getCompanyRoute(id!, subCategoryId), arguments: CompanyScreen(serviceID: id, subCategoryId: subCategoryId));
        },
      ));
    } else {
      productCartRepo.addToCartList(_replaceCartList());
      _cartTotalCost();
      update();
      onDemandToast("successfully_added_to_cart".tr, Colors.green);
      // Get.toNamed(RouteHelper.getCompanyRoute(id!, subCategoryId), arguments: CompanyScreen(serviceID: id, subCategoryId: subCategoryId));
    }
  }

  Future<void> addCartToServer(BuildContext context) async {
    _isLoading = true;
    update();
    _replaceCartList();

    if (_initialCartList.first.id != _cartList.first.id) {
      Get.back();
      Get.dialog(ConfirmationDialog(
        icon: Images.warning,
        title: "are_you_sure_to_reset".tr,
        description: 'you_have_service_from_other_sub_category'.tr,
        onNoPressed: () {
          Get.back();
        },
        onYesPressed: () async {
          Get.offAndToNamed(RouteHelper.getProductCartRoute());

          // Get.toNamed(RouteHelper.getCompanyRoute(id!,subCategoryId),
          //     arguments: CompanyScreen(serviceID: id, subCategoryId:subCategoryId));
          // Get.dialog(
          //   CustomLoader(),
          //   barrierDismissible: false,
          // );
          // await productCartRepo.removeAllCartFromServer();
          if (_initialCartList.length > 0) {
            for (int index = 0; index < _initialCartList.length; index++) {
              await addToCartApi(_initialCartList[index]);
            }
          }
          _isLoading = false;
          onDemandToast("successfully_added_to_cart".tr, Colors.green);
          clearCartList();
          await getCartListFromServer();
          Get.toNamed(RouteHelper.getProductCartRoute());
          // Get.toNamed(RouteHelper.getCompanyRoute(id,subCategoryId),
          //     arguments: CompanyScreen(serviceID: id, subCategoryId:subCategoryId));
        },
      ));
    } else {
      await productCartRepo.removeAllCartFromServer();
      if (_cartList.length > 0) {
        for (int index = 0; index < _cartList.length; index++) {
          await addToCartApi(_cartList[index]);
        }
      }
      _isLoading = false;
      onDemandToast("successfully_added_to_cart".tr, Colors.green);
      clearCartList();
      Get.toNamed(RouteHelper.getProductCartRoute());
      // Get.toNamed(RouteHelper.getCompanyRoute(id!,subCategoryId),
      //     arguments: CompanyScreen(serviceID: id, subCategoryId:subCategoryId));
    }
    update();
  }

  Future<void> addMultipleCartToServer() async {
    _isLoading = true;
    update();
    _replaceCartList();

    if (_initialCartList.first.id != _cartList.first.id) {
      Get.back();
      Get.dialog(ConfirmationDialog(
        icon: Images.warning,
        title: "are_you_sure_to_reset".tr,
        description: 'you_have_service_from_other_sub_category'.tr,
        onNoPressed: () {
          Get.back();
        },
        onYesPressed: () async {
          Get.back();
          Get.dialog(
            CustomLoader(),
            barrierDismissible: false,
          );
          await productCartRepo.removeAllCartFromServer();
          if (_initialCartList.length > 0) {
            for (int index = 0; index < _initialCartList.length; index++) {
              await addToCartApi(_initialCartList[index]);
            }
          }
          _isLoading = false;
          onDemandToast("successfully_added_to_cart".tr, Colors.green);
          clearCartList();
          await getCartListFromServer();
          Get.back();
        },
      ));
    } else {
      await productCartRepo.removeAllCartFromServer();
      if (_cartList.length > 0) {
        for (int index = 0; index < _cartList.length; index++) {
          await addToCartApi(_cartList[index]);
        }
      }
      _isLoading = false;
      onDemandToast("successfully_added_to_cart".tr, Colors.green);
      clearCartList();
      Get.back();
    }
    update();
  }

  Future<void> addToCartApi(CartProductModel cartModel) async {
    await productCartRepo.addToCartListToServer(
      ProductCartModelBody(
        productId: cartModel.isFromSubCategory ? cartModel.productId : cartModel.id,
        variantKey: cartModel.productVariantId.toString(),
        quantity: cartModel.quantity.toString(),
      ),
    );
  }

  void removeAllAndAddToCart(CartProductModel cartModel) {
    _cartList = [];
    _cartList.add(cartModel);
    _amount = cartModel.discountedPrice.toDouble() * cartModel.quantity;
    productCartRepo.addToCartList(_cartList);
    update();
  }

  int isAvailableInCart(CartProductModel cartModel, CartProductModel service) {
    int _index = -1;
    _cartList.forEach((cart) {
      // if (cart.service != null) {
      //   if (cart.service!.id!.contains(service.id!)) {
      //     service.variationsAppFormat?.zoneWiseVariations?.forEach((variation) {
      //       if (variation.variantKey == cart.variantKey && variation.price == cart.serviceCost) {
      //         if (cart.variantKey == cartModel.variantKey) {
      //           _index = _cartList.indexOf(cart);
      //         }
      //       }
      //     });
      //   }
      // }
    });
    return _index;
  }

  setInitialCartList(Product service, List<ProductVariations>? productVariations, bool isFromSubCategory) {
    _initialCartList = [];
    if (isFromSubCategory) {
      productVariations?.forEach((variation) {
        print("pvId: ${variation.pvID}");
        CartProductModel _cartModel = CartProductModel.fromJson(service.toJson()).copyWith(subisFromSubCategory: isFromSubCategory);
        _cartModel.productVariantId = variation.pvID;
        // CartProductModel _cartModel = CartProductModel();
        int _index = isAvailableInCart(_cartModel, CartProductModel.fromJson(service.toJson()));
        if (_index != -1) {
          _cartModel.copyWith(cartId: _cartList[_index].id, cartQuantity: _cartList[_index].quantity);
        }
        _initialCartList.add(_cartModel);
      });
    } else {
      service.variations?.forEach((variation) {
        CartProductModel _cartModel = CartProductModel.fromJson(service.toJson());
        _cartModel.productVariantId = variation.id;
        // CartProductModel _cartModel = CartProductModel();
        int _index = isAvailableInCart(_cartModel, CartProductModel.fromJson(service.toJson()));
        if (_index != -1) {
          _cartModel.copyWith(cartId: _cartList[_index].id, cartQuantity: _cartList[_index].quantity);
        }
        _initialCartList.add(_cartModel);
      });
    }
    print("initialCartList :  ${initialCartList.length}");
    _isButton = false;
  }

  List<CartProductModel> _replaceCartList() {
    _initialCartList.removeWhere((_cart) => _cart.quantity < 0);

    _initialCartList.forEach((_initCart) {
      // _cartList.removeWhere((cart) => cart.id.contains(_initCart.id) && cart.variantKey.contains(_initCart.variantKey));
    });
    _cartList.addAll(_initialCartList);
    _cartList.removeWhere((element) => element.quantity == 0);
    return _cartList;
  }

  Future<void> pickMultipleImage(bool isRemove, {int? index}) async {
    if (isRemove) {
      if (index != null) {
        _pickedImageFiles!.removeAt(index);
        _selectedImageList.removeAt(index);
      }
    } else {
      _pickedImageFiles = await ImagePicker().pickMultiImage(imageQuality: 40);
      if (_pickedImageFiles != null) {
        for (int i = 0; i < _pickedImageFiles!.length; i++) {
          _selectedImageList.add(MultipartBody('service_image', _pickedImageFiles![i]));
        }
      }
    }
    print(selectedImageList);
    update();
  }

  void pickOtherFile(bool isRemove) async {
    if (isRemove) {
      _otherFile = null;
      _file = null;
    } else {
      _otherFile = (await FilePicker.platform.pickFiles(withReadStream: true))!;
      if (_otherFile != null) {
        objFile = _otherFile!.files.single;
      }
    }
    update();
  }

  void removeFile() async {
    _pickedImageFiles = [];
    _selectedImageList = [];
    _otherFile = null;
    _file = null;
    update();
  }

  Future<bool> uploadFiles() async {
    bool result = false;
    // setIsLoading(true);
    // Timer(Duration(seconds: 5),() {
    //   setIsLoading(false);
    // },);
    update();
    print("selectedImageList : ${selectedImageList.length}");
    Response response = await productCartRepo.uploadFile(file: _selectedImageList);

    // conversationController.value.text,
    // channelID,
    // _selectedImageList,
    // objFile);
    print(response.body);
    if (response.statusCode == 200) {
      // _isLoading = false;

      // getConversation(
      //   channelID,
      //   1,
      // );
      // conversationController.text = '';
      _pickedImageFiles = [];
      _selectedImageList = [];
      _otherFile = null;
      _file = null;
      CommonModel commonModelResponse = CommonModel.fromJson(response.body);
      if (commonModelResponse.message.isNotEmpty) {
        onDemandToast(commonModelResponse.message, Colors.green);
      }
      result = true;
    } else {
      _isLoading = false;
      _pickedImageFiles = [];
      _otherFile = null;
      _file = null;
      CommonModel commonModelResponse = CommonModel.fromJson(response.body);
      if (commonModelResponse.message.isNotEmpty) {
        onDemandToast("Failed to upload", Colors.red);
      }
      ApiChecker.checkApi(response);
      result = false;
    }
    update();
    return result;
  }

  Future<bool> uploadVideoOrDocument({String keyName = "", List<XFile> files = const [], bool isVideo = false}) async {
    List<MultipartBody> fileList = [];
    if (files.isNotEmpty) {
      files.forEach((element) {
        MultipartBody multipartBody = MultipartBody(keyName, element);
        fileList.add(multipartBody);
      });
    }
    Response response = await productCartRepo.uploadVideoAndDocument(file: fileList, isVideo: isVideo);

    print(response.body);
    if (response.statusCode == 200) {
      CommonModel commonModelResponse = CommonModel.fromJson(response.body);
      if (commonModelResponse.message.isNotEmpty) {
        onDemandToast(commonModelResponse.message, Colors.green);
      }
      return true;
    } else {
      _isLoading = false;
      CommonModel commonModelResponse = CommonModel.fromJson(ParsingHelper.parseMapMethod(response.body));
      if (commonModelResponse.message.isNotEmpty) {
        onDemandToast("Failed to upload", Colors.green);
      }
      ApiChecker.checkApi(response);
      return false;
    }
  }
}
