import 'package:repair/components/menu_drawer.dart';
import 'package:repair/components/paginated_list_view.dart';
import 'package:get/get.dart';
import 'package:repair/components/footer_base_view.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/core/helper/decorated_tab_bar.dart';
import 'package:repair/feature/service_booking/model/product_booking_model.dart';
import 'package:repair/feature/service_booking/widget/booking_item_card.dart';
import 'package:repair/feature/service_booking/widget/booking_screen_shimmer.dart';
import 'package:repair/feature/service_booking/widget/booking_status_tabs.dart';

class BookingScreen extends StatefulWidget {
  final bool isFromMenu;

  const BookingScreen({Key? key, this.isFromMenu = false}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    Get.find<ServiceBookingController>().getAllBookingService(offset: 1, bookingStatus: "all", isFromPagination: false);
    Get.find<ServiceBookingController>().updateBookingStatusTabs(BookingStatusTabs.all, firstTimeCall: false);
    Get.find<ServiceBookingController>().getAllBookingProduct(offset: 1, bookingStatus: "all", isFromPagination: false);
    Get.find<ServiceBookingController>().updateProductBookingStatusTabs(ProductBookingStatusTabs.all, firstTimeCall: false);
    super.initState();
  }

  ScrollController bookingScreenScrollController = ScrollController();
  ScrollController productbookingScreenScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    bookingScreenScrollController = ScrollController();

    return Scaffold(
      endDrawer: ResponsiveHelper.isDesktop(context) ? MenuDrawer() : null,
      appBar: CustomAppBar(isBackButtonExist: widget.isFromMenu ? true : false, onBackPressed: () => Get.back(), title: "my_orders".tr),
      body: GetBuilder<ServiceBookingController>(
        builder: (serviceBookingController) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: DecoratedTabBar(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.primary.withOpacity(.3),
                      width: 1.0,
                    ),
                  ),
                ),
                tabBar: TabBar(
                  // padding: EdgeInsets.symmetric(vertical: 10),
                  labelPadding: EdgeInsets.symmetric(vertical: 10),
                  // indicatorPadding: EdgeInsets.symmetric(vertical: 5),
                  indicatorColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: [Text("service_bookings".tr), Text("product_orders".tr)],
                ),
              ),
              body: TabBarView(
                children: [getServiceBookingTab(serviceBookingController), getProductBookingTab(serviceBookingController)],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getServiceBookingTab(ServiceBookingController serviceBookingController) {
    List<BookingModel>? _bookingList = serviceBookingController.bookingList;
    return _buildBody(
      sliversItems: serviceBookingController.bookingList != null
          ? [
              if (ResponsiveHelper.isDesktop(context))
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                ),
              SliverPersistentHeader(
                delegate: ServiceRequestSectionMenu(),
                pinned: true,
                floating: false,
              ),
              if (ResponsiveHelper.isDesktop(context))
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                ),
              if (ResponsiveHelper.isMobile(context))
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                ),
              if (_bookingList!.length > 0)
                SliverToBoxAdapter(
                    child: PaginatedListView(
                  scrollController: bookingScreenScrollController,
                  totalSize: serviceBookingController.bookingContent!.total!,
                  onPaginate: (int offset) async => await serviceBookingController.getAllBookingService(
                      offset: offset, bookingStatus: serviceBookingController.selectedBookingStatus.name.toLowerCase(), isFromPagination: true),
                  offset: serviceBookingController.bookingContent != null
                      ? serviceBookingController.bookingContent!.currentPage != null
                          ? serviceBookingController.bookingContent!.currentPage
                          : null
                      : null,
                  itemView: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _bookingList.length,
                    itemBuilder: (context, index) {
                      return BookingItemCard(
                        bookingModel: _bookingList.elementAt(index),
                      );
                    },
                  ),
                )),
              if (_bookingList.length > 0)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,
                  ),
                ),
              if (_bookingList.length == 0)
                SliverToBoxAdapter(
                    child: Center(
                  child: SizedBox(
                    height: Get.height * 0.7,
                    child: NoDataScreen(text: 'no_booking_request_available'.tr, type: NoDataType.BOOKING),
                  ),
                ))
            ]
          : [
              SliverPersistentHeader(
                delegate: ServiceRequestSectionMenu(),
                pinned: true,
                floating: false,
              ),
              SliverToBoxAdapter(child: BookingScreenShimmer())
            ],
      controller: bookingScreenScrollController,
    );
  }

  Widget getProductBookingTab(ServiceBookingController serviceBookingController) {
    List<BookingData>? _bookingList = serviceBookingController.productBookingList;
    return _buildBody(
      sliversItems: serviceBookingController.productBookingList != null
          ? [
              if (ResponsiveHelper.isDesktop(context))
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                ),
              SliverPersistentHeader(
                delegate: ProductRequestSectionMenu(),
                pinned: true,
                floating: false,
              ),
              if (ResponsiveHelper.isDesktop(context))
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                ),
              if (ResponsiveHelper.isMobile(context))
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                ),
              if (_bookingList!.length > 0)
                SliverToBoxAdapter(
                    child: PaginatedListView(
                  scrollController: bookingScreenScrollController,
                  totalSize: serviceBookingController.productBookingContent!.total,
                  onPaginate: (int offset) async => await serviceBookingController.getAllBookingProduct(
                      offset: offset, bookingStatus: serviceBookingController.selectedProductBookingStatus.name.toLowerCase(), isFromPagination: true),
                  offset: serviceBookingController.productBookingContent != null
                      ? serviceBookingController.productBookingContent!.currentPage != null
                          ? serviceBookingController.productBookingContent!.currentPage
                          : null
                      : null,
                  itemView: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _bookingList.length,
                    itemBuilder: (context, index) {
                      return ProductBookingItemCard(
                        bookingModel: _bookingList.elementAt(index),
                      );
                    },
                  ),
                )),
              if (_bookingList.length > 0)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,
                  ),
                ),
              if (_bookingList.length == 0)
                SliverToBoxAdapter(
                  child: Center(
                    child: SizedBox(
                      height: Get.height * 0.7,
                      child: NoDataScreen(text: 'no_booking_request_available'.tr, type: NoDataType.BOOKING),
                    ),
                  ),
                )
            ]
          : [
              SliverPersistentHeader(
                delegate: ProductRequestSectionMenu(),
                pinned: true,
                floating: false,
              ),
              SliverToBoxAdapter(child: BookingScreenShimmer())
            ],
      controller: productbookingScreenScrollController,
    );
  }

  Widget _buildBody({required List<Widget> sliversItems, required ScrollController controller}) {
    if (ResponsiveHelper.isWeb()) {
      return FooterBaseView(
        // isCenter: true,
        scrollController: controller,
        child: SizedBox(
          width: Dimensions.WEB_MAX_WIDTH,
          child: CustomScrollView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            slivers: sliversItems,
          ),
        ),
      );
    } else {
      return CustomScrollView(
        controller: controller,
        slivers: sliversItems,
      );
    }
  }
}
