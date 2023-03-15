import 'package:get/get.dart';
import 'package:repair/components/ripple_button.dart';
import 'package:repair/components/service_center_dialog.dart';
import 'package:repair/core/core_export.dart';

class PopularServiceView extends GetView<ServiceController> {
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    return GetBuilder<ServiceController>(
      builder: (serviceController) {
        if (serviceController.popularServiceList != null &&
            serviceController.popularServiceList!.length == 0) {
          return SizedBox();
        } else {
          if (serviceController.popularServiceList != null) {
            return Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Dimensions.PADDING_SIZE_DEFAULT,
                      15,
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: TitleWidget(
                      title: 'popular_services'.tr,
                      onTap: () => Get.toNamed(
                          RouteHelper.allServiceScreenRoute(
                              "fromPopularServiceView")),
                    ),
                  ),
                  SizedBox(
                    height: Get.find<LocalizationController>().isLtr
                        ? ResponsiveHelper.isMobile(context)
                            ? 250
                            : 260
                        : 260,
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                          bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      itemCount:
                          serviceController.popularServiceList!.length > 10
                              ? 10
                              : serviceController.popularServiceList!.length,
                      itemBuilder: (context, index) {
                        controller.getServiceDiscount(
                            serviceController.popularServiceList![index]);
                        Discount _discountModel =
                            PriceConverter.discountCalculation(
                                serviceController.popularServiceList![index]);
                        Service service = serviceController.popularServiceList!
                            .elementAt(index);
                        double _lowestPrice = 0.0;
                        if (service.variationsAppFormat!.zoneWiseVariations !=
                            null) {
                          _lowestPrice = service.variationsAppFormat!
                              .zoneWiseVariations![0].price!
                              .toDouble();
                          for (var i = 0;
                              i <
                                  service.variationsAppFormat!
                                      .zoneWiseVariations!.length;
                              i++) {
                            if (service.variationsAppFormat!
                                    .zoneWiseVariations![i].price! <
                                _lowestPrice) {
                              _lowestPrice = service.variationsAppFormat!
                                  .zoneWiseVariations![i].price!
                                  .toDouble();
                            }
                          }
                        }
                        return Padding(
                          padding: EdgeInsets.only(
                              right: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Stack(
                            alignment: Get.find<LocalizationController>().isLtr
                                ? Alignment.bottomRight
                                : Alignment.bottomLeft,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: Get.width / 2.3,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.RADIUS_SMALL),
                                        boxShadow:
                                            Get.isDarkMode ? null : cardShadow),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_SMALL),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //image and service name
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              Dimensions
                                                                  .RADIUS_SMALL)),
                                                      child: CustomImage(
                                                        image:
                                                            '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.thumbnail}',
                                                        fit: BoxFit.cover,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                        height: 135,
                                                      ),
                                                    ),
                                                    _discountModel
                                                                .discountAmount! >
                                                            0
                                                        ? Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .all(Dimensions
                                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .errorColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          Dimensions
                                                                              .RADIUS_DEFAULT),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          Dimensions
                                                                              .RADIUS_SMALL),
                                                                ),
                                                              ),
                                                              child:
                                                                  Directionality(
                                                                textDirection:
                                                                    TextDirection
                                                                        .rtl,
                                                                child: Text(
                                                                  PriceConverter
                                                                      .percentageOrAmount(
                                                                          '${_discountModel.discountAmount}',
                                                                          '${_discountModel.discountAmountType}'),
                                                                  style: ubuntuRegular
                                                                      .copyWith(
                                                                          color:
                                                                              Colors.white),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      Dimensions
                                                          .PADDING_SIZE_RADIUS),
                                                  child: Text(service.name!,
                                                      style: ubuntuMedium.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeDefault),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      Dimensions
                                                          .PADDING_SIZE_MINI),
                                                  child: Text(
                                                    service.shortDescription!,
                                                    style: ubuntuLight.copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeExtraSmall,
                                                        color: Theme.of(context)
                                                            .disabledColor),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: RippleButton(
                                      onTap: () => Get.toNamed(
                                        RouteHelper.getServiceRoute(
                                            service.id!),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 4.0,
                                right: 4.0,
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment:
                                            AlignmentDirectional.bottomEnd,
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
                                        onPressed: () => showModalBottomSheet(
                                            context: context,
                                            useRootNavigator: true,
                                            isScrollControlled: true,
                                            builder: (context) =>
                                                ServiceCenterDialog(
                                                  service: service,
                                                ),
                                            backgroundColor:
                                                Colors.transparent),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  )
                ],
              ),
            );
          } else {
            return PopularServiceShimmer(
              enabled: true,
            );
          }
        }
      },
    );
  }
}

class PopularServiceShimmer extends StatelessWidget {
  final bool enabled;
  PopularServiceShimmer({required this.enabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(
          right: Dimensions.PADDING_SIZE_SMALL,
          left: Dimensions.PADDING_SIZE_SMALL,
          top: Dimensions.PADDING_SIZE_SMALL,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: 80,
            width: 200,
            margin: EdgeInsets.only(
              right: Dimensions.PADDING_SIZE_SMALL,
            ),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              color: Colors
                  .grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              boxShadow: cardShadow,
            ),
            child: Shimmer(
              duration: Duration(seconds: 1),
              interval: Duration(seconds: 1),
              enabled: enabled,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 70,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          color: Colors.grey[
                              Get.find<ThemeController>().darkTheme
                                  ? 600
                                  : 300]),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 15,
                                  width: 100,
                                  color: Colors.grey[
                                      Get.find<ThemeController>().darkTheme
                                          ? 600
                                          : 300]),
                              SizedBox(height: 5),
                              Container(
                                  height: 10,
                                  width: 130,
                                  color: Colors.grey[
                                      Get.find<ThemeController>().darkTheme
                                          ? 600
                                          : 300]),
                              SizedBox(height: 5),
                              Container(
                                  height: 10,
                                  width: 130,
                                  color: Colors.grey[
                                      Get.find<ThemeController>().darkTheme
                                          ? 600
                                          : 300]),
                            ]),
                      ),
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
