import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';

class CompletePage extends StatelessWidget {
final  bool isFromProduct;
  const CompletePage({Key? key, this.isFromProduct = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80.0,
            ),
            GetBuilder<CheckOutController>(builder: (controller) {
              return controller.cancelPayment == false
                  ? Column(
                      children: [
                        Text(
                          isFromProduct?"your_order_has_been_placed_successfully".tr: 'you_placed_the_booking_successfully'.tr,
                          style: ubuntuMedium.copyWith(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              color: Colors.blue),
                        ),
                        SizedBox(
                          height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,
                        ),
                        Image.asset(
                          Images.orderComplete,
                          scale: 3,
                        ),
                        if (ResponsiveHelper.isWeb())
                          SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,
                          )
                      ],
                    )
                  : Text(
                isFromProduct ? "your_product_is_failed_to_place": 'your_bookings_is_failed_to_place'.tr,
                      style: ubuntuMedium.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          color: Colors.red),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
