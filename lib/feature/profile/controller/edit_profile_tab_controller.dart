import 'package:country_code_picker/country_code_picker.dart';
import 'package:repair/core/helper/image_size_checker.dart';
import 'package:get/get.dart';
import 'package:repair/core/core_export.dart';

enum EditProfileTabControllerState { generalInfo, accountIno }

class EditProfileTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final UserRepo userRepo;
  EditProfileTabController({required this.userRepo});

  bool _isLoading = false;
  get isLoading => _isLoading;

  XFile? _pickedProfileImageFile;
  XFile? get pickedProfileImageFile => _pickedProfileImageFile;

  List<Widget> editProfileDetailsTabs = [
    Tab(text: 'general_info'.tr),
    Tab(text: 'account_information'.tr),
  ];

  TabController? controller;
  var editProfilePageCurrentState = EditProfileTabControllerState.generalInfo;

  void updateEditProfilePage(
      EditProfileTabControllerState editProfileTabControllerState, index) {
    editProfilePageCurrentState = editProfileTabControllerState;
    print(editProfileTabControllerState);
    controller!.animateTo(index);
    update();
  }

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var countryDialCode;
  UserInfoModel _userInfoModel = UserInfoModel();
  UserInfoModel get userInfoModel => _userInfoModel;

  @override
  void onInit() {
    super.onInit();
    controller =
        TabController(vsync: this, length: editProfileDetailsTabs.length);
    _userInfoModel = Get.find<UserController>().userInfoModel;
    firstNameController.text = _userInfoModel.fName!;
    lastNameController.text = _userInfoModel.lName!;
    emailController.text = _userInfoModel.email!;
    countryDialCode = CountryCode.fromCountryCode(
            Get.find<SplashController>().configModel.content != null
                ? Get.find<SplashController>().configModel.content!.countryCode!
                : "BD")
        .dialCode;
    phoneController.text = _userInfoModel.phone != null
        ? _userInfoModel.phone!.replaceAll(countryDialCode, '')
        : '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }

  Future<void> updateUserProfile() async {
    if (_userInfoModel.fName != firstNameController.text ||
        _userInfoModel.lName != lastNameController.text ||
        _pickedProfileImageFile != null ||
        _userInfoModel.phone != phoneController.value.text) {
      UserInfoModel userInfoModel = UserInfoModel(
          fName: firstNameController.value.text,
          lName: lastNameController.value.text,
          email: emailController.value.text,
          phone: '${phoneController.value.text}');

      _isLoading = true;
      update();
      Response response = await userRepo.updateProfile(userInfoModel,
          pickedProfileImageFile != null ? pickedProfileImageFile : null);

      if (response.body['response_code'] == 'default_update_200') {
        Get.back();
        customSnackBar('${response.body['response_code']}'.tr, isError: false);
        _isLoading = false;
      } else {
        customSnackBar('${response.body['errors'][0]['message']}'.tr,
            isError: true);
        _isLoading = false;
      }
      update();
      Get.find<UserController>().getUserInfo();
    } else {
      customSnackBar('change_something_to_update'.tr, isError: false);
    }
  }

  Future<void> updateAccountInfo() async {
    UserInfoModel userInfoModel = UserInfoModel(
        fName: firstNameController.value.text,
        lName: lastNameController.value.text,
        email: emailController.value.text,
        phone: phoneController.value.text,
        password: passwordController.value.text,
        confirmPassword: confirmPasswordController.value.text);

    _isLoading = true;
    update();
    Response response = await userRepo.updateAccountInfo(userInfoModel);
    print(response.body);
    if (response.body['response_code'] == 'default_update_200') {
      Get.back();
      customSnackBar('password_updated_successfully'.tr, isError: false);
    } else {
      customSnackBar(response.body['message']);
    }
    _isLoading = false;
    update();
  }

  void pickProfileImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile pickedImage = (await _picker.pickImage(source: ImageSource.gallery))!;
    double _imageSize = await ImageSize.getImageSize(pickedImage);

    if (_imageSize > AppConstants.limitOfPickedImageSizeInMB) {
      customSnackBar("image_size_greater_than".tr);
    } else {
      _pickedProfileImageFile =
          await _picker.pickImage(source: ImageSource.gallery);
      update();
    }
  }

  Future<void> removeProfileImage() async {
    _pickedProfileImageFile = null;
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }

  validatePassword(String value) {
    if (value.length < 8) {
      return 'password_should_be'.tr;
    } else if (passwordController.text != confirmPasswordController.text &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      return 'confirm_password_does_not_matched'.tr;
    }
  }
}
