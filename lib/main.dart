import 'package:repair/data/provider/company_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'core/core_export.dart';
import 'core/helper/language_di.dart' as di;
import 'core/helper/notification_helper.dart';
import 'core/initial_binding/initial_binding.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (ResponsiveHelper.isMobilePhone()) {
    HttpOverrides.global = new MyHttpOverrides();
    await FlutterDownloader.initialize();
  }
  setPathUrlStrategy();
  if (GetPlatform.isWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: "AIzaSyBx9Lz3VEGlUpltveMgUsShtCwWn1zi5lQ",
      appId: "1:70934877475:web:c482a19a2c2fe3760e2896",
      messagingSenderId: '70934877475',
      projectId: 'demandium-16b0f',
      storageBucket: "demandium-16b0f.appspot.com",
    ));
    await FacebookAuth.instance.webAndDesktopInitialize(
      appId: "637072917840079",
      cookie: true,
      xfbml: true,
      version: "v13.0",
    );
  } else {
    await Firebase.initializeApp();
  }

  Map<String, Map<String, String>> _languages = await di.init();
  String? _bookingID;
  try {
    final RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      _bookingID = remoteMessage.data['booking_id'] != null
          ? remoteMessage.data['booking_id']
          : null;
    }
    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  } catch (e) {}
  runApp(MyApp(
      languages: _languages,
      bookingID: _bookingID != null ? _bookingID : null));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;
  final String? bookingID;

  MyApp({@required this.languages, @required this.bookingID});

  void _route() {
    Get.find<SplashController>().getConfigData().then((bool isSuccess) async {
      if (isSuccess) {
        if (Get.find<AuthController>().isLoggedIn()) {
          Get.find<AuthController>().updateToken();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isWeb) {
      Get.find<SplashController>().initSharedData();
      if (Get.find<AuthController>().isLoggedIn()) {
        Get.find<UserController>().getUserInfo();
        Get.find<CartController>().getCartListFromServer();
      } else {
        Get.find<CartController>().getCartData();
      }
      _route();
    }

    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<SplashController>(builder: (splashController) {
          return (GetPlatform.isWeb &&
                  splashController.configModel.content == null)
              ? SizedBox()
              : MultiProvider(
                providers: [
                  ChangeNotifierProvider<CompanyProvider>(create: (_) => CompanyProvider(),),
                ],
                child: GetMaterialApp(
                    title: AppConstants.APP_NAME,
                    debugShowCheckedModeBanner: false,
                    navigatorKey: Get.key,
                    scrollBehavior: MaterialScrollBehavior().copyWith(
                      dragDevices: {
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.touch
                      },
                    ),
                    initialBinding: InitialBinding(),
                    theme: themeController.darkTheme ? dark : light,
                    locale: localizeController.locale,
                    translations: Messages(languages: languages),
                    fallbackLocale: Locale(
                        AppConstants.languages[0].languageCode!,
                        AppConstants.languages[0].countryCode),
                    initialRoute: GetPlatform.isWeb
                        ? RouteHelper.getInitialRoute()
                        : RouteHelper.getSplashRoute(bookingID),
                    getPages: RouteHelper.routes,
                    defaultTransition: Transition.topLevel,
                    transitionDuration: Duration(milliseconds: 500),
                  ),
              );
        });
      });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
