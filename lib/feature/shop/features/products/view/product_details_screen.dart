import 'package:flutter_html/flutter_html.dart';
import 'package:repair/components/footer_base_view.dart';
import 'package:repair/components/menu_drawer.dart';
import 'package:repair/feature/service/widget/service_details_faq_section.dart';
import 'package:repair/feature/service/widget/service_info_card.dart';
import 'package:repair/feature/service/widget/service_overview.dart';
import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/core/helper/decorated_tab_bar.dart';
import 'package:repair/feature/shop/features/product_coupon/model/product_coupon_model.dart';
import 'package:repair/feature/shop/features/products/controller/product_details_controller.dart';
import 'package:repair/feature/shop/features/products/controller/product_details_tab_controller.dart';

import '../components/product_media_widget.dart';
import '../model/product_model.dart';
import '../widget/product_details_review.dart';
import '../widget/product_info_card.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productID;

  const ProductDetailsScreen({Key? key, required this.productID}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<ProductTabController>().pageSize ?? 0;
        if (Get.find<ProductTabController>().offset! < pageSize) {
          Get.find<ProductTabController>().getProductReview(widget.productID, Get.find<ProductTabController>().offset! + 1);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      endDrawer: ResponsiveHelper.isDesktop(context) ? MenuDrawer() : null,
      appBar: CustomAppBar(
        centerTitle: false,
        title: 'product_details'.tr,
        showCart: true,
        isFromProduct: true,
      ),
      body: GetBuilder<ProductDetailsController>(initState: (state) {
        Get.find<ProductDetailsController>().getProductDetails(widget.productID);
      }, builder: (serviceController) {
        if (serviceController.product != null) {
          if (serviceController.product!.id.isNotEmpty) {
            Product? service = serviceController.product;
            CouponProductDiscount _discount = PriceConverter.productDiscountCalculation(service!);
            double _lowestPrice = 0.0;
            // if (service.variationsAppFormat!.zoneWiseVariations != null) {
            //   _lowestPrice = service
            //       .variationsAppFormat!.zoneWiseVariations![0].price!
            //       .toDouble();
            //   for (var i = 0;
            //       i < service.variationsAppFormat!.zoneWiseVariations!.length;
            //       i++) {
            //     if (service.variationsAppFormat!.zoneWiseVariations![i].price! <
            //         _lowestPrice) {
            //       _lowestPrice = service
            //           .variationsAppFormat!.zoneWiseVariations![i].price!
            //           .toDouble();
            //     }
            //   }
            // }
            return FooterBaseView(
              isScrollView: ResponsiveHelper.isMobile(context) ? false : true,
              child: SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                child: DefaultTabController(
                  // length: Get.find<ProductDetailsController>().product!.faqs!.length > 0 ? 3 : 2,
                  length: 3,
                  child: Column(
                    children: [
                      if (!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context))
                        SizedBox(
                          height: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                      Stack(
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(
                                    (!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context)) ? Radius.circular(8) : Radius.circular(0.0)),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: Dimensions.WEB_MAX_WIDTH,
                                        height: ResponsiveHelper.isDesktop(context) ? 280 : 150,
                                        child: CustomImage(
                                          image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/product/${service.image}',
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        width: Dimensions.WEB_MAX_WIDTH,
                                        height: ResponsiveHelper.isDesktop(context) ? 280 : 150,
                                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.6)),
                                      ),
                                    ),
                                    // Container(
                                    //   width: Dimensions.WEB_MAX_WIDTH,
                                    //   height: ResponsiveHelper.isDesktop(context) ? 280 : 150,
                                    //   child: Center(
                                    //       child: Text(service.name ?? '',
                                    //           style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white))),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 120,
                              )
                            ],
                          ),
                          Positioned(
                              bottom: -2,
                              left: Dimensions.PADDING_SIZE_SMALL,
                              right: Dimensions.PADDING_SIZE_SMALL,
                              child: ProductInformationCard(discount: _discount, product: service, lowestPrice: _lowestPrice)),
                        ],
                      ),
                      //Tab Bar
                      GetBuilder<ProductTabController>(
                        init: Get.find<ProductTabController>(),
                        builder: (productTabController) {
                          return Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Center(
                              child: Container(
                                width: ResponsiveHelper.isMobile(context) ? null : Get.width / 3,
                                color: Get.isDarkMode ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).cardColor,
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                // child: Container(),
                                child: DecoratedTabBar(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).colorScheme.primary.withOpacity(.3),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  tabBar: TabBar(
                                    padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_MINI),
                                    unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.4),
                                    // controller: serviceTabController.controller!,
                                    labelColor: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                                    labelStyle: ubuntuBold.copyWith(
                                      fontSize: Dimensions.fontSizeDefault,
                                    ),
                                    indicatorColor: Theme.of(context).colorScheme.primary,
                                    indicatorPadding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                                    labelPadding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    indicatorWeight: 2,
                                    onTap: (int? index) {
                                      // switch (index) {
                                      //   case 0:
                                      //     serviceTabController.updateServicePageCurrentState(ProductTabControllerState.serviceOverview);
                                      //     break;
                                      //   case 1:
                                      //     serviceTabController.serviceDetailsTabs().length > 2
                                      //         ? serviceTabController.updateServicePageCurrentState(ProductTabControllerState.faq)
                                      //         : serviceTabController.updateServicePageCurrentState(ProductTabControllerState.review);
                                      //     break;
                                      //   case 2:
                                      //     serviceTabController.updateServicePageCurrentState(ProductTabControllerState.review);
                                      //     break;
                                      // }
                                    },
                                    tabs: [
                                      Container(
                                        child: Center(
                                          child: Text("overView".tr),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text("features".tr),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text("media".tr),
                                        ),
                                      ),
                                      // Container(
                                      //   child: Center(
                                      //     child: Text("review".tr),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Container(
                              child: overViewTab(service),
                            ),
                            Container(child: SingleChildScrollView(child: featuresTab(service.features ?? [], service.specifications ?? []))),
                            Container(
                              child: SingleChildScrollView(
                                child: ProductMediaWidget(
                                  product: service,
                                ),
                              ),
                            ),
                            // Container(
                            //   child:ProductDetailsReview(rating: , reviewList: [], serviceID: '',),
                            // )
                            // GetBuilder<ServiceTabController>(
                            //   initState: (state) {
                            //     Get.find<ServiceTabController>().getServiceReview(serviceController.product!.id!, 1);
                            //   },
                            //   builder: (controller) {
                            //     Widget tabBarView = TabBarView(
                            //       controller: controller.controller,
                            //       children: [
                            //         SingleChildScrollView(child: ServiceOverview(description: service.description!)),
                            //         if (Get.find<ServiceDetailsController>().service!.faqs!.length > 0) SingleChildScrollView(child: ServiceDetailsFaqSection()),
                            //         if (controller.reviewList != null)
                            //           SingleChildScrollView(
                            //             child: ServiceDetailsReview(
                            //               serviceID: serviceController.product!.id!,
                            //               reviewList: controller.reviewList!,
                            //               rating: controller.rating,
                            //             ),
                            //           )
                            //         else
                            //           EmptyReviewWidget()
                            //       ],
                            //     );
                            //
                            //     if (ResponsiveHelper.isMobile(context)) {
                            //       return Expanded(
                            //         child: tabBarView,
                            //       );
                            //     } else {
                            //       return Container(
                            //         height: 500,
                            //         child: tabBarView,
                            //       );
                            //     }
                            //   },
                            // ),
                          ],
                        ),
                      ),
                      //Tab Bar View
                    ],
                  ),
                ),
              ),
            );
          } else {
            return NoDataScreen(
              text: 'no_product_available'.tr,
              type: NoDataType.SERVICE,
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  Widget overViewTab(Product product) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description:",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Html(data: product.description)
            ],
          ),
        ),
      ),
    );
  }

  //region featuresTab
  Widget featuresTab(List<Features> feature, List<Specifications> specifications) {
    if (feature.isEmpty) {
      return Center(
        child: Text("no_features_available".tr),
      );
    }
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "key_features".tr,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          featureListView(feature),
          specificationWidget(specifications)
        ],
      ),
    );
  }

  Widget featureListView(List<Features> feature) {
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          shrinkWrap: true,
          itemCount: feature.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 8,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("${feature[index].featuresName}"),
                ],
              ),
            );
          }),
    );
  }

  Widget specificationWidget(List<Specifications> specification) {
    if (specification.isEmpty) {
      return SizedBox();
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "specification".tr,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          SizedBox(
            height: 15,
          ),
          specificationListView(specification)
        ],
      ),
    );
  }

  Widget specificationListView(List<Specifications> specification) {
    return Container(
      child: Column(
        children: [
          getHeaderSpecification(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: specification.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.grey),
                      left: BorderSide(color: Colors.grey),
                      right: BorderSide(color: Colors.grey),
                      bottom: specification.last.id == specification[index].id ? BorderSide(color: Colors.grey) : BorderSide(color: Colors.transparent)),
                ),
                // padding: EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            width: 80,
                            child: Text("${specification[index].specificationType}"),
                          ),
                          VerticalDivider(
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("${specification[index].specificationName}"),
                    )),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget getHeaderSpecification() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),

      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey),
          left: BorderSide(color: Colors.grey),
          right: BorderSide(color: Colors.grey),
          // bottom: specification.last.id == specification[index].id ? BorderSide(color: Colors.grey):BorderSide(color: Colors.transparent)
        ),
      ),
      // padding: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  width: 80,
                  child: Text(
                    "Type",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                VerticalDivider(
                  color: Colors.black,
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
//endregion
}
