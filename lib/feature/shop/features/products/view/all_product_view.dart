import 'package:repair/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:repair/components/footer_base_view.dart';
import 'package:repair/components/paginated_list_view.dart';
import 'package:repair/components/service_view_vertical.dart';
import 'package:repair/components/service_widget_vertical.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/features/products/components/product_view_vertical.dart';
import 'package:repair/feature/shop/features/products/components/product_widget_vertical.dart';
import 'package:repair/feature/shop/features/products/controller/product_controller.dart';
import 'package:repair/feature/shop/features/products/controller/product_controller.dart';

import '../model/product_model.dart';

class AllProductView extends StatefulWidget {
  final String fromPage;
  final String campaignID;

  AllProductView({required this.fromPage, required this.campaignID});

  @override
  State<AllProductView> createState() => _AllProductViewState();
}

class _AllProductViewState extends State<AllProductView> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.fromPage == 'allProduct'
            ? 'all_product'.tr
            : widget.fromPage == 'fromRecommendedScreen'
                ? 'recommended_for_you'.tr
                : widget.fromPage == 'fromPopularServiceView'
                    ? 'popular_product'.tr
                    : 'available_product'.tr,
        showCart: true,
      ),
      endDrawer: ResponsiveHelper.isDesktop(context) ? MenuDrawer() : null,
      body: _buildBody(widget.fromPage, context, scrollController),
    );
  }

  Widget _buildBody(String fromPage, BuildContext context, ScrollController scrollController) {
    if (fromPage == 'fromPopularServiceView') {
      return GetBuilder<ProductController>(
        initState: (state) {
          Get.find<ProductController>().getPopularProductList(1, true);
        },
        builder: (productController) {
          return FooterBaseView(
            scrollController: scrollController,
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Column(
                children: [
                  if (ResponsiveHelper.isWeb())
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.PADDING_SIZE_DEFAULT,
                        Dimensions.fontSizeDefault,
                        Dimensions.PADDING_SIZE_DEFAULT,
                        Dimensions.PADDING_SIZE_SMALL,
                      ),
                      child: TitleWidget(
                        title: 'popular_product'.tr,
                      ),
                    ),
                  PaginatedListView(
                    scrollController: scrollController,
                    totalSize: productController.popularBasedProductContent != null ? productController.popularBasedProductContent!.total! : null,
                    offset: productController.popularBasedProductContent != null
                        ? productController.popularBasedProductContent!.currentPage != null
                            ? productController.popularBasedProductContent!.currentPage!
                            : null
                        : null,
                    onPaginate: (int offset) async {
                      print("popular_service_on_paginate");
                      return await productController.getPopularProductList(offset, false);
                    },
                    itemView: ProductViewVertical(
                      product: productController.popularBasedProductContent != null ? productController.popularProductList : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                      ),
                      type: 'others',
                      noDataType: NoDataType.HOME,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (fromPage == 'fromCampaign') {
      return GetBuilder<ProductController>(
        initState: (state) {
          Get.find<ProductController>().getEmptyCampaignProduct();
          Get.find<ProductController>().getCampaignBasedProductList(widget.campaignID, true);
        },
        builder: (serviceController) {
          return _buildWidget(serviceController.campaignBasedProductList, context);
        },
      );
    } else if (fromPage == 'fromRecommendedScreen') {
      return GetBuilder<ProductController>(
        initState: (state) {
          Get.find<ProductController>().getRecommendedProductList(1, true);
        },
        builder: (serviceController) {
          return FooterBaseView(
            scrollController: scrollController,
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Column(
                children: [
                  if (ResponsiveHelper.isWeb())
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.PADDING_SIZE_DEFAULT,
                        Dimensions.fontSizeDefault,
                        Dimensions.PADDING_SIZE_DEFAULT,
                        Dimensions.PADDING_SIZE_SMALL,
                      ),
                      child: TitleWidget(
                        title: 'recommended_for_you'.tr,
                      ),
                    ),
                  PaginatedListView(
                    scrollController: scrollController,
                    totalSize: serviceController.recommendedBasedProductContent != null ? serviceController.recommendedBasedProductContent!.total! : null,
                    offset: serviceController.recommendedBasedProductContent != null
                        ? serviceController.recommendedBasedProductContent!.currentPage != null
                            ? serviceController.recommendedBasedProductContent!.currentPage!
                            : null
                        : null,
                    onPaginate: (int offset) async {
                      printLog("inside_on_paginate:$offset");
                      return await serviceController.getRecommendedProductList(offset, false);
                    },
                    itemView: ProductViewVertical(
                      product: serviceController.recommendedBasedProductContent != null ? serviceController.recommendedProductList : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                      ),
                      type: 'others',
                      noDataType: NoDataType.HOME,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (fromPage == 'allProducts') {
      return GetBuilder<ProductController>(initState: (state) {
        Get.find<ProductController>().getAllProductList(1, true);
      }, builder: (serviceController) {
        return FooterBaseView(
          scrollController: scrollController,
          child: SizedBox(
            width: Dimensions.WEB_MAX_WIDTH,
            child: Column(
              children: [
                if (ResponsiveHelper.isWeb())
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: TitleWidget(
                      title: 'all_product'.tr,
                    ),
                  ),
                SizedBox(
                  height: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                PaginatedListView(
                  scrollController: scrollController,
                  totalSize: serviceController.productContent != null
                      ? serviceController.productContent!.total != null
                          ? serviceController.productContent!.total!
                          : null
                      : null,
                  offset: serviceController.productContent != null
                      ? serviceController.productContent!.currentPage != null
                          ? serviceController.productContent!.currentPage!
                          : null
                      : null,
                  onPaginate: (int offset) async => await serviceController.getAllProductList(offset, false),
                  itemView: ProductViewVertical(
                    product: serviceController.productContent != null ? serviceController.allProduct : null,
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                      vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                    ),
                    type: 'others',
                    noDataType: NoDataType.HOME,
                  ),
                ),
              ],
            ),
          ),
        );
      });
    } else {
      return GetBuilder<ProductController>(
        initState: (state) {
          Get.find<ProductController>().getSubCategoryBasedProductList(fromPage, false, isShouldUpdate: true);
        },
        builder: (serviceController) {
          return _buildWidget(serviceController.subCategoryBasedProductList, context);
        },
      );
    }
  }

  Widget _buildWidget(List<Product>? productList, BuildContext context) {
    return FooterBaseView(
      isCenter: (productList == null || productList.length == 0),
      child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child: (productList != null && productList.length == 0)
            ? NoDataScreen(
                text: 'no_services_found'.tr,
                type: NoDataType.SERVICE,
              )
            : productList != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_DEFAULT),
                    child: CustomScrollView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      slivers: [
                        if (ResponsiveHelper.isWeb())
                          SliverToBoxAdapter(
                              child: SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,
                          )),
                        SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                            mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                            childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context) ? .9 : .75,
                            crossAxisCount: ResponsiveHelper.isMobile(context)
                                ? 2
                                : ResponsiveHelper.isTab(context)
                                    ? 3
                                    : 5,
                            mainAxisExtent: 225,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              Get.find<ProductController>().getProductDiscount(productList[index]);
                              return ProductWidgetVertical(
                                product: productList[index],
                                isAvailable: true,
                                fromType: widget.fromPage,
                              );
                            },
                            childCount: productList.length,
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(
                          height: Dimensions.WEB_CATEGORY_SIZE,
                        )),
                      ],
                    ),
                  )
                : GridView.builder(
                    key: UniqueKey(),
                    padding: EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                      bottom: Dimensions.PADDING_SIZE_DEFAULT,
                      left: Dimensions.PADDING_SIZE_DEFAULT,
                      right: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                      mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                      childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context) ? 1 : .70,
                      crossAxisCount: ResponsiveHelper.isMobile(context)
                          ? 2
                          : ResponsiveHelper.isTab(context)
                              ? 3
                              : 5,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ServiceShimmer(isEnabled: true, hasDivider: false);
                    },
                  ),
      ),
    );
  }
}
