import 'package:repair/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:repair/components/footer_base_view.dart';
import 'package:repair/components/web_shadow_wrap.dart';
import 'package:repair/core/core_export.dart';

import '../controller/product_booking_details_tabs_controller.dart';

class ProductBookingDetailsScreen extends StatefulWidget {
  final String bookingID;
  final String fromPage;

  const ProductBookingDetailsScreen({Key? key, required this.bookingID, required this.fromPage}) : super(key: key);

  @override
  State<ProductBookingDetailsScreen> createState() => _ProductBookingDetailsScreenState();
}

class _ProductBookingDetailsScreenState extends State<ProductBookingDetailsScreen> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    Get.find<ProductBookingDetailsTabsController>().getBookingDetails(bookingId: widget.bookingID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.fromPage == 'fromNotification') {
          Get.offAllNamed(RouteHelper.getInitialRoute());
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          key: scaffoldState,
          endDrawer: ResponsiveHelper.isDesktop(context) ? MenuDrawer() : null,
          appBar: CustomAppBar(
            title: "booking_details".tr,
            centerTitle: true,
            isBackButtonExist: true,
            onBackPressed: () {
              if (widget.fromPage == 'fromNotification') {
                Get.offAllNamed(RouteHelper.getInitialRoute());
              } else {
                Get.back();
              }
            },
          ),
          body: FooterBaseView(
            isCenter: false,
            isScrollView: ResponsiveHelper.isMobile(context) ? false : true,
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: RefreshIndicator(
                onRefresh: () async {
                  Get.find<ProductBookingDetailsTabsController>().getBookingDetails(bookingId: widget.bookingID);
                },
                child: WebShadowWrap(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        BookingTabBar(),
                        if (!ResponsiveHelper.isMobile(context))
                          GetBuilder<ProductBookingDetailsTabsController>(initState: (state) {
                            Get.find<ProductBookingDetailsTabsController>().getBookingDetails(bookingId: widget.bookingID);
                          }, builder: (bookingDetailsTabController) {
                            return Container(
                              height: 600,
                              child: TabBarView(controller: Get.find<ProductBookingDetailsTabsController>().detailsTabController, children: [
                                BookingDetailsSection(bookingID: widget.bookingID),
                                BookingHistory(bookingDetailsContent: Get.find<ProductBookingDetailsTabsController>().productBookingDetailsContent),
                              ]),
                            );
                          }),
                        if (ResponsiveHelper.isMobile(context))
                          GetBuilder<ProductBookingDetailsTabsController>(initState: (state) {
                            Get.find<ProductBookingDetailsTabsController>().getBookingDetails(bookingId: widget.bookingID);
                          }, builder: (bookingDetailsTabController) {
                            return Expanded(
                              child: TabBarView(controller: Get.find<ProductBookingDetailsTabsController>().detailsTabController, children: [
                                ProductBookingDetailsSection(bookingID: widget.bookingID),
                                ProductBookingHistory(bookingDetailsContent: Get.find<ProductBookingDetailsTabsController>().productBookingDetailsContent),
                              ]),
                            );
                          }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // floatingActionButton: new FloatingActionButton(
          //     hoverColor: Colors.transparent,
          //     elevation: 0.0,
          //     child: new Icon(Icons.message_rounded, color: Theme.of(context).primaryColorLight),
          //     backgroundColor: Theme.of(context).colorScheme.primary,
          //     onPressed: () {
          //       BookingDetailsContent bookingDetailsContent = Get.find<ProductBookingDetailsTabsController>().productBookingDetailsContent!;
          //
          //       if (bookingDetailsContent.provider != null || bookingDetailsContent.provider != null) {
          //         showModalBottomSheet(
          //             useRootNavigator: true,
          //             isScrollControlled: true,
          //             backgroundColor: Colors.transparent,
          //             context: context,
          //             builder: (context) => CreateChannelDialog(
          //                   customerID: bookingDetailsContent.customerId,
          //                   providerId: bookingDetailsContent.provider != null ? bookingDetailsContent.provider!.userId! : null,
          //                   serviceManId: bookingDetailsContent.serviceman != null ? bookingDetailsContent.serviceman!.userId! : null,
          //                   referenceId: bookingDetailsContent.readableId.toString(),
          //                 ));
          //       } else {
          //         customSnackBar('provider_or_service_man_assigned'.tr);
          //       }
          //     }),
      ),
    );
  }
}

class BookingTabBar extends StatelessWidget {
  const BookingTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductBookingDetailsTabsController>(
      builder: (bookingDetailsTabsController) {
        return Container(
          height: 45,
          width: Dimensions.WEB_MAX_WIDTH,
          color: Theme.of(context).cardColor,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0),
              border: Border(
                bottom: BorderSide(color: Theme.of(context).primaryColor, width: 0.5),
              ),
            ),
            child: Center(
              child: TabBar(
                unselectedLabelColor: Colors.grey,
                labelColor: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                controller: bookingDetailsTabsController.detailsTabController,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    child: Text('booking_details'.tr),
                  ),
                  Tab(
                    child: Text('status'.tr),
                  ),
                ],
                onTap: (int? index) {
                  switch (index) {
                    case 0:
                      bookingDetailsTabsController.updateBookingStatusTabs(ProductBookingDetailsTabs.BookingDetails);
                      break;
                    case 1:
                      bookingDetailsTabsController.updateBookingStatusTabs(ProductBookingDetailsTabs.Status);
                      break;
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
