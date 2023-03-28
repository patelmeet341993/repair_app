import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/controller/shop_banner_controller.dart';
import 'package:repair/feature/shop/model/shop_banner_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShopBannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopBannerController>(

      builder: (shopBannerController) {
        return (shopBannerController.banners != null &&
                shopBannerController.banners!.length == 0)
            ? SizedBox()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: ResponsiveHelper.isTab(context) ||
                        MediaQuery.of(context).size.width > 450
                    ? 350
                    : MediaQuery.of(context).size.width * 0.40,
                padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: shopBannerController.banners != null
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
                                  shopBannerController.setCurrentIndex(index, true);
                                },
                              ),
                              itemCount: shopBannerController.banners!.length == 0
                                  ? 1
                                  : shopBannerController.banners!.length,
                              itemBuilder: (context, index, _) {
                                String? _baseUrl = Get.find<SplashController>()
                                    .configModel
                                    .content!
                                    .imageBaseUrl;
                                ShopBannerModel shopBannerModel =
                                    shopBannerController.banners![index];
                                return InkWell(
                                  onTap: () {
                                    String link =
                                        shopBannerModel.redirectLink != null
                                            ? shopBannerModel.redirectLink!
                                            : '';
                                    String id = shopBannerModel.category != null
                                        ? shopBannerModel.category!.id!
                                        : '';
                                    String name = shopBannerModel.category != null
                                        ? shopBannerModel.category!.name!
                                        : "";
                                    shopBannerController.navigateFromBanner(
                                        shopBannerModel.resourceType!,
                                        id,
                                        link,
                                        shopBannerModel.resourceId != null
                                            ? shopBannerModel.resourceId!
                                            : '',
                                        categoryName: name);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.RADIUS_SMALL),
                                        boxShadow: shadow,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.RADIUS_SMALL),
                                        child: GetBuilder<SplashController>(
                                          builder: (splashController) {
                                            return CustomImage(
                                              image:
                                                  '$_baseUrl/productbanner/${shopBannerController.banners![index].bannerImage}',
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
                              activeIndex: shopBannerController.currentIndex!,
                              count: shopBannerController.banners!.length,
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
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_SMALL),
                              color: Colors.grey[
                                  Get.find<ThemeController>().darkTheme
                                      ? 700
                                      : 300],
                            ))));
      },
    );
  }
}
