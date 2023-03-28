import 'package:repair/utils/parsing_helper.dart';

class CartModelBody {
  String? serviceId;
  String? categoryId;
  String? variantKey;
  String? quantity;
  String? subCategoryId;
  String providerSelectedIds = "";

  CartModelBody({this.serviceId, this.categoryId, this.variantKey, this.quantity, this.subCategoryId, this.providerSelectedIds = ""});

  CartModelBody.fromJson(Map<String, dynamic> json) {
    serviceId = ParsingHelper.parseStringMethod(json['service_id']);
    categoryId = ParsingHelper.parseStringMethod(json['category_id']);
    variantKey = ParsingHelper.parseStringMethod(json['variant_key']);
    quantity = ParsingHelper.parseStringMethod(json['quantity']);
    subCategoryId = ParsingHelper.parseStringMethod(json['sub_category_id']);
    providerSelectedIds = ParsingHelper.parseStringMethod(json['provider_selected_ids']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['category_id'] = this.categoryId;
    data['variant_key'] = this.variantKey;
    data['quantity'] = this.quantity;
    data['sub_category_id'] = this.subCategoryId;
    data['provider_selected_ids'] = this.providerSelectedIds;
    return data;
  }
}
