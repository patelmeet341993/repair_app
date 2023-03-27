import 'package:repair/components/footer_base_view.dart';
import 'package:repair/components/menu_drawer.dart';
import 'package:repair/core/helper/decorated_tab_bar.dart';

import 'package:repair/feature/company/controller/company_details_controller.dart';
import 'package:repair/feature/company/controller/company_details_tab_controller.dart';
import 'package:repair/feature/company/model/company_model.dart' as companyModel;
import 'package:repair/feature/company/widget/company_overview.dart';
import 'package:repair/feature/service/widget/service_details_faq_section.dart';
import 'package:get/get.dart';

import '../../../core/core_export.dart';

// import '../controller/company_details_controller.dart' as company_details_controller;
// import '../controller/company_details_tab_controller.dart' as company_details_tab_Controller;

class CompanyDetailsScreen extends StatelessWidget {
  final company_image;
  final company_name;
  final company_rating;
  companyModel.CompanyData? companyData;

  CompanyDetailsScreen({Key? key, required this.company_image, required this.company_name, required this.company_rating, this.companyData}) : super(key: key);

  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();

  late List<companyModel.CompanyDetailsModel> itemList1 = [];


  String getImageBaseUrl() {
    String imageUrl = "";
    imageUrl = ((Get.find<SplashController>().configModel.content?? Content()).imageBaseUrl ?? "");
    if (imageUrl.isNotEmpty) {
      imageUrl += "/provider/logo/";
    }
    return imageUrl;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      endDrawer: ResponsiveHelper.isDesktop(context) ? MenuDrawer() : null,
      appBar: CustomAppBar(
        centerTitle: false,
        title: 'Company Details'.tr,
        showCart: true,
      ),
      // body: GetBuilder<company_details_controller.CompanyDetailsController>(builder: (serviceController) {
      body: GetBuilder<CompanyDetailsController>(builder: (serviceController) {
        if (serviceController.service != null) {
          if (serviceController.service!.id != null) {
            Service? service = serviceController.service;
            Discount _discount = PriceConverter.discountCalculation(service!);
            double _lowestPrice = 0.0;
            if (service.variationsAppFormat!.zoneWiseVariations != null) {
              _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![0].price!.toDouble();
              for (var i = 0; i < service.variationsAppFormat!.zoneWiseVariations!.length; i++) {
                if (service.variationsAppFormat!.zoneWiseVariations![i].price! < _lowestPrice) {
                  _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![i].price!.toDouble();
                }
              }
            }
            return FooterBaseView(
              isScrollView: ResponsiveHelper.isMobile(context) ? false : true,
              child: SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                child: DefaultTabController(
                  // length: Get.find<company_details_tab_Controller.CompanyTabController>().faqs!.length > 0 ? 3 : 2,
                  length: Get.find<CompanyDetailsController>().service!.faqs!.length > 0 ? 3 : 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                          image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.coverImage}',
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
                                    Container(
                                      width: Dimensions.WEB_MAX_WIDTH,
                                      height: ResponsiveHelper.isDesktop(context) ? 280 : 150,
                                      child: Center(
                                          child: Text(service.name ?? '',
                                              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white))),
                                    ),
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
                              child: getTopHeaderCard(context)),
                        ],
                      ),
                      GetBuilder<CompanyTabController>(
                        init: Get.find<CompanyTabController>(),
                        builder: (serviceTabController) {
                          return Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Center(
                              child: Container(
                                width: ResponsiveHelper.isMobile(context) ? null : Get.width / 3,
                                color: Get.isDarkMode ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).cardColor,
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
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
                                      controller: serviceTabController.controller!,
                                      labelColor: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                                      labelStyle: ubuntuBold.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                      ),
                                      indicatorColor: Theme.of(context).colorScheme.primary,
                                      indicatorPadding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                                      labelPadding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      indicatorWeight: 2,
                                      onTap: (int? index) {
                                        switch (index) {
                                          case 0:
                                            serviceTabController
                                                .updateServicePageCurrentState(CompanyTabControllerState.serviceOverview);
                                            break;
                                          case 1:
                                            serviceTabController.serviceDetailsTabs().length > 2
                                                ? serviceTabController
                                                    .updateServicePageCurrentState(CompanyTabControllerState.faq)
                                                : serviceTabController
                                                    .updateServicePageCurrentState(CompanyTabControllerState.review);
                                            break;
                                          case 2:
                                            serviceTabController.updateServicePageCurrentState(CompanyTabControllerState.review);
                                            break;
                                        }
                                      },
                                      tabs: serviceTabController.serviceDetailsTabs()),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      //Tab Bar View
                      GetBuilder<CompanyTabController>(
                        initState: (state) {
                          Get.find<CompanyTabController>().getServiceReview(serviceController.service!.id!, 1);
                        },
                        builder: (controller) {
                          Widget tabBarView = TabBarView(
                            controller: controller.controller,
                            children: [
                              SingleChildScrollView(child: CompanyOverview(description: service.description!, companyData: companyData,)),
                              if (Get.find<CompanyDetailsController>().service!.faqs!.length > 0)
                                SingleChildScrollView(child: ServiceDetailsFaqSection()),
                              if (controller.reviewList != null)
                                SingleChildScrollView(
                                  child: ServiceDetailsReview(
                                    serviceID: serviceController.service!.id!,
                                    reviewList: controller.reviewList!,
                                    rating: controller.rating,
                                  ),
                                )
                              else
                                EmptyReviewWidget()
                            ],
                          );

                          if (ResponsiveHelper.isMobile(context)) {
                            return Expanded(
                              child: tabBarView,
                            );
                          } else {
                            return Container(
                              height: 500,
                              child: tabBarView,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return NoDataScreen(
              text: 'no_service_available'.tr,
              type: NoDataType.SERVICE,
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
  Widget getTopHeaderCard(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                      child: Container(
                        height: Dimensions.PAGES_BOTTOM_PADDING,
                        width: Dimensions.PAGES_BOTTOM_PADDING,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.grey),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: "${getImageBaseUrl()}${companyData?.logo ?? " "}",
                            errorWidget: (BuildContext context, img, _) {
                              return Image.asset(
                                Images.placeholder,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        )
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                            child: Text(
                              "${companyData?.companyName}",
                              style: ubuntuRegular.copyWith(
                                  fontSize: MediaQuery.of(context).size.width < 300
                                      ? Dimensions.fontSizeExtraSmall
                                      : Dimensions.fontSizeSmall,
                                  fontWeight: FontWeight.bold),
                              maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: 240,
                            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                            child: Row(
                              children: [
                                Text(
                                  "Language",
                                  style: ubuntuRegular.copyWith(
                                      fontSize: MediaQuery.of(context).size.width < 300
                                          ? Dimensions.fontSizeExtraSmall
                                          : Dimensions.fontSizeSmall,
                                      fontWeight: FontWeight.bold),
                                  maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  ": Arabic, English",
                                  style: ubuntuRegular.copyWith(
                                      fontSize: MediaQuery.of(context).size.width < 300
                                          ? Dimensions.fontSizeExtraSmall
                                          : Dimensions.fontSizeSmall,
                                      fontWeight: FontWeight.w500),
                                  maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                              child: Row(
                                children: [
                                  Text(
                                    "Address  ",
                                    style: ubuntuRegular.copyWith(
                                        fontSize: MediaQuery.of(context).size.width < 300
                                            ? Dimensions.fontSizeExtraSmall
                                            : Dimensions.fontSizeSmall,
                                        fontWeight: FontWeight.bold),
                                    maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ": ${companyData?.companyAddress}",

                                      style: ubuntuRegular.copyWith(
                                          fontSize: MediaQuery.of(context).size.width < 300
                                              ? Dimensions.fontSizeExtraSmall
                                              : Dimensions.fontSizeSmall,
                                          fontWeight: FontWeight.w500),
                                      // maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              )),
                          Container(
                              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                              child: Row(
                                children: [
                                  Text(
                                    "Availability",
                                    style: ubuntuRegular.copyWith(
                                        fontSize: MediaQuery.of(context).size.width < 300
                                            ? Dimensions.fontSizeExtraSmall
                                            : Dimensions.fontSizeSmall,
                                        fontWeight: FontWeight.bold),
                                    maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    ": 1:31:15 PM - 1:31:15 PM",
                                    style: ubuntuRegular.copyWith(
                                        fontSize: MediaQuery.of(context).size.width < 300
                                            ? Dimensions.fontSizeExtraSmall
                                            : Dimensions.fontSizeSmall,
                                        fontWeight: FontWeight.w500),
                                    maxLines: MediaQuery.of(context).size.width < 300 ? 1 : 3,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              )),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                                child: Text(
                                  " ${companyData?.avgRating}",
                                  style: ubuntuRegular.copyWith(
                                      fontSize: MediaQuery.of(context).size.width < 300
                                          ? Dimensions.fontSizeExtraSmall
                                          : Dimensions.fontSizeSmall,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                                child: Text(
                                  "(${companyData?.ratingCount})",
                                  style: ubuntuRegular.copyWith(
                                    fontSize: MediaQuery.of(context).size.width < 300
                                        ? Dimensions.fontSizeExtraSmall
                                        : Dimensions.fontSizeSmall,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // Positioned(
            //     bottom: 1.0,
            //     right: 2.0,
            //     child: SizedBox(
            //       height: 25,
            //       width: 90,
            //       child: ElevatedButton(
            //         onPressed: () {
            //           //setState(() => _isSelected = !_isSelected);
            //         },
            //         child: Text("Select"),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Theme.of(context).colorScheme.primary, // This is what you need!
            //         ),
            //       ),
            //     ))
          ],
        ),
      ),
    );
  }
}
