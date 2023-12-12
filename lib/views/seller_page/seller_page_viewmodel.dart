import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';

class SellerPageViewModel extends ReactiveViewModel {

  final NavigationService _navigationService = locator<NavigationService>();

  bool isLoading = false;

  List<Map<String, Object>> products = [
    {
      "id": 1,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location": "Ikeja, Lagos",
      "price": "N17,000"
    },
    {
      "id": 2,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location": "Ikeja, Lagos",
      "price": "N17,000"
    },
    {
      "id": 3,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location": "Ikeja, Lagos",
      "price": "N17,000"
    },
    {
      "id": 4,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location": "Ikeja, Lagos",
      "price": "N17,000"
    },
    {
      "id": 5,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location": "Ikeja, Lagos",
      "price": "N17,000"
    },
    {
      "id": 6,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location": "Ikeja, Lagos",
      "price": "N17,000"
    },
    {
      "id": 7,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location": "Ikeja, Lagos",
      "price": "N17,000"
    },
    {
      "id": 8,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location": "Ikeja, Lagos",
      "price": "N17,000"
    },
    {
      "id": 9,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location": "Ikeja, Lagos",
      "price": "N17,000"
    },
    {
      "id": 10,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location": "Ikeja, Lagos",
      "price": "N17,000"
    },
  ];


  void setup(BuildContext context) async {}

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
