import 'package:flutter/material.dart';
import 'package:megadey_mobile/core/utilities/functions/toast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/locator.dart';
import '../../../core/enums/toast_type.dart';
import '../sign_in_with_email/sign_in_with_email_view.dart';

class ForgotPasswordViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;
  int? currentTextFieldIndex;
  bool showPassword = true;
  bool showConfirmPassword = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //email validation
  final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  int currentPage = 1;

  void setup(BuildContext context) async {}

  Future<void> resetPassword(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () async {
      isLoading = false;
      currentPage = 2;
      notifyListeners();
    });

    // try {
    //   isLoading = true;
    //   notifyListeners();
    //
    //   Map<String, dynamic> encoded = {
    //     "email": emailController.text.trim(),
    //     "password": passwordController.text.trim(),
    //   };
    //
    //   var response = await http.post(Uri.parse(Apis.baseUrl + Apis.login),
    //       headers: {
    //         "Accept": "application/json",
    //       },
    //       body: encoded)
    //       .timeout(const Duration(seconds: 60));
    //
    //   dPrint('statusCode::: ${response.statusCode}');
    //   dPrint('response::: ${response.body}');
    //
    //   bool success = jsonDecode(response.body)['status'] ?? false;
    //   String? message = jsonDecode(response.body)['message'];
    //
    //   //success
    //   if ((response.statusCode == 200 || response.statusCode == 201) && success) {
    //     String token = json.decode(response.body)['data']['token'];
    //     _storageService.addString('token', token);
    //     _storageService.removeString('currentCourseIndex');
    //     ProfileModel temp = ProfileModel.fromJson(json.decode(response.body) as Map<String, dynamic>);
    //     locator<StorageService>().addString('ProfileDetails', jsonEncode(temp.data?.student));
    //     _profileService.setProfileDetails = temp.data?.student;
    //     isLoading = false;
    //     notifyListeners();
    //     dPrint('logged in successfully:::');
    //     if(_profileService.profileDetails?.verified != null){
    //       if(_profileService.profileDetails!.verified!){
    //         if(setRememberMe) _storageService.addBool('isLoggedIn', true);
    //         _navigationService.clearStackAndShow(DashboardView.routeName);
    //       }else {
    //         //user not verified
    //         VerifyOtpViewModel.email = emailController.text.trim();
    //         VerifyOtpViewModel.token = token;
    //         VerifyOtpViewModel.notSignUp = true;
    //         _navigationService.navigateTo(VerifyOtpView.routeName);
    //         showToast(context: context, message:  'Verify account to continue', type: ToastMessageType.info);
    //
    //       }}else{
    //       showToast(context: context, message:  AppStrings.unknownError, type: ToastMessageType.error);
    //     }
    //   }
    //   //failure
    //   else {
    //     isLoading = false;
    //     notifyListeners();
    //     showToast(context: context, message: json.decode(response.body)['data']['errors']['email'] ?? AppStrings.unknownError, type: ToastMessageType.error);
    //     dPrint('error ${response.body}');
    //   }
    // } on SocketException {
    //   isLoading = false;
    //   notifyListeners();
    //   showToast(context: context, message:  AppStrings.internetError, type: ToastMessageType.error);
    // } on HttpException {
    //   isLoading = false;
    //   notifyListeners();
    //   showToast(context: context, message:  AppStrings.resourceError, type: ToastMessageType.error);
    // } on FormatException {
    //   isLoading = false;
    //   notifyListeners();
    //   showToast(context: context, message:  AppStrings.formatError, type: ToastMessageType.error);
    // } catch (e) {
    //   isLoading = false;
    //   notifyListeners();
    //   showToast(context: context, message:  AppStrings.unknownError, type: ToastMessageType.error);
    //   dPrint("Error received when logging in: ${e.toString()}");
    // }
  }

  Future<void> setNewPassword(BuildContext context) async{
    isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () async {
      navigateToSignIn();
    });
    Future.delayed(const Duration(seconds: 3), () async {
      isLoading = false;
      notifyListeners();
      showToast(context: context, message: 'Password reset successful. \nLogin to continue.', messageType: ToastMessageType.success);
    });
  }

  void openMailApp(){
    isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () async {
      isLoading = false;
      currentPage = 3;
      notifyListeners();
    });
  }

  void navigateToSignIn() {
    _navigationService.replaceWith(SignInWithEmailView.routeName);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
