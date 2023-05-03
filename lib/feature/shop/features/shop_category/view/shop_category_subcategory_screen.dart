import 'package:repair/components/footer_base_view.dart';
import 'package:repair/components/menu_drawer.dart';
import 'package:repair/feature/home/widget/category_view.dart';
import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/features/shop_category/view/shop_subcategory_view.dart';

import '../controller/shop_category_controller.dart';
import '../model/shop_category_model.dart';

class ShopCategorySubCategoryScreen extends StatefulWidget {
  final String categoryID;
  final String categoryName;
  final String subCategoryIndex;

  ShopCategorySubCategoryScreen({Key? key, required this.categoryID, required this.categoryName, required this.subCategoryIndex}) : super(key: key);

  @override
  State<ShopCategorySubCategoryScreen> createState() => _ShopCategorySubCategoryScreenState();
}

class _ShopCategorySubCategoryScreenState extends State<ShopCategorySubCategoryScreen> {
  ScrollController scrollController = ScrollController();
  String? subCategoryIndex;

  @override
  void initState() {
    Get.find<ShopCategoryController>().getCategoryList(1, false);
    subCategoryIndex = widget.subCategoryIndex;
    Get.find<ShopCategoryController>().getSubCategoryList(widget.categoryID, int.parse(widget.subCategoryIndex), shouldUpdate: false);
    if (!ResponsiveHelper.isWeb()) moved();
    super.initState();
  }

  moved() async {
    Future.delayed(Duration(seconds: 1), () {
      try {
        Scrollable.ensureVisible(
          Get.find<ShopCategoryController>().categoryList!.elementAt(int.parse(subCategoryIndex!)).globalKey!.currentContext!,
          duration: Duration(seconds: 1),
        );
      } catch (e) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopCategoryController>(builder: (categoryController) {
      return Scaffold(
        endDrawer: ResponsiveHelper.isDesktop(context) ? MenuDrawer() : null,
        appBar: CustomAppBar(
          title: 'available_product'.tr,
        ),
        body: FooterBaseView(
          child: SizedBox(
            width: Dimensions.WEB_MAX_WIDTH,
            child: CustomScrollView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                ),
                SliverToBoxAdapter(
                  child: (categoryController.categoryList != null && !categoryController.isSearching!)
                      ? Center(
                          child: Container(
                            height: ResponsiveHelper.isDesktop(context)
                                ? 150
                                : ResponsiveHelper.isTab(context)
                                    ? 140
                                    : 130,
                            margin: EdgeInsets.only(
                              left: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.PADDING_SIZE_DEFAULT,
                            ),
                            width: Dimensions.WEB_MAX_WIDTH,
                            padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL, top: Dimensions.PADDING_SIZE_DEFAULT),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryController.categoryList!.length,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(
                                left: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.PADDING_SIZE_SMALL,
                                right: ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.PADDING_SIZE_SMALL,
                              ),
                              itemBuilder: (context, index) {
                                ShopCategoryModel categoryModel = categoryController.categoryList!.elementAt(index);
                                return InkWell(
                                  key: !ResponsiveHelper.isWeb() ? categoryModel.globalKey : null,
                                  onTap: () {
                                    subCategoryIndex = index.toString();
                                    Get.find<ShopCategoryController>().getSubCategoryList(categoryModel.id!, index);
                                  },
                                  hoverColor: Colors.transparent,
                                  child: Container(
                                    width: ResponsiveHelper.isDesktop(context)
                                        ? 150
                                        : ResponsiveHelper.isTab(context)
                                            ? 140
                                            : 100,
                                    margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    decoration: BoxDecoration(
                                      color:
                                          index != int.parse(subCategoryIndex!) ? Theme.of(context).primaryColorLight : Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(Dimensions.RADIUS_DEFAULT),
                                      ),
                                    ),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                                        child: CustomImage(
                                          fit: BoxFit.cover,
                                          height: ResponsiveHelper.isDesktop(context)
                                              ? 50
                                              : ResponsiveHelper.isTab(context)
                                                  ? 40
                                                  : 30,
                                          width: ResponsiveHelper.isDesktop(context)
                                              ? 50
                                              : ResponsiveHelper.isTab(context)
                                                  ? 40
                                                  : 30,
                                          image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                              '/productcategory/${categoryController.categoryList![index].image}',
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.PADDING_SIZE_SMALL,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                        child: Text(
                                          categoryController.categoryList![index].name!,
                                          style: ubuntuRegular.copyWith(
                                              fontSize: Dimensions.fontSizeSmall, color: index == int.parse(subCategoryIndex!) ? Colors.white : Colors.black),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : ResponsiveHelper.isDesktop(context)
                          ? WebCategoryShimmer(
                              categoryController: categoryController,
                              fromHomeScreen: false,
                            )
                          : SizedBox(),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: Dimensions.WEB_MAX_WIDTH,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE),
                      child: Center(
                        child: Text(
                          'sub_categories'.tr,
                          style: ubuntuRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault, color: Get.isDarkMode ? Colors.white : Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                  ),
                ),
                ShopSubCategoryView(
                  noDataText: "no_subcategory_found".tr,
                  isScrollable: true,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
class WebCategoryShimmer extends StatelessWidget {
  final ShopCategoryController categoryController;
  final bool? fromHomeScreen;

  WebCategoryShimmer(
      {required this.categoryController, this.fromHomeScreen = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Dimensions.WEB_MAX_WIDTH,
        child: Column(
          children: [
            if (fromHomeScreen!)
              SizedBox(
                height: Dimensions.PADDING_SIZE_DEFAULT,
              ),
            if (fromHomeScreen!)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[
                      Get.find<ThemeController>().darkTheme ? 700 : 300],
                      borderRadius: BorderRadius.all(Radius.circular(
                        Dimensions.RADIUS_DEFAULT,
                      )),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[
                      Get.find<ThemeController>().darkTheme ? 700 : 300],
                      borderRadius: BorderRadius.all(Radius.circular(
                        Dimensions.RADIUS_DEFAULT,
                      )),
                    ),
                  )
                ],
              ),
            if (fromHomeScreen!)
              SizedBox(
                height: Dimensions.PADDING_SIZE_DEFAULT,
              ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  decoration: BoxDecoration(
                      color: Colors.grey[
                      Get.find<ThemeController>().darkTheme ? 700 : 300],
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.RADIUS_DEFAULT))),
                  margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                  child: Shimmer(
                    duration: Duration(seconds: 2),
                    enabled: true,
                    child: Row(children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                      Container(
                          color: Colors.grey[
                          Get.find<ThemeController>().darkTheme
                              ? 600
                              : 300]),
                    ]),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveHelper.isDesktop(context)
                    ? 8
                    : ResponsiveHelper.isTab(context)
                    ? 6
                    : 4,
                crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                childAspectRatio:
                ResponsiveHelper.isDesktop(context) ? 1 : 0.85,
              ),
            ),
          ],
        ),
      ),
    );
  }
}