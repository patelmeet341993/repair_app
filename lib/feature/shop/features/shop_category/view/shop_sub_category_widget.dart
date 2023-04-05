import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/features/products/controller/product_controller.dart';

import '../model/shop_category_model.dart';

class ShopSubCategoryWidget extends GetView<ServiceController> {
  final ShopCategoryModel? categoryModel;

  ShopSubCategoryWidget({
    required this.categoryModel,
  });

  @override
  Widget build(BuildContext context) {
    bool _desktop = ResponsiveHelper.isDesktop(context);

    return InkWell(
      onTap: () {
        print("ShopSub ${categoryModel!.totalproducts.length}");
        Get.find<ProductController>().cleanSubCategory();
        Get.toNamed(
          RouteHelper.allProductScreenRoute("${categoryModel!.id!.toString()}"),
          arguments: categoryModel!.totalproducts,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.PADDING_SIZE_DEFAULT),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), color: Theme.of(context).cardColor, boxShadow: Get.isDarkMode ? null : cardShadow),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            child: CustomImage(
              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/productcategory/${categoryModel!.image}',
              height: _desktop ? 120 : 78,
              width: _desktop ? 120 : 78,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(children: [
                  Expanded(
                      child: Text(
                    categoryModel!.name ?? "",
                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                    maxLines: _desktop ? 1 : 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                ]),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text(
                  categoryModel!.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_SMALL,
                ),
                Text(
                  "${(categoryModel ?? ShopCategoryModel()).totalproductsCount ?? 0} ${'products'.tr} ",
                  style: ubuntuRegular.copyWith(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}