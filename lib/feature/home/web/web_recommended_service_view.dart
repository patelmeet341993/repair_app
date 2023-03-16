import 'package:repair/feature/home/web/web_campaign_view.dart';
import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';

class WebRecommendedServiceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
      initState: (state) {
        Get.find<ServiceController>().getRecommendedServiceList(1, false);
      },
      builder: (serviceController) {
        if (serviceController.recommendedServiceList != null &&
            serviceController.recommendedServiceList!.length == 0) {
          return SizedBox();
        } else {
          if (serviceController.recommendedServiceList != null) {
            List<Service>? _recommendedServiceList =
                serviceController.recommendedServiceList;
            return Container(
              width: Dimensions.WEB_MAX_WIDTH / 3.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: Text('recommended_for_you'.tr,
                        style: ubuntuMedium.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge)),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _recommendedServiceList!.length > 2
                        ? 3
                        : _recommendedServiceList.length,
                    itemBuilder: (context, index) {
                      Discount _discount = PriceConverter.discountCalculation(
                          serviceController.recommendedServiceList![index]);

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: InkWell(
                          onTap: () => Get.toNamed(RouteHelper.getServiceRoute(
                              _recommendedServiceList[index].id!)),
                          child: ServiceModelView(
                            serviceList:
                                serviceController.recommendedServiceList!,
                            discountAmountType: _discount.discountAmountType,
                            discountAmount: _discount.discountAmount,
                            index: index,
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_LARGE,
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    child: CustomButton(
                      buttonText: 'see_all'.tr,
                      onPressed: () => Get.toNamed(
                          RouteHelper.allServiceScreenRoute(
                              "fromRecommendedScreen")),
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

class ServiceModelView extends StatelessWidget {
  final List<Service> serviceList;
  final int index;
  final num? discountAmount;
  final String? discountAmountType;

  const ServiceModelView({
    Key? key,
    required this.serviceList,
    required this.index,
    required this.discountAmount,
    required this.discountAmountType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _lowestPrice = 0.0;
    if (serviceList[index].variationsAppFormat!.zoneWiseVariations != null) {
      _lowestPrice = serviceList[index]
          .variationsAppFormat!
          .zoneWiseVariations![0]
          .price!
          .toDouble();
      for (var i = 0;
          i <
              serviceList[index]
                  .variationsAppFormat!
                  .zoneWiseVariations!
                  .length;
          i++) {
        if (serviceList[index]
                .variationsAppFormat!
                .zoneWiseVariations![i]
                .price! <
            _lowestPrice) {
          _lowestPrice = serviceList[index]
              .variationsAppFormat!
              .zoneWiseVariations![i]
              .price!
              .toDouble();
        }
      }
    }
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_RADIUS),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        boxShadow: Get.isDarkMode ? null : cardShadow,
      ),
      child: Row(children: [
        Container(
          // padding: EdgeInsets.symmetric(
          //   horizontal: Dimensions.PADDING_SIZE_SMALL,
          //   vertical: Dimensions.PADDING_SIZE_SMALL,
          // ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                child: CustomImage(
                  image:
                      '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${serviceList[index].thumbnail}',
                  height: 111,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
              if (discountAmount != null &&
                  discountAmountType != null &&
                  discountAmount! > 0)
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding:
                          EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      decoration: BoxDecoration(
                        color: Theme.of(context).errorColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular(Dimensions.RADIUS_DEFAULT),
                          topRight: Radius.circular(Dimensions.RADIUS_SMALL),
                        ),
                      ),
                      child: Text(
                        PriceConverter.percentageOrAmount(
                            '$discountAmount', discountAmountType!),

                        style: ubuntuMedium.copyWith(
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: 15,),
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
                    serviceList[index].name!,
                    style: ubuntuMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height:2),
                  //SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  RatingBar(
                    rating:
                        double.parse(serviceList[index].avgRating.toString()),
                    size: 15,
                    ratingCount: serviceList[index].ratingCount,
                  ),
                  SizedBox(height:2),

                 // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Text(
                    serviceList[index].shortDescription!,
                    style: ubuntuLight.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Theme.of(context).disabledColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height:2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonSubmitButton(
                        text: 'Book Now'.tr,
                        fontSize: Dimensions.fontSizeSmall,
                        onTap:  (){
                          Get.toNamed(
                            RouteHelper.getServiceRoute(
                                serviceList![index].id!),
                            arguments: ServiceDetailsScreen(
                                serviceID: serviceList![index].id!),
                          );
                        }

                      ),
                      // SizedBox(
                      //  // height: 30.0,
                      //   width: 100.0,
                      //   child: CustomButtonSmall(
                      //     buttonText: 'Book Now'.tr,
                      //     onPressed: () {
                      //       Get.toNamed(
                      //         RouteHelper.getServiceRoute(
                      //             serviceList![index].id!),
                      //         arguments: ServiceDetailsScreen(
                      //             serviceID: serviceList![index].id!),
                      //       );
                      //     },
                      //   ),
                      // )
                    ],
                  ),
                ]),
          ),
        ),
      ]),
    );
  }
}
