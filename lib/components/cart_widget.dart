import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/shop/features/cart/controller/product_cart_controller.dart';

class CartWidget extends GetView<CartController> {
  final Color color;
  final double size;
  final bool fromRestaurant;

  CartWidget({required this.color, required this.size, this.fromRestaurant = false,});

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Image.asset(Images.cart, width: size, height: size, color: color),
      Get.find<BottomNavController>().currentPage.value == BnbItem.Shop
          ? GetBuilder<ProductCartController>(builder: (productCartController) {
              return productCartController.cartList.length > 0
                  ? Positioned(
                      top: -5,
                      right: -5,
                      child: Container(
                        height: size < 20 ? 10 : size / 2,
                        width: size < 20 ? 10 : size / 2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Text(
                          productCartController.cartList.length.toString(),
                          style: ubuntuRegular.copyWith(
                            fontSize: size < 20 ? size / 3 : size / 3.8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox();
            })
          : GetBuilder<CartController>(builder: (cartController) {
              return cartController.cartList.length > 0
                  ? Positioned(
                      top: -5,
                      right: -5,
                      child: Container(
                        height: size < 20 ? 10 : size / 2,
                        width: size < 20 ? 10 : size / 2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Text(
                          cartController.cartList.length.toString(),
                          style: ubuntuRegular.copyWith(
                            fontSize: size < 20 ? size / 3 : size / 3.8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox();
            }),
    ]);
  }
}
