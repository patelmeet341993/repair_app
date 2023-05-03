import 'package:repair/core/common_model/provider_model.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';
import 'package:repair/core/core_export.dart';

import '../controller/product_booking_details_tabs_controller.dart';

class BookingHistory extends StatelessWidget {
  final BookingDetailsContent? bookingDetailsContent;
  BookingHistory({Key? key, required this.bookingDetailsContent})
      : super(key: key);

  final List<StatusHistories> _statusScheduleList = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingDetailsTabsController>(
      builder: (bookingDetailsTabController) {
        if (bookingDetailsTabController.bookingDetailsContent!.detail != null) {
          List<StatusHistories> _statusSchedule = bookingDetailsTabController
              .bookingDetailsContent!.scheduleHistories!;
          List<StatusHistories> _statusHistory = bookingDetailsTabController
              .bookingDetailsContent!.statusHistories!;

          _statusScheduleList.add(_statusSchedule.elementAt(0));
          _statusScheduleList.addAll(_statusHistory);
          _statusScheduleList.addAll(_statusSchedule);
        }

        return !bookingDetailsTabController.isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${'booking_place'.tr} : ',
                          style: ubuntuMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                        ),
                        Text(
                          "${DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(bookingDetailsContent!.createdAt!.toString()))}",
                          textDirection: TextDirection.ltr,
                          style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${'service_scheduled_date'.tr} : ",
                          style: ubuntuMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                        ),
                        Text(
                          "${DateConverter.dateMonthYearTimeTwentyFourFormat(DateTime.tryParse(bookingDetailsContent!.serviceSchedule!)!)}",
                          style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault),
                          textDirection: TextDirection.ltr,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    RichText(
                      text: TextSpan(
                        text: '${'payment_status'.tr} : ',
                        style: ubuntuMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                        children: [
                          TextSpan(
                              text:
                                  '${bookingDetailsContent!.isPaid == 0 ? '${'unpaid'.tr}' : 'paid'.tr} ',
                              style: ubuntuMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: bookingDetailsContent!.isPaid == 0
                                      ? Theme.of(context).errorColor
                                      : Colors.green,
                                  decoration: TextDecoration.none)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    RichText(
                      text: TextSpan(
                        text: '${'booking_status'.tr} : ',
                        style: ubuntuMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                        children: [
                          TextSpan(
                              text:
                                  "${bookingDetailsContent!.bookingStatus!.tr}",
                              style: ubuntuMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                        ],
                      ),
                    ),
                    Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
                    if (_statusScheduleList.length > 0)
                      Container(
                          child: HistoryStatus(
                        statusHistories: _statusScheduleList.toSet().toList(),
                        fromStatus: false,
                        provider: bookingDetailsContent!.provider != null
                            ? bookingDetailsContent!.provider
                            : null,
                      )),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    ),
                  ],
                ),
              )
            : SizedBox();
      },
    );
  }
}

