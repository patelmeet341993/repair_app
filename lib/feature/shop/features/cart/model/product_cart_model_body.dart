import 'package:repair/utils/parsing_helper.dart';

class ProductCartModelBody {
  String? productId;
  String? variantKey;
  String? quantity;

  ProductCartModelBody({this.productId, this.variantKey, this.quantity,});

  ProductCartModelBody.fromJson(Map<String, dynamic> json) {
    productId = ParsingHelper.parseStringMethod(json['product_id']);
    variantKey = ParsingHelper.parseStringMethod(json['variant_id']);
    quantity = ParsingHelper.parseStringMethod(json['quantity']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['variant_id'] = this.variantKey;
    data['quantity'] = this.quantity;
    return data;
  }
}
