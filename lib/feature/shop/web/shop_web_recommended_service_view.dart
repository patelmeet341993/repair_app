import 'package:repair/feature/home/web/web_campaign_view.dart';
import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/features/product_coupon/model/product_coupon_model.dart';
import 'package:repair/feature/shop/features/products/controller/product_controller.dart';

import '../features/products/model/product_model.dart';

class ShopWebRecommendedServiceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      initState: (state) {
        Get.find<ProductController>().getRecommendedProductList(1, false);
      },
      builder: (productController) {
        if (productController.recommendedProductList != null && productController.recommendedProductList!.length == 0) {
          return SizedBox();
        } else {
          if (productController.recommendedProductList != null) {
            List<Product>? _recommendedProductList = productController.recommendedProductList;
            return Container(
              width: Dimensions.WEB_MAX_WIDTH / 3.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: Text('recommended_for_you'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _recommendedProductList!.length > 2 ? 3 : _recommendedProductList.length,
                    itemBuilder: (context, index) {
                      CouponProductDiscount _discount = PriceConverter.productDiscountCalculation(productController.recommendedProductList![index]);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: InkWell(
                          onTap: () => Get.toNamed(RouteHelper.getServiceRoute(_recommendedProductList[index].id)),
                          child: ProductModelView(
                            serviceList: productController.recommendedProductList!,
                            discountAmountType: _discount.discountAmountType,
                            discountAmount: _discount.discountAmount,
                            index: index,
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE, horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    child: CustomButton(
                      buttonText: 'see_all'.tr,
                      onPressed: () => Get.toNamed(RouteHelper.allProductScreenRoute("fromRecommendedScreen")),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return WebCampaignShimmer(
              enabled: true,
            );
          }
        }
      },
    );
  }
}

class ProductModelView extends StatelessWidget {
  final List<Product> serviceList;
  final int index;
  final num? discountAmount;
  final String? discountAmountType;

  const ProductModelView({
    Key? key,
    required this.serviceList,
    required this.index,
     this.discountAmount,
     this.discountAmountType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _lowestPrice = 0.0;
    // if (serviceList[index].variationsAppFormat!.zoneWiseVariations != null) {
    //   _lowestPrice = serviceList[index].variationsAppFormat!.zoneWiseVariations![0].price!.toDouble();
    //   for (var i = 0; i < serviceList[index].variationsAppFormat!.zoneWiseVariations!.length; i++) {
    //     if (serviceList[index].variationsAppFormat!.zoneWiseVariations![i].price! < _lowestPrice) {
    //       _lowestPrice = serviceList[index].variationsAppFormat!.zoneWiseVariations![i].price!.toDouble();
    //     }
    //   }
    // }
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_RADIUS),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        boxShadow: Get.isDarkMode ? null : cardShadow,
      ),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          child: CustomImage(
            image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/product/${serviceList[index].image}',
            height: 111,
            width: 90,
            fit: BoxFit.cover,
          ),
        ),
        // Container(
        //   // padding: EdgeInsets.symmetric(
        //   //   horizontal: Dimensions.PADDING_SIZE_SMALL,
        //   //   vertical: Dimensions.PADDING_SIZE_SMALL,
        //   // ),
        //   child: Stack(
        //     children: [
        //
        //       // if (discountAmount != null && discountAmountType != null && discountAmount! > 0)
        //       //   Positioned.fill(
        //       //     child: Align(
        //       //       alignment: Alignment.topRight,
        //       //       child: Container(
        //       //         padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        //       //         decoration: BoxDecoration(
        //       //           color: Theme.of(context).errorColor,
        //       //           borderRadius: BorderRadius.only(
        //       //             bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT),
        //       //             topRight: Radius.circular(Dimensions.RADIUS_SMALL),
        //       //           ),
        //       //         ),
        //       //         child: Text(
        //       //           PriceConverter.percentageOrAmount('$discountAmount', discountAmountType!),
        //       //           style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
        //       //         ),
        //       //       ),
        //       //     ),
        //       //   ),
        //     ],
        //   ),
        // ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Container(
            // padding: EdgeInsets.symmetric(
            //     horizontal: Dimensions.PADDING_SIZE_SMALL,
            //     vertical: Dimensions.PADDING_SIZE_MINI),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  serviceList[index].name,
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                //SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                RatingBar(
                  rating: double.parse(serviceList[index].avgRating.toString()),
                  size: 15,
                  ratingCount: serviceList[index].ratingCount,
                ),
                SizedBox(height: 2),

                // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text(
                  serviceList[index].description,
                  style: ubuntuLight.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonSubmitButton(
                      text: 'Book Now'.tr,
                      fontSize: Dimensions.fontSizeSmall,
                      onTap: () {
                        Get.toNamed(
                          RouteHelper.getServiceRoute(serviceList[index].id),
                          arguments: ServiceDetailsScreen(serviceID: serviceList[index].id),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
