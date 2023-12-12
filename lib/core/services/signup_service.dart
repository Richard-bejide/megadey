import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class SignupService with ListenableServiceMixin {
  RxValue<bool> _showLoadingFacebook = RxValue<bool>(false);
  RxValue<bool> _showLoadingGoogle = RxValue<bool>(false);
  RxValue<bool> _showLoadingApple = RxValue<bool>(false);


  SignupService() {
    listenToReactiveValues([_showLoadingFacebook,_showLoadingGoogle,_showLoadingApple]);
  }

  bool get showLoadingFacebook => _showLoadingFacebook.value;
  bool get showLoadingGoogle => _showLoadingGoogle.value;
  bool get showLoadingApple => _showLoadingApple.value;

  set setLoadingIndicatorForFacebook(bool showLoading){
    _showLoadingFacebook.value = showLoading;
    notifyListeners();
  }

  set setLoadingIndicatorForApple(bool showLoading){
    _showLoadingApple.value = showLoading;
    notifyListeners();
  }

  set setLoadingIndicatorForGoogle(bool showLoading){
    _showLoadingGoogle.value = showLoading;
    notifyListeners();
  }
}