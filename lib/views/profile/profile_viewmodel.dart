import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:megadey_mobile/views/auth/sign_in_with_email/sign_in_with_email_view.dart';
import 'package:megadey_mobile/views/dashboard/dashboard_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../core/models/profile_model.dart';
import '../../core/services/utility_storage_service.dart';

class ProfileViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  bool isLoading = false;

  List<Map<String, dynamic>?>? feedbacks = [
    {
      'user_image': 'assets/images/messages1.png',
      'user_name': 'James Ward',
      'feedback': 'Great product you have there, really love it',
      'rating': '4'
    },
    {
      'user_image': 'assets/images/messages2.png',
      'user_name': 'James Ward',
      'feedback': 'Great product you have there, really love it',
      'rating': '4'
    },
    {
      'user_image': 'assets/images/messages3.png',
      'user_name': 'James Ward',
      'feedback': 'Great product you have there, really love it',
      'rating': '4'
    },
    {
      'user_image': 'assets/images/messages2.png',
      'user_name': 'James Ward',
      'feedback': 'Great product you have there, really love it',
      'rating': '4'
    },
    {
      'user_image': 'assets/images/messages1.png',
      'user_name': 'James Ward',
      'feedback': 'Great product you have there, really love it',
      'rating': '4'
    },
    {
      'user_image': 'assets/images/messages3.png',
      'user_name': 'James Ward',
      'feedback': 'Great product you have there, really love it',
      'rating': '4'
    },
  ];

  String? username;

  void setup(BuildContext context) async {
    ProfileData? profile = _storageService.getString('userProfile') != null ? jsonDecode(_storageService.getString('userProfile')!) : null;
    username = '${profile?.firstname} ${profile?.lastname}';
    notifyListeners();
  }

  void logout() {
    StorageService().removeBool('isLoggedIn');
    StorageService().removeString('token');
    //clear user details
    _navigationService.clearStackAndShow(DashboardView.routeName);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
