import 'package:repair/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:repair/components/footer_base_view.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/cart/widget/cart_product_widget.dart';
import 'package:repair/feature/shop/features/cart/controller/product_cart_controller.dart';
import 'package:repair/feature/shop/features/cart/controller/product_cart_controller.dart';
import 'package:repair/feature/shop/features/cart/controller/product_cart_controller.dart';
import 'package:repair/feature/shop/features/cart/controller/product_cart_controller.dart';
import 'package:repair/feature/shop/features/cart/widget/product_cart_product_widget.dart';

class ProductCartScreen extends StatelessWidget {
  final fromNav;

  ProductCartScreen({@required this.fromNav});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: ResponsiveHelper.isDesktop(context) ? MenuDrawer() : null,
      appBar: CustomAppBar(
          onBackPressed: () {
            Get.until((route) => Get.currentRoute == "/");
          },
          title: 'product_cart'.tr,
          isBackButtonExist: (ResponsiveHelper.isDesktop(context) || !fromNav)),
      body: SafeArea(
        child: GetBuilder<ProductCartController>(
          initState: (state) {
            Get.find<ProductCartController>().cartList.forEach((cart) async {
              if (cart.productVariant == null) {
                await Get.find<ProductCartController>().removeCartFromServer(cart.id);
              }
            });
          },
          builder: (productCartController) {
            return Column(
              children: [
                Expanded(
                  child: FooterBaseView(
                    isCenter: (productCartController.cartList.length == 0),
                    child: SizedBox(
                      width: Dimensions.WEB_MAX_WIDTH,
                      child: GetBuilder<ProductCartController>(
                        builder: (cartController) {
                          if (cartController.isLoading) {
                            return CustomLoader();
                          } else {
                            if (cartController.cartList.length > 0) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Padding(
                                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${cartController.cartList.length} ${'product_in_cart'.tr}",
                                            style: ubuntuMedium.copyWith(
                                              fontSize: Dimensions.fontSizeDefault,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GridView.builder(
                                      key: UniqueKey(),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
                                        mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_LARGE : Dimensions.PADDING_SIZE_MINI,
                                        childAspectRatio: ResponsiveHelper.isMobile(context) ? 5 : 6,
                                        crossAxisCount: ResponsiveHelper.isMobile(context)
                                            ? 1
                                            : cartController.cartList.length > 1
                                                ? 2
                                                : 1,
                                        mainAxisExtent: ResponsiveHelper.isMobile(context) ? 115 : 125,
                                      ),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: cartController.cartList.length,
                                      itemBuilder: (context, index) {
                                        return cartController.cartList[index].productVariant != null
                                            ? ProductCartWidget(
                                                cart: cartController.cartList[index],
                                                cartIndex: index,
                                                onMinusTap: () {
                                                  if (Get.find<AuthController>().isLoggedIn()) {
                                                    Get.find<ProductCartController>().updateCartQuantityToApi(
                                                        cartController.cartList[index].id, cartController.cartList[index].quantity - 1);
                                                  } else {
                                                    Get.find<ProductCartController>().setQuantity(false, cartController.cartList[index]);
                                                  }
                                                },
                                                onPlusTap: () {
                                                  if (Get.find<AuthController>().isLoggedIn()) {
                                                    Get.find<ProductCartController>().updateCartQuantityToApi(
                                                        cartController.cartList[index].id, cartController.cartList[index].quantity + 1);
                                                  } else {
                                                    Get.find<ProductCartController>().setQuantity(true, cartController.cartList[index]);
                                                  }
                                                },
                                              )
                                            : SizedBox();
                                      },
                                    ),
                                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                  ]),
                                  if (ResponsiveHelper.isWeb() && !ResponsiveHelper.isTab(context) && !ResponsiveHelper.isMobile(context))
                                    cartController.cartList.length > 0
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                            ),
                                            child: Column(
                                              children: [
                                                Divider(),
                                                Container(
                                                  height: 50,
                                                  child: Center(
                                                    child: RichText(
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      text: TextSpan(
                                                        text: 'total_price'.tr,
                                                        style: ubuntuRegular.copyWith(
                                                          fontSize: Dimensions.fontSizeLarge,
                                                          color: Theme.of(context).textTheme.bodyText1!.color,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text: ' ${PriceConverter.convertPrice(cartController.totalPrice)}',
                                                            style: ubuntuBold.copyWith(
                                                              color: Theme.of(context).errorColor,
                                                              fontSize: Dimensions.fontSizeLarge,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: Dimensions.PADDING_SIZE_SMALL,
                                                  ),
                                                  child: CustomButton(
                                                    height: 50,
                                                    width: Get.width,
                                                    radius: Dimensions.RADIUS_DEFAULT,
                                                    buttonText: 'proceed_to_checkout'.tr,
                                                    onPressed: () {
                                                      if (Get.find<AuthController>().isLoggedIn()) {
                                                        Get.find<CheckOutController>().updateState(PageState.orderDetails);
                                                        Get.toNamed(
                                                            RouteHelper.getCheckoutRoute(RouteHelper.checkout, 'orderDetails', 'null', isFromProduct: true));
                                                      } else {
                                                        Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(),
                                ],
                              );
                            } else {
                              return NoDataScreen(
                                text: "cart_is_empty".tr,
                                type: NoDataType.CART,
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                if ((ResponsiveHelper.isTab(context) || ResponsiveHelper.isMobile(context)) && productCartController.cartList.length > 0)
                  Column(
                    children: [
                      Divider(
                        height: 2,
                        color: Theme.of(context).shadowColor,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'total_price'.tr,
                                style: ubuntuRegular.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),
                                ),
                              ),
                              Text(
                                ' ${PriceConverter.convertPrice(productCartController.totalPrice, isShowLongPrice: true)} ',
                                style: ubuntuBold.copyWith(
                                  color: Theme.of(context).errorColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                          right: Dimensions.PADDING_SIZE_DEFAULT,
                          bottom: Dimensions.PADDING_SIZE_SMALL,
                        ),
                        child: CustomButton(
                          width: Get.width,
                          radius: Dimensions.RADIUS_DEFAULT,
                          buttonText: 'proceed_to_checkout'.tr,
                          onPressed: () {
                            if (Get.find<AuthController>().isLoggedIn()) {
                              Get.find<CheckOutController>().updateState(PageState.orderDetails);
                              Get.toNamed(RouteHelper.getCheckoutRoute('cart', 'orderDetails', 'null', isFromProduct: true));
                            } else {
                              Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                            }
                          },
                        ),
                      ),
                    ],
                  )
              ],
            );
          },
        ),
      ),
      // bottomSheet: FooterView(),
    );
  }
}
