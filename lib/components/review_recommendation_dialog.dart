import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:repair/core/core_export.dart';

class ReviewRecommendationDialog extends StatelessWidget {
  final int index;
  final BookingDetailsContent bookingDetailsContent;
  final String serviceID;
  final String bookingID;
  final String variantKey;
  const ReviewRecommendationDialog({
    Key? key,
    required this.serviceID,
    required this.bookingID,
    required this.bookingDetailsContent,
    required this.index,
    required this.variantKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: Container(
          width: Dimensions.WEB_MAX_WIDTH,
          padding: EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT,
              bottom: Dimensions.PADDING_SIZE_DEFAULT),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () => Get.back(),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_DEFAULT,
                              right: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Icon(
                            Icons.close,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(.6),
                          ),
                        )),
                  ),
                  Text(
                    'how_was_your_last_service'.tr,
                    style: ubuntuBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  Text(
                    'leave_a_review'.tr,
                    style: ubuntuBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  Image.asset(
                    Images.emptyReview,
                    scale: Dimensions.PADDING_SIZE_SMALL,
                    color: Get.isDarkMode
                        ? Theme.of(context).primaryColorLight
                        : Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          height: 40,
                          width:
                              ResponsiveHelper.isDesktop(context) ? 200 : 150,
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).hoverColor)),
                              onPressed: () => Get.back(),
                              child: Center(
                                child: Text(
                                  'skip'.tr,
                                  style: ubuntuMedium.copyWith(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color!
                                              .withOpacity(.6),
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                              ))),
                      CustomButton(
                        height: 40,
                        width: ResponsiveHelper.isDesktop(context) ? 200 : 150,
                        fontSize: Dimensions.fontSizeSmall,
                        buttonText: 'give_review'.tr,
                        onPressed: () {
                          Get.back();
                          Get.toNamed(RouteHelper.getRateReviewScreen(
                            serviceID,
                            bookingID,
                            bookingDetailsContent,
                            index,
                            variantKey,
                          ));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  )
                ]),
          )),
    );
  }
}
