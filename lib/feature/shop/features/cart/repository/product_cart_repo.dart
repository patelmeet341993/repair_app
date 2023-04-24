import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/notification/repository/notification_repo.dart';
import 'package:repair/feature/shop/features/cart/model/product_cart_model_body.dart';

import '../model/product_cart_model.dart';

class ProductCartRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  ProductCartRepo({required this.sharedPreferences, required this.apiClient});

  List<CartProductModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.PRODUCT_CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.PRODUCT_CART_LIST)!;
    }
    List<CartProductModel> cartList = [];
    carts.forEach((cart) => cartList.add(CartProductModel.fromJson(jsonDecode(cart))));
    return cartList;
  }

  void addToCartList(List<CartProductModel> cartProductList) {
    List<String> carts = [];
    cartProductList.forEach((cartModel) => carts.add(jsonEncode(cartModel)));
    cartProductList.forEach((element) {
      print(element.id);
    });

    sharedPreferences.setStringList(AppConstants.PRODUCT_CART_LIST, carts);
  }

  Future<Response> addToCartListToServer(ProductCartModelBody cartModel) async {

    return await apiClient.postData(
        AppConstants.PRODUCT_ADD_TO_CART, cartModel.toJson());
  }

  ///TODO: changing here for getting the cart list for the product
  Future<Response> getCartListFromServer() async {
    return await apiClient.getData(AppConstants.PRODUCT_GET_CART_LIST);
  }

  Future<Response> removeCartFromServer(String cartID) async {
    return await apiClient
        .postData(AppConstants.PRODUCT_REMOVE_FROM_CART_ITEM,{"id": cartID});
  }

  Future<Response> removeAllCartFromServer() async {
    return await apiClient.deleteData(AppConstants.REMOVE_ALL_CART_ITEM);
  }

  // Future<Response> updateCartQuantity(String cartID, int quantity) async {
  //   return await apiClient.putData(
  //       AppConstants.UPDATE_PRODUCT_CART_QUANTITY + "$cartID", {'quantity': quantity});
  // }
  Future<Response> updateCartQuantity(String cartId, int quantity) async {
    return await apiClient.postData(
        AppConstants.UPDATE_PRODUCT_CART_QUANTITY, {
          "id":"$cartId",
          'quantity': quantity});
  }


  Future<Response> uploadFile({String message = "", String channelID = "", List<MultipartBody> file = const [], PlatformFile? platformFile}) async {
    return await apiClient.postMultipartData(
        AppConstants.UPLOADIMAGE,
        {},
        file);
  }
  Future<Response> uploadVideoAndDocument({String message = "", String channelID = "", List<MultipartBody> file = const [], PlatformFile? platformFile, bool isVideo = false}) async {
    return await apiClient.postMultipartData(
        isVideo ? AppConstants.UPLOADVIDEO : AppConstants.UPLOADPDF,
        {},
        file);
  }
}
