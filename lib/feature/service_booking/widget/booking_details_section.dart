import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/service_booking/widget/booking_summery_widget.dart';
import 'package:repair/feature/service_booking/widget/product_booking_summery_widget.dart';
import 'package:repair/feature/service_booking/widget/provider_info.dart';
import 'package:repair/feature/service_booking/widget/service_man_info.dart';
import '../controller/product_booking_details_tabs_controller.dart';
import 'booking_screen_shimmer.dart';

class BookingDetailsSection extends StatelessWidget {
  final String bookingID;

  BookingDetailsSection({Key? key, required this.bookingID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsTabsController>(builder: (bookingDetailsTabController) {
      if (bookingDetailsTabController.bookingDetailsContent != null) {
        BookingDetailsContent? bookingDetailsContent = bookingDetailsTabController.bookingDetailsContent;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Dimensions.PADDING_SIZE_RADIUS,
                ),
                BookingInfo(bookingDetailsContent: bookingDetailsContent!, bookingDetailsTabController: bookingDetailsTabController),
                //Booking Summary

                Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
                BookingSummeryWidget(bookingDetailsContent: bookingDetailsContent),

                if (bookingDetailsContent.provider != null) ProviderInfo(provider: bookingDetailsContent.provider!),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                if (bookingDetailsContent.serviceman != null) ServiceManInfo(user: bookingDetailsContent.serviceman!.user!),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                bookingDetailsTabController.isCancelling
                    ? Container(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : bookingDetailsContent.bookingStatus == 'pending' || bookingDetailsContent.bookingStatus == 'accepted'
                        ? Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                bookingDetailsTabController.bookingCancel(bookingId: bookingDetailsContent.id!);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).errorColor.withOpacity(.2),
                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_LARGE))),
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                                    child: Text(
                                      'cancel'.tr,
                                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).errorColor),
                                    ),
                                  )),
                            ),
                          )
                        : SizedBox(),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              ],
            ),
          ),
        );
      } else {
        return SingleChildScrollView(child: BookingScreenShimmer());
      }
    });
  }
}

class ProductBookingDetailsSection extends StatelessWidget {
  final String bookingID;

  ProductBookingDetailsSection({Key? key, required this.bookingID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductBookingDetailsTabsController>(builder: (bookingDetailsTabController) {
      if (bookingDetailsTabController.productBookingDetailsContent != null) {
        BookingDetailsContent? bookingDetailsContent = bookingDetailsTabController.productBookingDetailsContent;
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Dimensions.PADDING_SIZE_RADIUS,
                ),
                ProductBookingInfo(bookingDetailsContent: bookingDetailsContent!, bookingDetailsTabController: bookingDetailsTabController),
                //Booking Summary

                Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
                ProductBookingSummeryWidget(bookingDetailsContent: bookingDetailsContent),

                // if (bookingDetailsContent.provider != null) ProviderInfo(provider: bookingDetailsContent.provider!),
                // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                // if (bookingDetailsContent.serviceman != null) ServiceManInfo(user: bookingDetailsContent.serviceman!.user!),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                bookingDetailsTabController.isCancelling
                    ? Container(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : bookingDetailsContent.bookingStatus == 'processed' || bookingDetailsContent.bookingStatus == 'shipped'
                        ? Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                bookingDetailsTabController.bookingCancel(bookingId: bookingDetailsContent.id!);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).errorColor.withOpacity(.2),
                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_LARGE))),
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                                    child: Text(
                                      'cancel'.tr,
                                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).errorColor),
                                    ),
                                  )),
                            ),
                          )
                        : SizedBox(),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              ],
            ),
          ),
        );
      } else {
        return SingleChildScrollView(child: BookingScreenShimmer());
      }
    });
  }
}
