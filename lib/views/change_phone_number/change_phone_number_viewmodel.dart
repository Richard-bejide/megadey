import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../core/services/utility_storage_service.dart';

class ChangePhoneNumberViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  TextEditingController idCardController = TextEditingController();
  TextEditingController idCardNoController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();



  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  String? phoneNumber;

  void setup(BuildContext context) async {}

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
