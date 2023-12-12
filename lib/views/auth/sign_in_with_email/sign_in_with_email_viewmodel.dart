import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:megadey_mobile/views/auth/signup/verify_otp/verify_otp_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:the_apple_sign_in/scope.dart';
import '../../../../app/locator.dart';
import '../../../core/services/profile_service.dart';
import '../../../core/services/signup_service.dart';
import '../../../core/services/video_player_service.dart';
import '../../../core/utilities/functions/firebase_auth_methods.dart';
import '../../dashboard/dashboard_view.dart';
import '../forgot_password/forgot_password_view.dart';
import '../signup/signup_view.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:megadey_mobile/core/models/profile_model.dart';
import '../../../api/apis.dart';
import '../../../core/constants/strings.dart';
import '../../../core/enums/toast_type.dart';
import '../../../core/services/utility_storage_service.dart';
import '../../../core/utilities/functions/debug_print.dart';
import '../../../core/utilities/functions/toast.dart';
import '../signup/verify_otp/verify_otp_viewmodel.dart';

class SignInWithEmailViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final ProfileService _profileService = locator<ProfileService>();
  final SignupService _signupService = locator<SignupService>();


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  int? currentTextFieldIndex;

  bool showPassword = true;

  final GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  //email validation
  final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  void setup(BuildContext context) async {}

  Future<void> loginWithMail(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http
          .post(Uri.parse(Apis.baseUrl + Apis.login), headers: {
        "Accept": "application/json",
      },
          body: {
            "email":emailController.text.trim(),
            "password": passwordController.text.trim()
          }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        StorageService().addString('token',jsonDecode(response.body)['data']['token']);
        dPrint('login successful:::');
        fetchProfile(context);
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        showToast(context: context, message: message ?? AppStrings.unknownError, messageType: ToastMessageType.error);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      showToast(context: context, message: AppStrings.internetError, messageType: ToastMessageType.error);
    }  catch (e) {
      isLoading = false;
      notifyListeners();
      showToast(context: context, message: AppStrings.unknownError, messageType: ToastMessageType.error);
      dPrint("Error received during login: ${e.toString()}");
    }
  }

  Future<void> fetchProfile(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http
          .get(Uri.parse(Apis.baseUrl + Apis.profile), headers: {
        "Accept": "application/json",
        "Authorization" : 'Bearer ${StorageService().getString('token')}'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        Profile? temp =  Profile.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
        _profileService.setProfileDetails = temp.data;
        StorageService().addString('userProfile',jsonEncode(temp.data));
        isLoading = false;
        notifyListeners();
        dPrint('profile fetched:::');
        if(temp.data?.isEmailVerified == false){
          SignupOtpViewModel.fromLogin = true;
          NavigationService().navigateTo(SignupOtpView.routeName);
          showToast(context: context, message: 'Verify your email address to continue!', messageType: ToastMessageType.info);
        }else {
          StorageService().addBool('isLoggedIn',true);
          NavigationService().clearStackAndShow(DashboardView.routeName);
          showToast(context: context, message: 'Login successful!', messageType: ToastMessageType.success);
        }
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        showToast(context: context, message: message ?? AppStrings.unknownError, messageType: ToastMessageType.error);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      showToast(context: context, message: AppStrings.internetError, messageType: ToastMessageType.error);
    }  catch (e) {
      isLoading = false;
      notifyListeners();
      showToast(context: context, message: AppStrings.unknownError, messageType: ToastMessageType.error);
      dPrint("Error received when fetching profile: ${e.toString()}");
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignupView.routeName);
  }

  void navigateToDashBoard() {
    _navigationService.clearStackAndShow(DashboardView.routeName);
  }


  void navigateToForgotPasswordView() {
    _navigationService.navigateTo(ForgotPasswordView.routeName);
  }

  void signinWithGoogle(BuildContext context) async {
    FirebaseAuthMethods(FirebaseAuth.instance).signupWithGoogle(context: context);
    notifyListeners();
  }

  void signInWithApple(BuildContext context) async {
    FirebaseAuthMethods(FirebaseAuth.instance).signupWithApple(context: context,scopes: [Scope.fullName]);
    notifyListeners();
  }

  void signInWithFacebook(BuildContext context) async{
    FirebaseAuthMethods(FirebaseAuth.instance).signupWithFacebook(context: context);
    notifyListeners();
  }


  @override
  List<ListenableServiceMixin> get listenableServices => [_signupService];
}