class HistoryStatus extends StatelessWidget {
  final List<StatusHistories>? statusHistories;
  final ProviderModel? provider;
  final bool fromStatus;
  HistoryStatus({
    required this.statusHistories,
    required this.fromStatus,
    required this.provider,
  });
  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: ConnectorThemeData(
          thickness: 2.0,
          color: Color(0xffFCEBD2),
        ),
        indicatorTheme: IndicatorThemeData(
          position: 0,
          size: 35.0,
        ),
      ),
      padding: EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_LARGE,
          bottom: Dimensions.PADDING_SIZE_LARGE,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: statusHistories!.length,
        contentsBuilder: (_, index) => Padding(
          padding: const EdgeInsets.only(left: 24.0, bottom: 20.0, right: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0)
                Text(
                  'service_booked_by_customer'.tr,
                  style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                ),
              if (statusHistories![index].schedule != null && index != 0)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Text(
                    "${'schedule_changed_by'.tr} ${statusHistories![index].user!.userType.toString().tr}"
                        .tr,
                    style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                ),
              if (statusHistories![index].bookingStatus != null)
                Text(
                  "${'service'.tr} ${"${statusHistories![index].bookingStatus!}".tr} ${'by'.tr} ${"${statusHistories![index].user!.userType}".tr}",
                  style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              if (statusHistories![index].bookingStatus != null &&
                  statusHistories![index].user!.userType == "provider-admin")
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Text(
                    "${provider!.companyName}",
                    style: ubuntuRegular.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(.5)),
                  ),
                ),
              if (statusHistories![index].user!.userType != "provider-admin")
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Text(
                    "${statusHistories!.elementAt(index).user!.firstName! + " " + statusHistories!.elementAt(index).user!.lastName!}",
                    style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.5),
                    ),
                  ),
                ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              if (statusHistories![index].bookingStatus != null)
                Text(
                  "${DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(statusHistories!.elementAt(index).createdAt.toString()))}",
                  textDirection: TextDirection.ltr,
                  style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.6)),
                ),
              if (statusHistories![index].schedule != null)
                Row(
                  children: [
                    Text(
                      '${'schedule_time'.tr}:  ',
                      style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                    Text(
                      "${DateConverter.dateMonthYearTimeTwentyFourFormat(DateTime.tryParse(statusHistories![index].schedule!)!)}",
                      style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.6)),
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_DEFAULT,
              ),
            ],
          ),
        ),
        connectorBuilder: (_, index, __) {
          return SolidLineConnector(
              color: Theme.of(context).colorScheme.primary);
        },
        indicatorBuilder: (_, index) {
          return DotIndicator(
            color: Theme.of(context).colorScheme.primary,
            child: Center(
                child: Icon(Icons.check, color: Theme.of(context).cardColor)),
          );
        },
      ),
    );
  }
}


class ProductBookingHistory extends StatelessWidget {
  final BookingDetailsContent? bookingDetailsContent;
  ProductBookingHistory({Key? key, required this.bookingDetailsContent})
      : super(key: key);

  final List<StatusHistories> _statusScheduleList = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductBookingDetailsTabsController>(
      builder: (bookingDetailsTabController) {
        if(bookingDetailsTabController.productBookingDetailsContent != null) {
          if (bookingDetailsTabController.productBookingDetailsContent!.detail != null) {
            List<StatusHistories> _statusSchedule = bookingDetailsTabController
                .productBookingDetailsContent!.scheduleHistories!;
            List<StatusHistories> _statusHistory = bookingDetailsTabController
                .productBookingDetailsContent!.statusHistories!;

            _statusScheduleList.add(_statusSchedule.elementAt(0));
            _statusScheduleList.addAll(_statusHistory);
            _statusScheduleList.addAll(_statusSchedule);
          }
        }

        return bookingDetailsTabController.productBookingDetailsContent != null
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${'order_place'.tr} : ',
                          style: ubuntuMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                        ),
                        Text(
                          "${DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(bookingDetailsContent!.createdAt!.toString()))}",
                          textDirection: TextDirection.ltr,
                          style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "${'service_scheduled_date'.tr} : ",
                    //       style: ubuntuMedium.copyWith(
                    //           fontSize: Dimensions.fontSizeDefault,
                    //           color:
                    //               Theme.of(context).textTheme.bodyText1!.color),
                    //     ),
                    //     Text(
                    //       "${DateConverter.dateMonthYearTimeTwentyFourFormat(DateTime.tryParse(bookingDetailsContent!.serviceSchedule!)!)}",
                    //       style: ubuntuRegular.copyWith(
                    //           fontSize: Dimensions.fontSizeDefault),
                    //       textDirection: TextDirection.ltr,
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: Dimensions.PADDING_SIZE_SMALL,
                    // ),
                    RichText(
                      text: TextSpan(
                        text: '${'payment_status'.tr} : ',
                        style: ubuntuMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                        children: [
                          TextSpan(
                              text:
                                  '${bookingDetailsContent!.isPaid == 0 ? '${'unpaid'.tr}' : 'paid'.tr} ',
                              style: ubuntuMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: bookingDetailsContent!.isPaid == 0
                                      ? Theme.of(context).errorColor
                                      : Colors.green,
                                  decoration: TextDecoration.none)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    RichText(
                      text: TextSpan(
                        text: '${'order_status'.tr} : ',
                        style: ubuntuMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                        children: [
                          TextSpan(
                              text:
                                  "${bookingDetailsContent!.bookingStatus!.tr}",
                              style: ubuntuMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                        ],
                      ),
                    ),
                    Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
                    if (_statusScheduleList.length > 0)
                      Container(
                          child: ProductHistoryStatus(
                        statusHistories: _statusScheduleList.toSet().toList(),
                        fromStatus: false,
                        provider: bookingDetailsContent!.provider != null
                            ? bookingDetailsContent!.provider
                            : null,
                      )),
                    SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    ),
                  ],
                ),
              )
            : CustomLoader();
      },
    );
  }
}

