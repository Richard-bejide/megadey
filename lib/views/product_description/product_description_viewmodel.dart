import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:megadey_mobile/views/product_description/product_description_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/locator.dart';

class ProductDescriptionViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  bool isLoading = false;

  static int? id;

  CarouselController? carouselController;

  List<Map<String, Object>> productImages = [
    {
      "id": 1,
      "image": "assets/images/product2.png",
    },
    {
      "id": 2,
      "image": "assets/images/mega_deal1.png",
    },
    {
      "id": 3,
      "image": "assets/images/product3.png",
    },
    {
      "id": 4,
      "image": "assets/images/product1.png",
    },
    {
      "id": 5,
      "image": "assets/images/mega_deal1.png",
    },
  ];

  String? title = 'Nike Running Shoes';
  String? location = 'Ikeja, Nigeria';
  String? price = 'N30,000';
  String? timePosted = '17 hours ago';
  String? sellerImg = 'assets/images/seller.png';
  String? sellerName = 'Ayo Jones';
  String? accountCreatedOn = '5y5m';

  bool? isPromoted = true;
  bool addToFavourites = false;

  List<Map<String, Object>> similarProducts = [
    {
      "id": 1,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location" : "Ikeja, Lagos",
      "price": "N17,000"
    },
    {
      "id": 2,
      "image": "assets/images/product1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location" : "Ikeja, Lagos",
      "price": "N17,000"
    },
    {
      "id": 3,
      "image": "assets/images/product2.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location" : "Ikeja, Lagos",
      "price": "N17,000"
    },
    {
      "id": 4,
      "image": "assets/images/product3.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location" : "Ikeja, Lagos",
      "price": "N17,000"
    },{
      "id":5,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "location" : "Ikeja, Lagos",
      "price": "N17,000"
    }
  ];



  RefreshController refreshController = RefreshController(initialRefresh: false);

  void setup(BuildContext context) async {}

  Future<void> refresh() async {
    Future.delayed(const Duration(seconds: 5), () async {});
    refreshController.refreshCompleted();
  }


  void navigateToProductDescription(int id){
    NavigationService().navigateTo(ProductDescriptionView.routeName);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}