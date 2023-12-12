import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';
import '../models/profile_model.dart';

class ProfileService with ListenableServiceMixin {
  final RxValue<ProfileData?> _profileDetails = RxValue<ProfileData?>(null);

  ProfileService() {
    listenToReactiveValues([_profileDetails]);
  }

  ProfileData? get profileDetails => _profileDetails.value;

  set setProfileDetails(ProfileData? val){
    _profileDetails.value = val;
   notifyListeners();
  }

  void clearProfileData(){
    _profileDetails.value = null;
  }
}