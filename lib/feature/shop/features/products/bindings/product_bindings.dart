import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);
    Get.lazyPut(() => ServiceController(
        serviceRepo: ServiceRepo(
            apiClient: ApiClient(
                appBaseUrl: AppConstants.BASE_URL,
                sharedPreferences: sharedPreferences))));
  }
}
