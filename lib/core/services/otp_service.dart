import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class OtpService with ReactiveServiceMixin {
  RxValue<String?> _otpVerificationId = RxValue<String?>(null);
  RxValue<bool> _showLoading = RxValue<bool>(false);

  OtpService() {
    listenToReactiveValues([_showLoading]);
  }

  String? get otpVerificationId => _otpVerificationId.value;
  bool get showLoading => _showLoading.value;

  set setOtpVerificationId(String? verificationId){
    _otpVerificationId.value = verificationId;
    notifyListeners();
  }

  set showLoadingIndicator(bool showLoading){
    _showLoading.value = showLoading;
    notifyListeners();
  }
}