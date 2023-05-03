import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:repair/components/rating_bar.dart';
import 'package:repair/feature/shop/features/products/model/product_review_model.dart';

import '../../../../../components/custom_image.dart';
import '../../../../../core/helper/date_converter.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/gaps.dart';
import '../../../../../utils/styles.dart';
import '../../../../splash/controller/splash_controller.dart';

class ProductReviewItem extends StatelessWidget {

  final ProductReviewData reviewData;
  const ProductReviewItem({Key? key, required this.reviewData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int day = DateTime.now().difference(DateConverter.dateTimeStringToDate(DateConverter.isoStringToLocalDate( reviewData.createdAt!).toString())).inDays;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if(reviewData.customer != null)
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE)),
              child: Container(
                width: Dimensions.IMAGE_SIZE,
                height: Dimensions.IMAGE_SIZE,
                child: CustomImage(image:"${Get.find<SplashController>().configModel.content!.imageBaseUrl}/user/profile_image/${reviewData.customer!.profileImage}" ,),
              ),
            ),
            Gaps.horizontalGapOf(10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(reviewData.customer != null)
                      Text(reviewData.customer!.firstName! + " " + reviewData.customer!.lastName!,
                        style: ubuntuBold.copyWith(fontSize: 12,color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),
                      ),
                      if(reviewData.customer == null)
                        Text("customer_not_available".tr,
                        style: ubuntuBold.copyWith(fontSize: 12,color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),),
                      Container(
                        height: 20,
                        child: Row(
                          children: [
                            RatingBar(rating: reviewData.reviewRating),
                            Gaps.horizontalGapOf(5),
                            Text(
                              reviewData.reviewRating!.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ])),
            Text("${day>1? day.toString() + "days_ago".tr :"today".tr}", style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),),
          ],
        ),
        Gaps.verticalGapOf(8),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
            child: Text(reviewData.reviewComment!,
              style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor),
              textAlign: TextAlign.justify,
            )),
        Gaps.verticalGapOf(10),
      ],
    );
  }
}
