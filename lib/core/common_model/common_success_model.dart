import 'package:repair/data/model/response/error_response.dart';
import 'package:repair/utils/parsing_helper.dart';

import 'package:repair/utils/parsing_helper.dart';

import 'package:repair/utils/parsing_helper.dart';

import 'package:repair/utils/parsing_helper.dart';

class CommonModel {
  String responseCode = "";
  String message = "";
  dynamic content;
  List<Errors> errors = const[];

  CommonModel({this.responseCode = "", this.message = "", this.content, this.errors = const []});

  CommonModel.fromJson(Map<String, dynamic> json) {
    responseCode = ParsingHelper.parseStringMethod(json['response_code']);
    message = ParsingHelper.parseStringMethod(json['message']);
    content = json['content'];
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors.add(new Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['content'] = this.content;
    data['errors'] = this.errors.map((v) => v.toJson()).toList();
    return data;
  }
}
