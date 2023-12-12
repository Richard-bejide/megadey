import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../core/services/utility_storage_service.dart';

class MyAdsViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  bool isLoading = false;

  int currentTab = 0;

  List<Map<String, dynamic>?>? activeAds = [
    {
      'image': 'assets/images/image2.png',
      'product_name': 'JBL Speakers',
      'price': 32000,
    },
    {
      'image': 'assets/images/image5.png',
      'product_name': 'Nike Sneakers',
      'price': 12000,
    },
  ];
  List<Map<String, dynamic>?>? pendingAds = [];
  List<Map<String, dynamic>?>? declinedAds = [];
  List<Map<String, dynamic>?>? draftAds = [];
  List<Map<String, dynamic>?>? expiredAds = [];


  void setup(BuildContext context) async {}

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
