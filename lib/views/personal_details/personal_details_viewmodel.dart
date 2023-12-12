import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../core/services/utility_storage_service.dart';

class PersonalDetailsViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController facebookLinkController = TextEditingController();
  TextEditingController twitterLinkController = TextEditingController();
  TextEditingController instaLinkController = TextEditingController();


  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //name validation
  final RegExp nameRegex = RegExp(r"^[\p{L} ,.'-]*$", caseSensitive: false, unicode: true, dotAll: true);

  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG',phoneNumber: '08034592904');
  String? phoneNumber;

  void setup(BuildContext context) async {
    emailController.text = 'richardbejde@gmail.com';
    nameController.text = 'Richard Bejide';

  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
