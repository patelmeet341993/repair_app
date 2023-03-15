import 'package:repair/components/footer_base_view.dart';
import 'package:repair/components/menu_drawer.dart';
import 'package:repair/components/web_shadow_wrap.dart';
import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  @override
  void initState() {
    Get.find<AuthController>().contactNumberController.clear();
    Get.find<AuthController>().emailIdController.clear();
    super.initState();
  }

  static const passResetOption = <String>["Mobile Number", "Email ID"];

  String selectedOptionValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: ResponsiveHelper.isDesktop(context) ? MenuDrawer() : null,
      appBar: CustomAppBar(title: 'forgot_password'.tr),
      body: SafeArea(
        child: GetBuilder<AuthController>(
          builder: (authController) {
            return FooterBaseView(
              isCenter: true,
              child: WebShadowWrap(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.isDesktop(context)
                          ? Dimensions.WEB_MAX_WIDTH / 6
                          : ResponsiveHelper.isTab(context)
                              ? Dimensions.WEB_MAX_WIDTH / 8
                              : 0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_LARGE),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Images.forgotPass,
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(
                            height: Dimensions.PADDING_SIZE_LARGE,
                          ),
                          Column(
                            children: passResetOption.map(
                              (value) {
                                return RadioListTile(
                                    value: value,
                                    groupValue: selectedOptionValue,
                                    title: Text(value),
                                    onChanged: (val) {
                                      setState(() {
                                        this.selectedOptionValue = value!;
                                        print(selectedOptionValue);
                                      });
                                    });
                              },
                            ).toList(),
                          ),
                          if (selectedOptionValue == 'Mobile Number') ...[
                            Row(
                              children: [
                                CodePickerWidget(
                                  onChanged: (CountryCode countryCode) =>
                                      authController.countryDialCode =
                                          countryCode.dialCode!,
                                  initialSelection:
                                      authController.countryDialCode,
                                  favorite: [authController.countryDialCode],
                                  showDropDownButton: true,
                                  padding: EdgeInsets.zero,
                                  showFlagMain: true,
                                  dialogBackgroundColor:
                                      Theme.of(context).cardColor,
                                  barrierColor: Get.isDarkMode
                                      ? Colors.black.withOpacity(0.4)
                                      : null,
                                  textStyle: ubuntuRegular.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                  ),
                                ),
                                Expanded(
                                  child: CustomTextField(
                                      hintText: 'enter_phone_number'.tr,
                                      controller: authController
                                          .contactNumberController,
                                      inputType: TextInputType.phone,
                                      countryDialCode: authController
                                          .countryDialCode,
                                      onCountryChanged:
                                          (CountryCode countryCode) =>
                                              authController.countryDialCode =
                                                  countryCode.dialCode!,
                                      onValidate: (String? value) {
                                        return FormValidation()
                                            .isValidLength(value!);
                                      }),
                                ),
                              ],
                            ),
                          ] else if (selectedOptionValue == 'Email ID') ...[
                            CustomTextField(
                              title: 'Email ID'.tr,
                              controller: authController.emailIdController,
                              focusNode: _emailFocus,
                              inputType: TextInputType.emailAddress,
                              onValidate: (String? value) {
                                return (GetUtils.isEmail(value!))
                                    ? null
                                    : 'enter_valid_email_id'.tr;
                              },
                            ),
                          ],
                          // SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                          // Center(child: Text('OR'.tr, style: ubuntuRegular.copyWith(
                          //     color:  Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                          //     fontSize: Dimensions.fontSizeSmall))),
                          // SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                          GetBuilder<AuthController>(builder: (authController) {
                            return !authController.isLoading!
                                ? CustomButton(
                                    buttonText: 'send_otp'.tr,
                                    onPressed: () => _forgetPass(),
                                  )
                                : Center(child: CircularProgressIndicator());
                          }),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE * 4),
                        ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _forgetPass() async {
    if (Get.find<AuthController>()
        .contactNumberController
        .value
        .text
        .isNotEmpty) {
      Get.find<AuthController>().forgetPassword();
    } else {
      customSnackBar('enter_phone_number'.tr);
    }
  }
}
