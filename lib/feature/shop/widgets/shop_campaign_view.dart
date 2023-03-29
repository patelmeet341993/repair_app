import 'package:get/get.dart';
import 'package:repair/feature/shop/controller/shop_campaign_controller.dart';
import 'package:repair/feature/shop/model/shop_campaign_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:repair/core/core_export.dart';

class ShopCampaignView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopCampaignController>(builder: (shopCampaignController) {
      if (shopCampaignController.campaignList != null &&
          shopCampaignController.campaignList!.length == 0) {
        return SizedBox();
      } else {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: ResponsiveHelper.isTab(context) ||
                    MediaQuery.of(context).size.width > 450
                ? 350
                : MediaQuery.of(context).size.width * 0.40,
            padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
            child: shopCampaignController.campaignList != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: false,
                            viewportFraction: .92,
                            disableCenter: true,
                            autoPlayInterval: Duration(seconds: 7),
                            onPageChanged: (index, reason) {
                              shopCampaignController.setCurrentIndex(index, true);
                            },
                          ),
                          itemCount:
                              shopCampaignController.campaignList!.length == 0
                                  ? 1
                                  : shopCampaignController.campaignList!.length,
                          itemBuilder: (context, index, _) {
                            String? _baseUrl = Get.find<SplashController>()
                                .configModel
                                .content!
                                .imageBaseUrl;
                            return InkWell(
                              onTap: () {
                                if (isRedundentClick(DateTime.now())) {
                                  return;
                                }
                                print("checking_campaign");
                                print(shopCampaignController
                                    .campaignList![index].id!);
                                print(shopCampaignController.campaignList![index]
                                    .discount!.discountType!);
                                shopCampaignController.navigateFromCampaign(
                                    shopCampaignController.campaignList![index].id!,
                                    shopCampaignController.campaignList![index]
                                        .discount!.discountType!);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL),
                                    //boxShadow: shadow,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL),
                                    child: GetBuilder<SplashController>(
                                      builder: (splashController) {
                                        return CustomImage(
                                          image:
                                              '$_baseUrl/campaign/${shopCampaignController.campaignList![index].coverImage}',
                                          fit: BoxFit.cover,
                                          placeholder: Images.placeholder,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Align(
                        alignment: Alignment.center,
                        child: AnimatedSmoothIndicator(
                          activeIndex: shopCampaignController.currentIndex!,
                          count: shopCampaignController.campaignList!.length,
                          effect: ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor:
                                Theme.of(context).colorScheme.primary,
                            dotColor: Theme.of(context).disabledColor,
                          ),
                        ),
                      ),
                    ],
                  )
                : Shimmer(
                    duration: Duration(seconds: 2),
                    enabled: true,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          color: Colors.grey[
                              Get.find<ThemeController>().darkTheme
                                  ? 700
                                  : 300],
                        )),
                  ));
      }
    });
  }
}
