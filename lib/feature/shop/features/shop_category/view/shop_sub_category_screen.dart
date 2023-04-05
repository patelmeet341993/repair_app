import 'package:repair/components/footer_base_view.dart';
import 'package:repair/components/menu_drawer.dart';
import 'package:repair/core/core_export.dart';
import 'package:get/get.dart';
import 'package:repair/feature/shop/features/shop_category/controller/shop_category_controller.dart';
import 'package:repair/feature/shop/features/shop_category/view/shop_subcategory_view.dart';

class ShopSubCategoryScreen extends StatefulWidget {
  final String categoryTitle;
  final String categoryID;
  final int subCategoryIndex;
  const ShopSubCategoryScreen({
    Key? key,
    required this.categoryTitle,
    required this.categoryID,
    required this.subCategoryIndex,
  }) : super(key: key);

  @override
  State<ShopSubCategoryScreen> createState() => _ShopSubCategoryScreenState();
}

class _ShopSubCategoryScreenState extends State<ShopSubCategoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: ResponsiveHelper.isDesktop(context) ? MenuDrawer() : null,
        appBar: CustomAppBar(
          title: widget.categoryTitle,
        ),
        body: GetBuilder<ShopCategoryController>(initState: (state) {
          Get.find<ShopCategoryController>().getSubCategoryList(
              widget.categoryID, widget.subCategoryIndex,
              shouldUpdate: false); //banner id is category here
        }, builder: (categoryController) {
          return FooterBaseView(
            isCenter: (categoryController.subCategoryList != null &&
                categoryController.subCategoryList!.length == 0),
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: CustomScrollView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: ResponsiveHelper.isDesktop(context)
                          ? Dimensions.PADDING_SIZE_EXTRA_LARGE
                          : 0,
                    ),
                  ),
                  ShopSubCategoryView(
                    isScrollable: true,
                  ),
                ],
              ),
            ),
          );
        }));
  }
}