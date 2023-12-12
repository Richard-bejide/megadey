import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../core/services/utility_storage_service.dart';
import '../dashboard/dashboard_view.dart';

class SettingsViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();


  void setup(BuildContext context) async {}

  void logout() {
    StorageService().removeBool('isLoggedIn');
    StorageService().removeString('token');
    //clear user details
    _navigationService.clearStackAndShow(DashboardView.routeName);
  }


  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
