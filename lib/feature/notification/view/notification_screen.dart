import 'package:repair/components/footer_base_view.dart';
import 'package:repair/components/menu_drawer.dart';
import 'package:repair/components/web_shadow_wrap.dart';
import 'package:repair/core/helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repair/components/custom_app_bar.dart';
import 'package:repair/components/custom_image.dart';
import 'package:repair/core/helper/date_converter.dart';
import 'package:repair/feature/notification/controller/notification_controller.dart';
import 'package:repair/feature/notification/widget/notification_dialog.dart';
import 'package:repair/feature/notification/widget/notification_shimmer.dart';
import 'package:repair/feature/root/view/no_data_screen.dart';
import 'package:repair/feature/splash/controller/splash_controller.dart';
import 'package:repair/utils/dimensions.dart';
import 'package:repair/utils/styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: ResponsiveHelper.isDesktop(context) ? MenuDrawer() : null,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: "notifications".tr,
          isBackButtonExist: true,
        ),
        body: GetBuilder<NotificationController>(
          initState: (state) {
            Get.find<NotificationController>().getNotifications(1);
          },
          builder: (controller) {
            return FooterBaseView(
                isScrollView: true,
                isCenter: Get.find<NotificationController>()
                            .notificationList
                            .length ==
                        0
                    ? true
                    : false,
                child: WebShadowWrap(
                  child: SizedBox(
                    width: Dimensions.WEB_MAX_WIDTH,
                    child: controller.isLoading
                        ? NotificationShimmer()
                        : controller.dateList.length == 0
                            ? NoDataScreen(
                                text: 'no_notification_found'.tr,
                                type: NoDataType.NOTIFICATION,
                              )
                            : CustomScrollView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                controller: controller.scrollController,
                                slivers: [
                                    SliverToBoxAdapter(
                                      child: Column(
                                        children: [
                                          ListView.builder(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .PADDING_SIZE_DEFAULT),
                                            itemBuilder: (context, index0) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL,
                                                      vertical: Dimensions
                                                          .PADDING_SIZE_SMALL,
                                                    ),
                                                    child: Text(
                                                      Get.find<
                                                              NotificationController>()
                                                          .dateList[index0]
                                                          .toString(),
                                                      style: ubuntuBold.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeLarge,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .color!
                                                                  .withOpacity(
                                                                      0.7)),
                                                      textDirection:
                                                          TextDirection.ltr,
                                                    ),
                                                  ),
                                                  if (controller
                                                          .notificationList
                                                          .length >
                                                      0)
                                                    Card(
                                                      color: Theme.of(context)
                                                          .hoverColor,
                                                      elevation: 0,
                                                      child: ListView.builder(
                                                        itemBuilder:
                                                            (context, index1) {
                                                          return InkWell(
                                                            onTap: () {
                                                              showDialog(
                                                                  barrierColor: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.6),
                                                                  context:
                                                                      context,
                                                                  builder: (ctx) =>
                                                                      NotificationDialog(
                                                                        notificationModel:
                                                                            controller.notificationList[index0][index1],
                                                                      ));
                                                            },
                                                            child: Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        Dimensions
                                                                            .PADDING_SIZE_SMALL,
                                                                    vertical:
                                                                        Dimensions
                                                                            .PADDING_SIZE_SMALL),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(50),
                                                                          child:
                                                                              CustomImage(
                                                                            image:
                                                                                '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                                                                '/push-notification/${controller.notificationList[index0][index1].coverImage}',
                                                                            height:
                                                                                30,
                                                                            width:
                                                                                30,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              Dimensions.PADDING_SIZE_DEFAULT,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text("${controller.notificationList[index0][index1].title.toString().trim()}", style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7), fontSize: Dimensions.fontSizeDefault)),
                                                                              SizedBox(
                                                                                height: Dimensions.PADDING_SIZE_SMALL,
                                                                              ),
                                                                              Text("${controller.notificationList[index0][index1].description}", maxLines: 2, style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5), fontSize: Dimensions.fontSizeDefault)),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                60,
                                                                            child:
                                                                                Text("${DateConverter.convertStringTimeToDate(DateConverter.isoUtcStringToLocalDate(controller.notificationList[index0][index1].createdAt))}")),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )),
                                                          );
                                                        },
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount: controller
                                                            .notificationList[
                                                                index0]
                                                            .length,
                                                      ),
                                                    )
                                                ],
                                              );
                                            },
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                controller.dateList.length,
                                          ),
                                          controller.isLoading
                                              ? CircularProgressIndicator()
                                              : SizedBox()
                                        ],
                                      ),
                                    )
                                  ]),
                  ),
                ));
          },
        ));
  }
}
