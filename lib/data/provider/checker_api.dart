import 'package:get/get.dart';
import 'package:repair/components/custom_snackbar.dart';
import 'package:repair/core/helper/route_helper.dart';
import 'package:repair/feature/auth/controller/auth_controller.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      if (Get.currentRoute != RouteHelper.getSignInRoute('splash')) {
        Get.offAllNamed(RouteHelper.getSignInRoute('splash'));
      }
    } else {
      customSnackBar("${response.statusCode!}".tr);
    }
  }
}
