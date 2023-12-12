import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;
import '../../../../api/apis.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/enums/toast_type.dart';
import '../../../../core/services/utility_storage_service.dart';
import '../../../../core/utilities/functions/debug_print.dart';
import '../../../../core/utilities/functions/toast.dart';
import '../../../dashboard/dashboard_view.dart';

class SignupOtpViewModel extends ReactiveViewModel {

  bool isLoading = false;
  bool isResendingOtp = false;
  bool enabled = false;

  TextEditingController otpController = TextEditingController();

  static String? email;

  static bool fromLogin = false;

  void setup(BuildContext context) async {
    if(fromLogin){resendOtp(context);}
  }

  Future<void> verifyOtp(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http
          .get(Uri.parse(Apis.baseUrl + Apis.verifyOtp +'/'+otpController.text), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": 'Bearer ${StorageService().getString('token')}'
          }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        StorageService().addBool('isLoggedIn', true);
        isLoading = false;
        notifyListeners();
        dPrint('email verified Successfully:::');
        NavigationService().clearStackAndShow(DashboardView.routeName);
      }
      //failure
      else {
        otpController.clear();
        isLoading = false;
        notifyListeners();
        showToast(
            context: context,
            message: json.decode(response.body)['message'] ?? AppStrings.unknownError,
            messageType: ToastMessageType.error);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      otpController.clear();
      isLoading = false;
      notifyListeners();
      showToast(context: context, message: AppStrings.internetError, messageType: ToastMessageType.error);
    } catch (e) {
      otpController.clear();
      isLoading = false;
      notifyListeners();
      showToast(context: context, message: AppStrings.unknownError, messageType: ToastMessageType.error);
      dPrint("Error received when verifying otp: ${e.toString()}");
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    try {
      isResendingOtp = true;
      notifyListeners();

      var response = await http.get(Uri.parse(Apis.baseUrl + Apis.resendOtp), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": 'Bearer ${StorageService().getString('token')}'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        otpController.clear();
        isResendingOtp = false;
        notifyListeners();
        dPrint('otp resent successfully:::');
        showToast(context: context, message: 'OTP has been resent to your email', messageType: ToastMessageType.success);
      }
      //failure
      else {
        isResendingOtp = false;
        notifyListeners();
        showToast(
            context: context,
            message: json.decode(response.body)['message'] ?? AppStrings.unknownError,
            messageType: ToastMessageType.error);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isResendingOtp = false;
      notifyListeners();
      showToast(
          context: context, message: AppStrings.internetError, messageType: ToastMessageType.error);
    }catch (e) {
      isResendingOtp = false;
      notifyListeners();
      showToast(
          context: context, message: AppStrings.unknownError, messageType: ToastMessageType.error);
      dPrint("Error received when resending otp: ${e.toString()}");
    }
  }


  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
