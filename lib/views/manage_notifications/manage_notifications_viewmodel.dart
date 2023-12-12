import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../core/services/utility_storage_service.dart';

class ManageNotificationsViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();


  bool hotDeals = true;
  bool adsInfo = false;
  bool sub = false;
  bool yourSubs = false;
  bool messages = true;
  bool feedback = false;
  bool sms = false;
  bool webNotification = true;


  void setup(BuildContext context) async {}

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
