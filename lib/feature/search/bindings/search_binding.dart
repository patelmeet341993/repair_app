import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(() => SearchController(
        searchRepo:
            SearchRepo(apiClient: Get.find(), sharedPreferences: Get.find())));
  }
}
