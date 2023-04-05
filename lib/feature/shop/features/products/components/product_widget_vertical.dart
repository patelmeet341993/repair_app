import 'package:get/get.dart';
import 'package:repair/components/ripple_button.dart';
import 'package:repair/components/service_center_dialog.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/componants/product_center_dialog.dart';
import 'package:repair/feature/shop/features/product_coupon/model/product_coupon_model.dart';

import '../../../../../components/product_cart_widget.dart';
import '../../../../../utils/parsing_helper.dart';
import '../model/product_model.dart';

class ProductWidgetVertical extends StatelessWidget {
  final Product product;
  final bool isAvailable;
  final String fromType;
  final bool isFromSubCategoryProductView;

  ProductWidgetVertical({
    Key? key,
    required this.product,
    required this.isAvailable,
    required this.fromType,
    this.isFromSubCategoryProductView = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num _lowestPrice = 0.0;

    // if (fromType == 'fromCampaign') {
    //   if (product.variations != null) {
    //     _lowestPrice = product.variations![0].price!;
    //     for (var i = 0; i < product.variations!.length; i++) {
    //       if (product.variations![i].price! < _lowestPrice) {
    //         _lowestPrice = product.variations![i].price!;
    //       }
    //     }
    //   }
    // } else {
    //   if (product.variationsAppFormat != null) {
    //     if (product.variationsAppFormat!.zoneWiseVariations != null) {
    //       _lowestPrice = product.variationsAppFormat!.zoneWiseVariations![0].price!;
    //       for (var i = 0; i < product.variationsAppFormat!.zoneWiseVariations!.length; i++) {
    //         if (product.variationsAppFormat!.zoneWiseVariations![i].price! < _lowestPrice) {
    //           _lowestPrice = product.variationsAppFormat!.zoneWiseVariations![i].price!;
    //         }
    //       }
    //     }
    //   }
    // }

    CouponProductDiscount _discountModel = PriceConverter.productDiscountCalculation(product);
    return Container(
      decoration: BoxDecoration(

        // color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          boxShadow: Get.isDarkMode ? null : cardShadow),
      child: MyRippleButton(
        onTap: () {
          print("productID: ${product.id}  ${product.productId} fromType: $isFromSubCategoryProductView");
          Get.toNamed(
            RouteHelper.getProductRoute(isFromSubCategoryProductView ? product.productId : product.id),
          );
        },
        child: Container(
          // margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_RADIUS).copyWith(bottom: 4),
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .cardColor,
            // color: Colors.red,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            //  boxShadow: Get.isDarkMode ? null : cardShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL)),
                    child: CustomImage(
                      image: '${Get
                          .find<SplashController>()
                          .configModel
                          .content!
                          .imageBaseUrl!}/product/${product.image}',
                      fit: BoxFit.cover,
                      width: double.maxFinite,
                      height: Dimensions.HOME_IMAGE_SIZE,
                    ),
                  ),
                  // product.variations!.isNotEmpty
                  //     ? product.variations!.first.packateMeasurementCostPrice != "0"
                  //     ? Padding(
                  //   padding: const EdgeInsets.only(left: 3.0),
                  //   child: Text(
                  //     PriceConverter.convertPrice(
                  //       ParsingHelper.parseDoubleMethod(product.variations!.first.packateMeasurementDiscountPrice),
                  //       isShowLongPrice: true,
                  //     ),
                  //     style: ubuntuRegular.copyWith(
                  //         fontSize: Dimensions.fontSizeSmall,
                  //         color: Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor),
                  //   ),
                  // )
                  //     : SizedBox()
                  //     : SizedBox(),
                  // _discountModel.discountAmount! > 0
                  //     ? Align(
                  //         alignment: Alignment.topRight,
                  //         child: Container(
                  //           padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  //           decoration: BoxDecoration(
                  //             color: Theme.of(context).errorColor,
                  //             borderRadius: BorderRadius.only(
                  //               bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT),
                  //               topRight: Radius.circular(Dimensions.RADIUS_SMALL),
                  //             ),
                  //           ),
                  //           child: Text(
                  //             PriceConverter.percentageOrAmount('${_discountModel.discountAmount}', '${_discountModel.discountAmountType}'),
                  //             style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColorLight),
                  //           ),
                  //         ),
                  //       )
                  //     : SizedBox(),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Expanded(
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        product.name,
                        style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      //SizedBox(height: 3,),
                      Text(
                        product.description,
                        style: ubuntuLight.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme
                            .of(context)
                            .disabledColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                      // SizedBox(height: 4,),
                      //add to cart button
                      if (fromType != 'fromCampaign')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              // onTap: () => Get.toNamed(RouteHelper.getCartRoute()),
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    useRootNavigator: true,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) =>
                                        ProductCenterDialog(
                                          product: product,
                                          isFromDetails: true,
                                        ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme
                                        .of(context)
                                        .primaryColor
                                ),
                                padding: EdgeInsets.all(2),
                                child: ProductCartWidget(
                                    color: Get.isDarkMode
                                        ? Theme
                                        .of(context)
                                        .primaryColor
                                        : Colors.white,
                                    size: Dimensions.PRODUCT_CART_WIDGET_SIZE),
                              ),
                            )
                            // CommonSubmitButton(
                            //     text: 'Book Now'.tr,
                            //     fontSize: Dimensions.fontSizeSmall,
                            //     onTap: () {
                            //       showModalBottomSheet(
                            //           useRootNavigator: true,
                            //           isScrollControlled: true,
                            //           backgroundColor: Colors.transparent,
                            //           context: context,
                            //           builder: (context) =>
                            //               ProductCenterDialog(product: product));
                            //       // Get.toNamed(RouteHelper.getCompanyRoute(product.id ?? "", product.subCategoryId ?? ""),
                            //       //     arguments: CompanyScreen(serviceID: product.id ?? "", subCategoryId: product.subCategoryId ?? ""));
                            //     }),
                          ],
                        ),
                      /*  Stack(
                          children: [
                            Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: SizedBox(
                                  height: 30.0,
                                  width: 100.0,
                                  child: CustomButtonSmall(
                                    buttonText: 'Book Now'.tr,
                                  ),
                                )),
                            Positioned.fill(
                              child: CustomButtonSmall(
                                  buttonText: 'Book Now'.tr,
                                  onPressed: () {
                                    showModalBottomSheet(
                                        useRootNavigator: true,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) =>
                                            ServiceCenterDialog(service: service));
                                  }),
                            )
                          ],
                        ),*/
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
