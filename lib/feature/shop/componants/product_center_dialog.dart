import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:repair/feature/shop/features/cart/controller/product_cart_controller.dart';
import 'package:repair/feature/shop/features/products/controller/product_controller.dart';

import '../features/products/model/product_model.dart';

class ProductCenterDialog extends StatefulWidget {
  final Product? product;
  final CartModel? cart;
  final int? cartIndex;
  final bool? isFromDetails;
  final bool isFromSubCategory;
  List<ProductVariations>? productVariations;

  ProductCenterDialog({required this.product, this.cart, this.cartIndex, this.isFromDetails = false, this.isFromSubCategory = false, this.productVariations});

  @override
  State<ProductCenterDialog> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductCenterDialog> {
  @override
  void initState() {
    Get.find<ProductCartController>().setInitialCartList(widget.product!,widget.productVariations, widget.isFromSubCategory);
    super.initState();

    print("productVariationList :isFromSubCategory${widget.isFromSubCategory} ${widget.productVariations?.length}");
  }

  int count = 1;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context))
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
        insetPadding: EdgeInsets.all(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: pointerInterceptor(),
      );
    return pointerInterceptor();
  }

  pointerInterceptor() {
    return Padding(
      padding: EdgeInsets.only(top: ResponsiveHelper.isWeb() ? 0 : Dimensions.CART_DIALOG_PADDING),
      child: PointerInterceptor(
        child: Container(
          width: ResponsiveHelper.isDesktop(context) ? Dimensions.WEB_MAX_WIDTH / 1.5 : Dimensions.WEB_MAX_WIDTH,
          padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
          ),
          child: GetBuilder<ProductCartController>(builder: (productCartControllerInit) {
            return GetBuilder<ProductController>(builder: (serviceController) {
              if (widget.product!.variations != null || widget.isFromSubCategory)
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: Dimensions.PADDING_SIZE_DEFAULT,
                        left: Dimensions.PADDING_SIZE_DEFAULT,
                        top: 150,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.PADDING_SIZE_DEFAULT,
                                bottom: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                      bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                    ),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: widget.isFromSubCategory ? widget.productVariations?.length : widget.product!.variations!.length,
                                    itemBuilder: (context, index) {
                                      //variation item
                                      ProductVariations productVariation =   widget.isFromSubCategory ?  widget.productVariations![index]: widget.product!.variations![index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                                        child: Container(
                                            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).hoverColor,
                                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_DEFAULT))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "${productVariation.attributeName} - ${productVariation.attributeValue}",
                                                          style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        SizedBox(
                                                          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                                        ),
                                                        Text(
                                                            PriceConverter.convertPrice(
                                                                double.parse(productVariation.packateMeasurementDiscountPrice),
                                                                isShowLongPrice: true),
                                                            style: ubuntuMedium.copyWith(
                                                                color: Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                                                                fontSize: Dimensions.fontSizeSmall)),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(child: SizedBox()),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        // InkWell(
                                                        //   onTap: () {
                                                        //     if (count > 1) {
                                                        //       count -= 1;
                                                        //       setState(() {});
                                                        //     }
                                                        //     // cartController.updateQuantity(index, false);
                                                        //   },
                                                        //   child: Container(
                                                        //     height: 30,
                                                        //     width: 30,
                                                        //     margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                                        //     decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.secondary),
                                                        //     alignment: Alignment.center,
                                                        //     child: Icon(
                                                        //       Icons.remove,
                                                        //       size: 15,
                                                        //       color: Theme.of(context).cardColor,
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                        productCartControllerInit.initialCartList[index].quantity > 0
                                                            ? InkWell(
                                                                onTap: () {
                                                                  if (count > 1) {
                                                                    count -= 1;
                                                                    setState(() {});
                                                                  }
                                                                  productCartControllerInit.updateQuantity(index, false);
                                                                },
                                                                child: Container(
                                                                  height: 30,
                                                                  width: 30,
                                                                  margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                                                  decoration:
                                                                      BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.secondary),
                                                                  alignment: Alignment.center,
                                                                  child: Icon(
                                                                    Icons.remove,
                                                                    size: 15,
                                                                    color: Theme.of(context).cardColor,
                                                                  ),
                                                                ),
                                                              )

                                                            // Text(
                                                            //   "$count",
                                                            // ),
                                                            : SizedBox(),
                                                        productCartControllerInit.initialCartList[index].quantity > 0
                                                            ? Text(
                                                                "${productCartControllerInit.initialCartList[index].quantity}",
                                                              )
                                                            : SizedBox(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (count >= 1) {
                                                              count += 1;
                                                              setState(() {});
                                                            }
                                                            productCartControllerInit.updateQuantity(index, true);
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                                            decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.secondary),
                                                            alignment: Alignment.center,
                                                            child: Icon(
                                                              Icons.add,
                                                              size: 15,
                                                              color: Theme.of(context).cardColor,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      );
                                    },
                                  ),
                                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                              SizedBox(
                                width: Dimensions.PADDING_SIZE_LARGE,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_DEFAULT)),
                                child: CustomImage(
                                  image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/product/${widget.product!.image}',
                                  height: Dimensions.IMAGE_SIZE_MEDIUM,
                                  width: Dimensions.IMAGE_SIZE_MEDIUM,
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white70.withOpacity(0.6),
                                    boxShadow: Get.isDarkMode
                                        ? null
                                        : [
                                            BoxShadow(
                                              color: Colors.grey[300]!,
                                              blurRadius: 2,
                                              spreadRadius: 1,
                                            )
                                          ]),
                                child: InkWell(
                                    onTap: () => Get.back(),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black54,
                                    )),
                              )
                            ]),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: Dimensions.PADDING_SIZE_RADIUS,
                                  ),
                                  Text(
                                    widget.product!.name,
                                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: Dimensions.PADDING_SIZE_MINI,
                                  ),
                                  Text(
                                    "${widget.isFromSubCategory? widget.productVariations?.length: widget.product!.variations!.length} ${'options_available'.tr}",
                                    style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5)),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: Dimensions.PADDING_SIZE_DEFAULT,
                      right: Dimensions.PADDING_SIZE_DEFAULT,
                      bottom: Dimensions.PADDING_SIZE_DEFAULT,
                      child: GetBuilder<ProductCartController>(builder: (productCartController) {
                        bool _addToCart = true;
                        return productCartController.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : CustomButton(
                                height: ResponsiveHelper.isDesktop(context) ? 50 : 45,
                                onPressed: productCartControllerInit.isButton
                                    ? () async {
                                        if (_addToCart) {
                                          _addToCart = false;
                                          if (Get.find<AuthController>().isLoggedIn()) {
                                            await productCartController.addCartToServer(context);
                                            await productCartController.getCartListFromServer();
                                            // Get.back();
                                          } else {
                                            productCartController.addDataToCart();
                                            //cartController.addDataInCart();
                                          }
                                        }
                                      }
                                    : null,
                                buttonText: (productCartController.cartList.length > 0 && productCartController.cartList.elementAt(0).id == widget.product!.id)
                                    ? 'update_cart'.tr
                                    : 'add_to_cart'.tr);
                      }),
                    )
                  ],
                );
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 20,
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white70.withOpacity(0.6),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]!,
                            blurRadius: 2,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: InkWell(onTap: () => Get.back(), child: Icon(Icons.close)),
                    ),
                  ),
                  Container(
                    height: Get.height / 7,
                    child: Center(
                      child: Text(
                        'no_variation_is_available'.tr,
                        style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                      ),
                    ),
                  )
                ],
              );
            });
          }),
        ),
      ),
    );
  }
}
