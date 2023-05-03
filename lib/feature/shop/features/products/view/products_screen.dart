import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:repair/components/address_app_bar.dart';
import 'package:repair/feature/shop/features/products/controller/product_controller.dart';

import '../../../../../utils/dimensions.dart';
import '../../../componants/product_view.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddressAppBar(),
      body: SingleChildScrollView(
        child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(children: [
          ProductView(product: Get.find<ProductController>().popularProductList!),
        ]))),
      ),
    );
  }
}
