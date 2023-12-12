import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';

class WalletViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController amountToFund = TextEditingController();

  void setup(BuildContext context) async {}

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
