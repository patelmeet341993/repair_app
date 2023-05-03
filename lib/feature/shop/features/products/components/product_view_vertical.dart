import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/features/products/components/product_widget_vertical.dart';
import '../model/product_model.dart';

class ProductViewVertical extends GetView<ServiceController> {
  final List<Product>? product;
  final EdgeInsetsGeometry? padding;
  final bool? isScrollable;
  final int? shimmerLength;
  final String? noDataText;
  final String? type;
  final NoDataType? noDataType;

  final Function(String type)? onVegFilterTap;

  ProductViewVertical(
      {required this.product,
      this.isScrollable = false,
      this.shimmerLength = 20,
      this.padding = const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      this.noDataText,
      this.type,
      this.onVegFilterTap,
      this.noDataType});

  @override
  Widget build(BuildContext context) {
    bool _isNull = true;
    int _length = 0;

    _isNull = product == null;
    if (!_isNull) {
      _length = product!.length;
    }

    return Column(mainAxisSize: MainAxisSize.min, children: [
      !_isNull
          ? _length > 0
              ? GridView.builder(
                  key: UniqueKey(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                    mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                    childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context) ? .9 : .70,
                    mainAxisExtent: ResponsiveHelper.isMobile(context) ? 230 : 260,
                    crossAxisCount: ResponsiveHelper.isMobile(context)
                        ? 2
                        : ResponsiveHelper.isTab(context)
                            ? 3
                            : 5,
                  ),
                  physics: isScrollable! ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
                  shrinkWrap: isScrollable! ? false : true,
                  itemCount: product!.length,
                  padding: padding,
                  itemBuilder: (context, index) {
                    bool _isAvailable = product![index].isActive == 0 ? false : true;
                    return ProductWidgetVertical(
                      product: product![index],
                      isAvailable: _isAvailable,
                      fromType: '',
                    );
                  },
                )
              : NoDataScreen(text: noDataText != null ? noDataText : 'no_product_found'.tr, type: noDataType)
          : GridView.builder(
              key: UniqueKey(),
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
              physics: isScrollable! ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
              shrinkWrap: isScrollable! ? false : true,
              itemCount: shimmerLength,
              padding: padding,
              itemBuilder: (context, index) {
                return ServiceShimmer(isEnabled: true, hasDivider: index != shimmerLength! - 1);
              },
            ),
    ]);
  }
}
