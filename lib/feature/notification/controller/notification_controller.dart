import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/notification/repository/notification_repo.dart';

class NotificationController extends GetxController implements GetxService {
  bool _isLoading = false;

  final NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});

  NotificationModel? _notificationModel;
  NotificationModel? get notificationModel => _notificationModel;
  List<String> dateList = [];
  List allNotificationList = [];
  List<dynamic> notificationList = [];
  bool get isLoading => _isLoading;
  int _pageSize = 1;
  int _offset = 1;
  int get offset => _offset;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (_offset < _pageSize) {
          getNotifications(_offset + 1, reload: false);
        } else {
          print("end of the page");
        }
      }
    });
  }

  Future<void> getNotifications(int offset, {bool reload = true}) async {
    _offset = offset;
    if (reload) {
      allNotificationList = [];
      notificationList = [];
      dateList = [];
    }
    _isLoading = true;
    Response response = await notificationRepo.getNotificationList(offset);
    if (response.statusCode == 200) {
      _notificationModel = NotificationModel.fromJson(response.body);
      _pageSize = response.body['content']['last_page'];
      notificationModel!.content!.data!.forEach((data) {
        if (!dateList.contains(DateConverter.dateStringMonthYear(
            DateTime.tryParse(data.createdAt!)))) {
          dateList.add(DateConverter.dateStringMonthYear(
              DateTime.tryParse(data.createdAt!)));
        }
      });

      notificationModel!.content!.data!.forEach((data) {
        allNotificationList.add(data);
      });

      for (int i = 0; i < dateList.length; i++) {
        notificationList.add([]);
        allNotificationList.forEach((element) {
          if (dateList[i] ==
              DateConverter.dateStringMonthYear(
                  DateTime.tryParse(element.createdAt!))) {
            notificationList[i].add(element);
          }
        });
      }
      _isLoading = false;
    } else {
      _isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }
}
