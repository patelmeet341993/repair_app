import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/service_booking/controller/invoice_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class BookingInfo extends StatelessWidget {
  final BookingDetailsContent bookingDetailsContent;
  final BookingDetailsTabsController bookingDetailsTabController;
  BookingInfo(
      {Key? key,
      required this.bookingDetailsContent,
      required this.bookingDetailsTabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${'booking'.tr} #${bookingDetailsContent.readableId}',
                      style: ubuntuMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                          decoration: TextDecoration.none),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: Dimensions.PADDING_SIZE_DEFAULT),
                      child: ElevatedButton(
                        onPressed: () async {
                          var pdfFile =
                              await InvoiceController.generateUint8List(
                                  bookingDetailsContent,
                                  bookingDetailsTabController.invoiceItems,
                                  bookingDetailsTabController);
                          Printing.layoutPdf(
                            onLayout: (PdfPageFormat format) {
                              return pdfFile;
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.PADDING_SIZE_SMALL - 2,
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: Center(
                              child: Text(
                            "invoice".tr,
                            style: ubuntuMedium.copyWith(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: Dimensions.fontSizeDefault),
                          )),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.PADDING_SIZE_SMALL - 2,
                          horizontal: Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).hoverColor),
                      child: Text(
                        ""
                                "${bookingDetailsContent.bookingStatus!}"
                            .tr,
                        style: ubuntuMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.fontSizeSmall,
                          color: bookingDetailsContent.bookingStatus ==
                                  "ongoing"
                              ? const Color(0xff2B95FF)
                              : bookingDetailsContent.bookingStatus == "pending"
                                  ? Theme.of(context).colorScheme.primary
                                  : bookingDetailsContent.bookingStatus ==
                                          "accepted"
                                      ? const Color(0xff0461A5)
                                      : bookingDetailsContent.bookingStatus ==
                                              "completed"
                                          ? const Color(0xff16B559)
                                          : const Color(0xffFF3737),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
            BookingItem(
              img: Images.iconCalendar,
              title: "${'booking_date'.tr} : ",
              date:
                  "${DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(bookingDetailsContent.createdAt!))}",
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            BookingItem(
                img: Images.iconCalendar,
                title: "${'service_schedule_date'.tr} : ",
                date:
                    "${DateConverter.dateMonthYearTimeTwentyFourFormat(DateTime.tryParse(bookingDetailsContent.serviceSchedule!)!)}"),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            BookingItem(
              img: Images.iconLocation,
              title:
                  '${'address'.tr} : ${bookingDetailsContent.serviceAddress != null ? bookingDetailsContent.serviceAddress!.address! : 'no_address_found'.tr}',
              date: '',
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
            Text("payment_method".tr,
                style: ubuntuMedium.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).textTheme.bodyText1!.color)),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${bookingDetailsContent.paymentMethod!}'.tr,
                    style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(.5))),
                RichText(
                  text: TextSpan(
                      text: "${'payment_status'.tr} : ",
                      style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(.5)),
                      children: <TextSpan>[
                        TextSpan(
                          text: bookingDetailsContent.isPaid == 1
                              ? "paid".tr
                              : "unpaid".tr,
                          style: ubuntuBold.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: bookingDetailsContent.isPaid == 1
                                  ? Colors.green
                                  : Theme.of(context).errorColor),
                        )
                      ]),
                ),
              ],
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            if (bookingDetailsContent.transactionId != "cash-payment")
              Text(
                "${'transaction_id'.tr} : ${bookingDetailsContent.transactionId}",
                style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).hintColor),
              ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Row(
              children: [
                Text(
                  "${'amount'.tr}:",
                  style: ubuntuBold.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                SizedBox(
                  width: Dimensions.PADDING_SIZE_SMALL,
                ),
                Text(
                  "${PriceConverter.convertPrice(bookingDetailsContent.totalBookingAmount!.toDouble())}",
                  style: ubuntuBold.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
              ],
            ),
            Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
          ],
        ),
      ),
    );
  }
}
