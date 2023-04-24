import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';

import '../controller/product_booking_details_tabs_controller.dart';

class ProductBookingSummeryWidget extends StatelessWidget {
  final BookingDetailsContent bookingDetailsContent;

  const ProductBookingSummeryWidget({Key? key, required this.bookingDetailsContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _serviceDiscount = 0;
    bookingDetailsContent.detail?.forEach((service) {
      _serviceDiscount = _serviceDiscount + service.discountAmount;
    });

    return GetBuilder<ProductBookingDetailsTabsController>(builder: (bookingDetailsController) {
      if (!bookingDetailsController.isLoading)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Text('order_summary'.tr,
                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyText1!.color))),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_RADIUS),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_RADIUS),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('product_info'.tr,
                        style: ubuntuBold.copyWith(
                            fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyText1!.color!, decoration: TextDecoration.none)),
                    Text('product_cost'.tr,
                        style: ubuntuBold.copyWith(
                            fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyText1!.color!, decoration: TextDecoration.none)),
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemBuilder: (context, index) {
                return ProductInfoItem(
                  bookingDetailsContent: bookingDetailsContent,
                  bookingService: bookingDetailsController.productBookingDetailsContent!.detail![index],
                  bookingDetailsController: bookingDetailsController,
                  index: index,
                );
              },
              itemCount: bookingDetailsController.productBookingDetailsContent!.detail?.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Divider(
                height: 2,
                color: Colors.grey,
              ),
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'sub_total'.tr,
                      style: ubuntuMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${PriceConverter.convertPrice(bookingDetailsController.allTotalCost, isShowLongPrice: true)}',
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ],
              ),
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Text('product_discount'.tr,
                          style:
                              ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                          overflow: TextOverflow.ellipsis)),
                  Text(
                    "(-) ${PriceConverter.convertPrice(_serviceDiscount)}",
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'coupon_discount'.tr,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '(-) ${PriceConverter.convertPrice(bookingDetailsController.productBookingDetailsContent!.totalCouponDiscountAmount!.toDouble())}',
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'campaign_discount'.tr,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '(-) ${PriceConverter.convertPrice(bookingDetailsController.productBookingDetailsContent!.totalCampaignDiscountAmount!.toDouble())}',
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Text(
                    'product_vat'.tr,
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                    overflow: TextOverflow.ellipsis,
                  )),
                  Text(
                    '(+) ${PriceConverter.convertPrice(bookingDetailsController.productBookingDetailsContent!.totalTaxAmount!.toDouble(), isShowLongPrice: true)}',
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Divider(),
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'grand_total'.tr,
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${PriceConverter.convertPrice(bookingDetailsController.productBookingDetailsContent!.totalBookingAmount!.toDouble(), isShowLongPrice: true)}',
                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.PADDING_FOR_CHATTING_BUTTON),
          ],
        );
      return SizedBox();
    });
  }
}

class ProductInfoItem extends StatelessWidget {
  final BookingDetailsContent bookingDetailsContent;
  final int index;
  final ProductBookingDetailsTabsController bookingDetailsController;
  final BookingContentDetailsItem bookingService;

  const ProductInfoItem(
      {Key? key, required this.bookingService, required this.bookingDetailsController, required this.index, required this.bookingDetailsContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _unitTotalCost = 0;
    try {
      _unitTotalCost = bookingDetailsController.unitTotalCost[index];
    } catch (error) {
      print('error : $error');
    }
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width / 2,
                      child: Text(
                        bookingService.productName,
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${PriceConverter.convertPrice(_unitTotalCost, isShowLongPrice: true)}',
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
                Container(
                  width: Get.width / 1.5,
                  child: Text(
                    '${bookingService.productVariantId ?? ""}',
                    style:
                        ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                  ),
                ),
                Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                priceText('unit_price'.tr, bookingService.totalCost.toDouble(), context, mainAxisAlignmentStart: true),
                Row(
                  children: [
                    Text(
                      'quantity'.tr,
                      style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)),
                    ),
                    Text(
                      " :  ${bookingService.quantity}",
                      style:
                          ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6), fontSize: Dimensions.fontSizeDefault),
                    )
                  ],
                ),
                bookingService.discountAmount> 0
                    ? priceText('discount'.tr, bookingService.discountAmount.toDouble(), context, mainAxisAlignmentStart: true)
                    : SizedBox(),
                bookingService.campaignDiscountAmount> 0
                    ? priceText('campaign'.tr, bookingService.campaignDiscountAmount.toDouble(), context, mainAxisAlignmentStart: true)
                    : SizedBox(),
                bookingService.overallCouponDiscountAmount> 0
                    ? priceText('coupon'.tr, bookingService.overallCouponDiscountAmount.toDouble(), context)
                    : SizedBox(),
              ],
            ),
            if (bookingDetailsContent.bookingStatus == 'completed')
              Align(
                alignment: Get.find<LocalizationController>().isLtr ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: Dimensions.STATUS_BUTTON_WEIGHT,
                  child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).hoverColor)),
                      onPressed: () {
                        Get.bottomSheet(ReviewRecommendationDialog(
                          index: index,
                          serviceID: bookingDetailsContent.detail![index].serviceId,
                          bookingID: bookingDetailsContent.detail![index].bookingId,
                          bookingDetailsContent: bookingDetailsContent,
                          variantKey: bookingService.variantKey,
                        ));
                      },
                      child: Center(
                          child: Text(
                        "review".tr,
                        style: ubuntuMedium,
                      ))),
                ),
              )
          ],
        ));
  }
}

Widget priceText(String title, double amount, context, {bool mainAxisAlignmentStart = false}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: mainAxisAlignmentStart ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title + ' :   ',
            style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
          ),
          Text(
            '${PriceConverter.convertPrice(amount, isShowLongPrice: true)}',
            style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6), fontSize: Dimensions.fontSizeDefault),
          )
        ],
      ),
      Gaps.verticalGapOf(Dimensions.PADDING_SIZE_MINI),
    ],
  );
}
