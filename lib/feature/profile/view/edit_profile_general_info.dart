import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';
import 'package:repair/feature/profile/controller/edit_profile_tab_controller.dart';

class EditProfileGeneralInfo extends StatefulWidget {
  const EditProfileGeneralInfo({Key? key}) : super(key: key);

  @override
  State<EditProfileGeneralInfo> createState() => _EditProfileGeneralInfoState();
}

class _EditProfileGeneralInfoState extends State<EditProfileGeneralInfo> {
  final GlobalKey<FormState> updateProfileKey = GlobalKey<FormState>();
  final FocusNode _firstName = FocusNode();
  final FocusNode _lastName = FocusNode();
  final FocusNode _phoneWithCountry = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileTabController>(
        builder: (editProfileTabController) {
      return Stack(
        children: [
          Scrollbar(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Form(
                  key: updateProfileKey,
                  child: Column(
                    children: [
                      _profileImageSection(),
                      CustomTextField(
                          title: 'first_name'.tr,
                          hintText: 'first_name'.tr,
                          controller: Get.find<EditProfileTabController>()
                              .firstNameController,
                          inputType: TextInputType.name,
                          focusNode: _firstName,
                          nextFocus: _lastName,
                          capitalization: TextCapitalization.words,
                          onValidate: (String? value) {
                            return FormValidation().isValidLength(value!);
                          }),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      CustomTextField(
                          title: 'last_name'.tr,
                          hintText: 'last_name'.tr,
                          focusNode: _lastName,
                          isEnabled: true,
                          nextFocus: _phoneWithCountry,
                          controller: Get.find<EditProfileTabController>()
                              .lastNameController,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          onValidate: (String? value) {
                            return FormValidation().isValidLength(value!);
                          }),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      InkWell(
                        onTap: () {
                          customSnackBar('email_is_not_editable'.tr);
                        },
                        child: Container(
                          color: Get.isDarkMode
                              ? Theme.of(context).cardColor
                              : Theme.of(context).primaryColorLight,
                          child: CustomTextField(
                              title: 'email'.tr,
                              hintText: 'email'.tr,
                              isEnabled: false,
                              controller: Get.find<EditProfileTabController>()
                                  .emailController,
                              inputType: TextInputType.name,
                              capitalization: TextCapitalization.words,
                              onValidate: (String? value) {
                                return FormValidation().isValidLength(value!);
                              }),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      CustomTextField(
                        title: 'phone'.tr,
                        hintText: 'enter_phone_number'.tr,
                        controller: Get.find<EditProfileTabController>()
                            .phoneController,
                        inputType: TextInputType.phone,
                        focusNode: _phoneWithCountry,
                        countryDialCode: Get.find<EditProfileTabController>()
                            .countryDialCode,
                        onCountryChanged: (dynamic countryCode) =>
                            Get.find<EditProfileTabController>()
                                .countryDialCode = countryCode.dialCode!,
                      ),
                      SizedBox(
                        height: context.height * 0.16,
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
            child: editProfileTabController.isLoading
                ? Center(child: CircularProgressIndicator())
                : CustomButton(
                    fontSize: Dimensions.fontSizeDefault,
                    width: Get.width,
                    radius: Dimensions.RADIUS_DEFAULT,
                    buttonText: 'update_information'.tr,
                    onPressed: () {
                      if (updateProfileKey.currentState!.validate()) {
                        Get.find<EditProfileTabController>()
                            .updateUserProfile();
                      }
                    },
                  ),
          ),
        ],
      );
    });
  }

  Widget _profileImageSection() {
    return GetBuilder<EditProfileTabController>(
        builder: (editProfileTabController) {
      return Container(
        height: 120,
        width: Get.width,
        margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(Get.context!)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.2),
                      width: 1),
                ),
                child: ClipOval(
                  child: editProfileTabController.pickedProfileImageFile == null
                      ? CustomImage(
                          placeholder: Images.placeholder,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          image: Get.find<SplashController>()
                                  .configModel
                                  .content!
                                  .imageBaseUrl! +
                              "/user/profile_image/" +
                              '${Get.find<UserController>().userInfoModel.image!}')
                      : kIsWeb
                          ? Image.network(
                              editProfileTabController
                                  .pickedProfileImageFile!.path,
                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.cover)
                          : Image.file(File(editProfileTabController
                              .pickedProfileImageFile!.path)),
                ),
              ),
              InkWell(
                child: Icon(
                  Icons.camera_enhance_rounded,
                  color: Theme.of(Get.context!).cardColor,
                ),
                onTap: () =>
                    Get.find<EditProfileTabController>().pickProfileImage(),
              )
            ],
          ),
        ),
      );
    });
  }
}
