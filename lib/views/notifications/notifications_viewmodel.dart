import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../core/services/utility_storage_service.dart';

class NotificationsViewModel extends ReactiveViewModel {

  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  bool isLoading = false;

  List<Map<String, Object>>? notifications = [
    {
      "id": 1,
      "image": "assets/images/notification1.png",
      "title": "New Message",
      "subtitle": "Hello, is this product still available?",
    },
    {
      "id": 2,
      "image": "assets/images/notification2.png",
      "title": "Offer",
      "subtitle": "Can i get this for N30,000",
    },
    {
      "id": 3,
      "image": "assets/images/notification3.png",
      "title": "Approval",
      "subtitle": "your ad has been approved",
    },
    {
      "id": 4,
      "image": "assets/images/notification1.png",
      "title": "New Message",
      "subtitle": "Hello, is this product still available?",
    },{
      "id":5,
      "image": "assets/images/notification2.png",
      "title": "Offer",
      "subtitle": "Can i get this for N30,000",
    },
    {
      "id":6,
      "image": "assets/images/notification3.png",
      "title": "Approval",
      "subtitle": "your ad has been approved",
    },
  ];

  void setup(BuildContext context) async {
  }

  void clearNotifications(){
    notifications?.clear();
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
