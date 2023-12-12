import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:megadey_mobile/core/models/profile_model.dart';
import 'package:megadey_mobile/core/services/profile_service.dart';
import 'package:megadey_mobile/views/auth/signup/verify_otp/verify_otp_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:the_apple_sign_in/scope.dart';
import '../../../api/apis.dart';
import '../../../app/locator.dart';
import '../../../core/constants/strings.dart';
import '../../../core/enums/toast_type.dart';
import '../../../core/services/signup_service.dart';
import '../../../core/services/utility_storage_service.dart';
import '../../../core/services/video_player_service.dart';
import '../../../core/utilities/functions/debug_print.dart';
import '../../../core/utilities/functions/firebase_auth_methods.dart';
import '../../../core/utilities/functions/toast.dart';
import '../../dashboard/dashboard_view.dart';

class SignUpViewModel extends ReactiveViewModel {

  final ProfileService _profileService = locator<ProfileService>();
  final SignupService _signupService = locator<SignupService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;
  final GlobalKey<FormState> signupKey = GlobalKey<FormState>();

  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final RegExp nameRegex = RegExp(
      r"^[\p{L} ,.'-]*$", caseSensitive: false, unicode: true, dotAll: true);
  final RegExp numberRegex = RegExp(r'^[0-9]+$');

  int? currentTextFieldIndex;

  bool showPassword = true;
  bool showConfirmPassword = true;

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  String? phoneNumber;

  void setup(BuildContext context) async {}

  Future<void> createAccount(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http.post(Uri.parse(Apis.baseUrl + Apis.register),
          headers: {"Accept": "application/json",},
          body: {
            "firstname": firstNameController.text.trim(),
            "lastname": lastNameController.text.trim(),
            "email": emailController.text.trim(),
            "phone": phoneController.text.trim(),
            "password": confirmPasswordController.text.trim()
          }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        StorageService().addString('token', jsonDecode(response.body)['data']['token']);
        dPrint('registered successfully:::');
        fetchProfile(context);
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        showToast(context: context,
            message: message ?? AppStrings.unknownError,
            messageType: ToastMessageType.error);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      showToast(
          context: context, message: AppStrings.internetError, messageType: ToastMessageType.error);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showToast(
          context: context, message: AppStrings.unknownError, messageType: ToastMessageType.error);
      dPrint("Error received during registration: ${e.toString()}");
    }
  }

  Future<void> fetchProfile(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http
          .get(Uri.parse(Apis.baseUrl + Apis.profile), headers: {
        "Accept": "application/json",
        "Authorization": 'Bearer ${StorageService().getString('token')}'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        Profile? temp = Profile.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        _profileService.setProfileDetails = temp.data;
        StorageService().addString('userProfile', jsonEncode(temp.data));
        isLoading = false;
        notifyListeners();
        dPrint('profile fetched:::');
        NavigationService().navigateTo(SignupOtpView.routeName);
        showToast(context: context,
            message: 'Your account has been created successfully! \nVerify your email address to continue',
            messageType: ToastMessageType.success);
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        showToast(context: context,
            message: message ?? AppStrings.unknownError,
            messageType: ToastMessageType.error);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      showToast(
          context: context, message: AppStrings.internetError, messageType: ToastMessageType.error);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showToast(
          context: context, message: AppStrings.unknownError, messageType: ToastMessageType.error);
      dPrint("Error received when fetching profile: ${e.toString()}");
    }
  }

  void signUpWithGoogle(BuildContext context) async {
    FirebaseAuthMethods(FirebaseAuth.instance).signupWithGoogle(context: context);
    notifyListeners();
  }

  void signUpWithApple(BuildContext context) async {
    FirebaseAuthMethods(FirebaseAuth.instance).signupWithApple(
        context: context, scopes: [Scope.fullName]);
    notifyListeners();
  }

  void signUpWithFacebook(BuildContext context) async {
    FirebaseAuthMethods(FirebaseAuth.instance).signupWithFacebook(context: context);
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_signupService];
}