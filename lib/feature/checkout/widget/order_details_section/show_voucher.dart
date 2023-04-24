import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/voucher/controller/coupon_controller.dart';
import 'dart:ui' as ui;

class ShowVoucher extends StatelessWidget {
  const ShowVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(builder: (couponController) {
      return couponController.coupon != null
          ? Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_SMALL,
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.6)
                          .withOpacity(.3),
                      width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Images.couponIcon,
                        width: 20.0,
                        height: 20.0,
                      ),
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      // Text("${couponController.coupon!.couponCode! }",
                      Text(
                        "#12345678",
                        style: ubuntuMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault),
                      ),
                      Text(
                        "applied".tr,
                        style: ubuntuMedium.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(.6),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.getVoucherRoute());
                    },
                    child: Text(
                      'remove'.tr,
                      style: ubuntuMedium.copyWith(
                          color: Theme.of(context).errorColor),
                    ),
                  )
                ],
              ),
            )
          : ApplyVoucher();
    });
  }
}


class ProductShowVoucher extends StatelessWidget {
  const ProductShowVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(builder: (couponController) {
      return couponController.coupon != null
          ? Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_SMALL,
            horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(.6)
                    .withOpacity(.3),
                width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  Images.couponIcon,
                  width: 20.0,
                  height: 20.0,
                ),
                SizedBox(
                  width: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                // Text("${couponController.coupon!.couponCode! }",
                Text(
                  "#12345678",
                  style: ubuntuMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault),
                ),
                Text(
                  "applied".tr,
                  style: ubuntuMedium.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(.6),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(RouteHelper.getProductVoucherRoute());
              },
              child: Text(
                'remove'.tr,
                style: ubuntuMedium.copyWith(
                    color: Theme.of(context).errorColor),
              ),
            )
          ],
        ),
      )
          : ProductApplyVoucher();
    });
  }
}