class ProductHistoryStatus extends StatelessWidget {
  final List<StatusHistories>? statusHistories;
  final ProviderModel? provider;
  final bool fromStatus;
  ProductHistoryStatus({
    required this.statusHistories,
    required this.fromStatus,
    required this.provider,
  });
  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: ConnectorThemeData(
          thickness: 2.0,
          color: Color(0xffFCEBD2),
        ),
        indicatorTheme: IndicatorThemeData(
          position: 0,
          size: 35.0,
        ),
      ),
      padding: EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_LARGE,
          bottom: Dimensions.PADDING_SIZE_LARGE,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: statusHistories!.length,
        contentsBuilder: (_, index) => Padding(
          padding: const EdgeInsets.only(left: 24.0, bottom: 20.0, right: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0)
                Text(
                  'product_booked_by_customer'.tr,
                  style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                ),
              if (statusHistories![index].schedule != null && index != 0)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Text(
                    "${'schedule_changed_by'.tr} ${statusHistories![index].user!.userType.toString().tr}"
                        .tr,
                    style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                ),
              if (statusHistories![index].bookingStatus != null)
                Text(
                  "${'product'.tr} ${"${statusHistories![index].bookingStatus!}".tr} ${'by'.tr} ${"${statusHistories![index].user!.userType}".tr}",
                  style: ubuntuRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              if (statusHistories![index].bookingStatus != null &&
                  statusHistories![index].user!.userType == "provider-admin")
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Text(
                    "${provider!.companyName}",
                    style: ubuntuRegular.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .color!
                            .withOpacity(.5)),
                  ),
                ),
              if (statusHistories![index].user!.userType != "provider-admin")
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Text(
                    "${statusHistories!.elementAt(index).user!.firstName! + " " + statusHistories!.elementAt(index).user!.lastName!}",
                    style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.5),
                    ),
                  ),
                ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              if (statusHistories![index].bookingStatus != null)
                Text(
                  "${DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(statusHistories!.elementAt(index).createdAt.toString()))}",
                  textDirection: TextDirection.ltr,
                  style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.6)),
                ),
              if (statusHistories![index].schedule != null)
                Row(
                  children: [
                    Text(
                      '${'schedule_time'.tr}:  ',
                      style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                    Text(
                      "${DateConverter.dateMonthYearTimeTwentyFourFormat(DateTime.tryParse(statusHistories![index].schedule!)!)}",
                      style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.6)),
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              SizedBox(
                height: Dimensions.PADDING_SIZE_DEFAULT,
              ),
            ],
          ),
        ),
        connectorBuilder: (_, index, __) {
          return SolidLineConnector(
              color: Theme.of(context).colorScheme.primary);
        },
        indicatorBuilder: (_, index) {
          return DotIndicator(
            color: Theme.of(context).colorScheme.primary,
            child: Center(
                child: Icon(Icons.check, color: Theme.of(context).cardColor)),
          );
        },
      ),
    );
  }
}
