// import 'package:repair/components/web_shadow_wrap.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:repair/core/core_export.dart';
// import 'package:repair/feature/shop/features/products/controller/product_details_controller.dart';
// import 'package:repair/feature/shop/features/products/model/product_model.dart';
//
// import '../../../../../utils/dimensions.dart';
//
// class ProductDetailsFaqSection extends StatelessWidget {
//   const ProductDetailsFaqSection({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProductDetailsController>(
//         builder: (productDetailsController) {
//       if (!productDetailsController.isLoading) {
//         List<ProductFaqs>? faqs = [];
//         return WebShadowWrap(
//           child: Container(
//             width: Dimensions.WEB_MAX_WIDTH,
//             child: ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: faqs!.length,
//               padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
//               itemBuilder: (context, index) {
//                 return CustomExpansionTile(
//                   expandedAlignment: Alignment.centerLeft,
//                   title: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: Dimensions.PADDING_SIZE_SMALL),
//                     child: Text(
//                       faqs.elementAt(index).question!,
//                       style: ubuntuRegular.copyWith(
//                           color: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .color!
//                               .withOpacity(.6)),
//                     ),
//                   ),
//                   children: [
//                     Container(
//                       child: Padding(
//                         padding:
//                             EdgeInsets.only(left: 35, right: 35, bottom: 10),
//                         child: Text(faqs.elementAt(index).answer!,
//                             style: ubuntuRegular.copyWith(
//                                 fontSize: Dimensions.fontSizeSmall,
//                                 color: Theme.of(context)
//                                     .textTheme
//                                     .bodyText1!
//                                     .color!
//                                     .withOpacity(.6))),
//                       ),
//                     )
//                   ],
//                 );
//               },
//             ),
//           ),
//         );
//       } else {
//         return SizedBox(
//           child: Text("ok"),
//         );
//       }
//     });
//   }
// }
