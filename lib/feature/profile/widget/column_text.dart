import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';

class ColumnText extends StatelessWidget {
  final String accountAgo;
  final bool isProfileTimeAgo;
  final num amount;
  final String title;
  ColumnText(
      {Key? key,
      required this.title,
      required this.amount,
      this.accountAgo = '',
      this.isProfileTimeAgo = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveHelper.isDesktop(context)
          ? Dimensions.WEB_MAX_WIDTH * .40
          : Get.width * .40,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isProfileTimeAgo
                  ? accountAgo
                      .replaceAll('days ago', 'days_ago'.tr)
                      .replaceAll('a day ago', 'a_day_ago'.tr)
                      .replaceAll('a moment ago', 'a_moment_ago'.tr)
                      .replaceAll('a minute ago', 'a_minute_ago'.tr)
                      .replaceAll('minutes ago', 'minutes_ago'.tr)
                      .replaceAll('about a month ago', 'about_a_month_ago'.tr)
                      .replaceAll('about an hour ago', 'about_an_hour_ago'.tr)
                      .replaceAll('hours ago', 'hours_ago'.tr)
                  : amount.toString(),
              style: ubuntuBold.copyWith(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(
              height: Dimensions.PADDING_SIZE_SMALL,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: ubuntuMedium.copyWith(
                fontSize: 12,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
