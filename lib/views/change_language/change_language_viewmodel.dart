import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../core/services/utility_storage_service.dart';

class ChangeLanguageViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  List<String> languages = ['English','French','Spanish'];

  String? selectedLanguage;

  void setup(BuildContext context) async {}

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
