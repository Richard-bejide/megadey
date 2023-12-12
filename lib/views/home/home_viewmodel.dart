import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:megadey_mobile/views/product_description/product_description_view.dart';
import 'package:megadey_mobile/views/subcategories/subcategories_view.dart';
import 'package:megadey_mobile/views/view_all_deals/view_all_deals_view.dart';
import 'package:megadey_mobile/views/view_store/view_store_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timer_count_down/timer_controller.dart';
import '../../../../app/locator.dart';
import '../product_description/product_description_viewmodel.dart';
import '../subcategories/subcategories_viewmodel.dart';
import '../view_all_deals/view_all_deals_viewmodel.dart';
import '../view_store/view_store_viewmodel.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../api/apis.dart';
import '../../core/constants/strings.dart';
import '../../core/services/utility_storage_service.dart';
import '../../core/utilities/functions/debug_print.dart';
import 'dart:developer' as dev;

class HomeViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  bool isLoading = false;
  bool isLoadingDashboard = false;

  List<Map<String, Object>> categories = [
    {
      "id": 1,
      "title": "Agriculture Products & Machines",
      "image": "agriculture",
      'color': Color(0x7FD9D9D9),
      'subCategories': [
        {'id': 1, 'title': 'Farm Machinery & Equipment'},
        {'id': 2, 'title': 'Meals & Drinks'},
        {'id': 3, 'title': 'Livestock & Poultry'},
        {'id': 4, 'title': 'Feeds, Supplements & Seeds'},
      ]
    },
    {
      "id": 2,
      "title": "Animals & Pets",
      "image": "animal",
      'color': Color(0x7FF4AA41),
      'subCategories': [
        {'id': 1, 'title': 'Birds'},
        {'id': 2, 'title': 'Cats & Kittens'},
        {'id': 3, 'title': 'Dogs & Puppies'},
        {'id': 4, 'title': 'Fish'},
        {'id': 5, 'title': 'Pets accessories'},
        {'id': 6, 'title': 'Reptiles'},
        {'id': 7, 'title': 'Other Animals'},
      ]
    },
    {
      "id": 3,
      "title": "Apparel & Clothing",
      "image": "apparel",
      'color': Color(0xFF4482C3),
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": 4,
      "title": "Baby, Kids, Maternity, & Toys",
      "image": "baby",
      'color': Color(0xFF70C9D8),
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": 5,
      "title": "Office, Schools, Businesses, Books & Movies",
      "image": "books",
      'color': Color(0xFFAF6328),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 6,
      "title": "Computer & Networking",
      "image": "computer",
      'color': Color(0x7FF1F1F1),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 7,
      "title": "Electronics(Games & Accessories, Camera & Photos)",
      "image": "electronics",
      'color': Color(0xFF70C9D8),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 8,
      "title": "Industrial, Medical & Construction tools, Equipment & Machinery",
      "image": "equipments",
      'color': Color(0xFFC5FFCA),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 9,
      "title": "Fashion(Bags, Shoes, Watches, Jewelries, Gifts & Pefumes)",
      "image": "fashion",
      'color': Color(0xFFFFE100),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 10,
      "title": "Food & Beverages",
      "image": "food",
      'color': Color(0xFFF4AEAB),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 11,
      "title": "Hair products, Health & Beauty",
      "image": "health&beauty",
      'color': Color(0xFFFF3F62),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 12,
      "title": "Home, Household appliances, Lighting & Gardens",
      "image": "home",
      'color': Color(0xFF4E901E),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 13,
      "title": "Music & Musical instruments",
      "image": "music",
      'color': Color(0xFFFFB86C),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 14,
      "title": "Properties",
      "image": "properties",
      'color': Color(0xFF00A1AD),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 15,
      "title": "Services, Jobs & Careers",
      "image": "services",
      'color': Color(0xFF263390),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 16,
      "title": "Sports & Outdoors",
      "image": "sports",
      'color': Color(0xFF505454),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 17,
      "title": "Vehicles",
      "image": "vehicles",
      'color': Color(0xFF86CBED),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 18,
      "title": "Security & Surveillance",
      "image": "security",
      'color': Color(0x330B5000),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 19,
      "title": "Wedding Party & Events",
      "image": "weddings&events",
      'color': Color(0x33EEC97B),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
    {
      "id": 20,
      "title": "Everything else",
      'color': Color(0x7FD9D9D9),
      'subCategories': [
        {'id': 1, 'title': "Computer Accessories"},
        {'id': 2, 'title': "Computer Components"},
        {'id': 3, 'title': "Drives & Storages"},
        {'id': 4, 'title': "Keyboards, Mice & Inputs"},
        {'id': 5, 'title': "Laptops & Monitors"},
        {'id': 6, 'title': "Networking & Communications"},
        {'id': 7, 'title': "PC Brand Centers"},
        {'id': 8, 'title': "Popular Brand Tablets"},
        {'id': 9, 'title': "Printers & Supplies"},
        {'id': 10, 'title': "Projection Equipment"},
        {'id': 11, 'title': "Refurbished Laptops"},
        {'id': 12, 'title': "Scanners"},
        {'id': 13, 'title': "Tablet PC"},
        {'id': 14, 'title': "Tablet PC Accessories"},
      ]
    },
  ];

  List<Map<String, Object>> jumboDeals = [
    {
      "id": 1,
      "image": "assets/images/image1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "price": "N17,000"
    },
    {
      "id": 2,
      "image": "assets/images/image1.png",
      "title": "BMX 200 RC",
      "subtitle": "Sports",
      "price": "N103,000"
    },
    {
      "id": 3,
      "image": "assets/images/image1.png",
      "title": "German Shepherd",
      "subtitle": "Animals",
      "price": "N30,000"
    },
    {
      "id": 4,
      "image": "assets/images/image1.png",
      "title": "Cement Tiles",
      "subtitle": "Equipments",
      "price": "N3,000"
    },
    {
      "id": 5,
      "image": "assets/images/image1.png",
      "title": "AV Gown",
      "subtitle": "Fashion",
      "price": "N12,500"
    },
  ];

  List<Map<String, Object>> niftyDeals = [
    {
      "id": 1,
      "image": "assets/images/image2.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000"
    },
    {
      "id": 2,
      "image": "assets/images/image3.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000"
    }
  ];

  List<Map<String, Object>> galoreDeals = [
    {
      "id": 1,
      "image": "assets/images/image4.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    },
    {
      "id": 2,
      "image": "assets/images/image5.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    },
    {
      "id": 3,
      "image": "assets/images/image6.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    },
    {
      "id": 4,
      "image": "assets/images/image2.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    },
    {
      "id": 5,
      "image": "assets/images/image3.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    },
    {
      "id": 6,
      "image": "assets/images/image5.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    },
  ];

  List<Map<String, Object>> megaDeals = [
    {
      "id": 1,
      "image": "assets/images/image7.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "price": "N17,000"
    },
    {
      "id": 2,
      "image": "assets/images/image8.png",
      "title": "Drone",
      "subtitle": "Computer",
      "price": "N160,000"
    },
    {
      "id": 3,
      "image": "assets/images/nifty_deal.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000"
    },
    {
      "id": 4,
      "image": "assets/images/mega_deal2.png",
      "title": "Drone",
      "subtitle": "Computer",
      "price": "N160,000"
    },
    {
      "id": 5,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "price": "N17,000"
    },
  ];

  List<Map<String, Object>> optimumDeals = [
    {
      "id": 1,
      "image": "assets/images/image9.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "price": "N17,000"
    },
    {
      "id": 2,
      "image": "assets/images/image8.png",
      "title": "Drone",
      "subtitle": "Computer",
      "price": "N160,000"
    },
    {
      "id": 3,
      "image": "assets/images/image7.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000"
    },
    {
      "id": 4,
      "image": "assets/images/mega_deal2.png",
      "title": "Drone",
      "subtitle": "Computer",
      "price": "N160,000"
    },
    {
      "id": 5,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "price": "N17,000"
    },
  ];

  List<Map<String, Object>> jollyDeals = [
    {
      "id": 1,
      "image": "assets/images/image6.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "price": "N17,000"
    },
    {
      "id": 2,
      "image": "assets/images/image5.png",
      "title": "Drone",
      "subtitle": "Computer",
      "price": "N160,000"
    },
    {
      "id": 3,
      "image": "assets/images/nifty_deal.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000"
    },
    {
      "id": 4,
      "image": "assets/images/mega_deal2.png",
      "title": "Drone",
      "subtitle": "Computer",
      "price": "N160,000"
    },
    {
      "id": 5,
      "image": "assets/images/mega_deal1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "price": "N17,000"
    },
  ];

  List<Map<String, Object>> superStores1 = [
    {
      "id": 1,
      "image": "assets/images/superstore1.png",
      "title": "Drone",
      "subtitle": "Computer",
      "price": "N213,000",
      "discount": "10%",
    },
    {
      "id": 2,
      "image": "assets/images/superstore2.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000",
      "discount": "10%",
    },
    {
      "id": 3,
      "image": "assets/images/superstore3.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000",
      "discount": "10%",
    },
    {
      "id": 4,
      "image": "assets/images/superstore1.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000",
      "discount": "10%",
    },
    {
      "id": 5,
      "image": "assets/images/superstore2.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000",
      "discount": "10%",
    },
  ];

  List<Map<String, Object>> superStores2 = [
    {
      "id": 1,
      "image": "assets/images/superstore3.png",
      "title": "Drone",
      "subtitle": "Computer",
      "price": "N213,000",
      "discount": "10%",
    },
    {
      "id": 2,
      "image": "assets/images/superstore1.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000",
      "discount": "10%",
    },
    {
      "id": 3,
      "image": "assets/images/superstore2.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000",
      "discount": "10%",
    },
    {
      "id": 4,
      "image": "assets/images/superstore1.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000",
      "discount": "10%",
    },
    {
      "id": 5,
      "image": "assets/images/superstore3.png",
      "title": "Water Bottle",
      "subtitle": "Sports",
      "price": "N3,000",
      "discount": "10%",
    },
  ];

  List<Map<String, Object>> dandyDeals = [
    {
      "id": 1,
      "image": "assets/images/image1.png",
      "title": "Nike Running Shoe",
      "subtitle": "Shoes",
      "price": "N17,000"
    },
    {
      "id": 2,
      "image": "assets/images/image1.png",
      "title": "BMX 200 RC",
      "subtitle": "Sports",
      "price": "N103,000"
    },
    {
      "id": 3,
      "image": "assets/images/image1.png",
      "title": "German Shepherd",
      "subtitle": "Animals",
      "price": "N30,000"
    },
    {
      "id": 4,
      "image": "assets/images/image1.png",
      "title": "Cement Tiles",
      "subtitle": "Equipments",
      "price": "N3,000"
    },
    {
      "id": 5,
      "image": "assets/images/image1.png",
      "title": "AV Gown",
      "subtitle": "Fashion",
      "price": "N12,500"
    },
  ];

  List<Map<String, Object>> trending = [
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
  ];

  RefreshController refreshController = RefreshController(initialRefresh: true);

  late CountdownController countdownController;


  void setup(BuildContext context) async {
    isLoadingDashboard = true;
    countdownController = CountdownController(autoStart: true);
    notifyListeners();
    await fetchCategories(context);
    await fetchDashboard(context);
    isLoadingDashboard = false;
    notifyListeners();
  }

  String intToTime(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);
    String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();
    String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();
    String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();
    String result = "$hourLeft:$minuteLeft:$secondsLeft";
    return result;
  }


  Future<void> refresh(BuildContext context) async {
    await fetchDashboard(context);
    refreshController.refreshCompleted();
  }

  void navigateToProductDescription(int id) {
    ProductDescriptionViewModel.id = id;
    NavigationService().navigateTo(ProductDescriptionView.routeName);
  }

  void navigateToSubCategoriesView({required int categoryId, required String? categoryTitle, required List<Map<String, dynamic>?>? subCategories}) {
    SubCategoriesViewModel.category = categoryTitle;
    SubCategoriesViewModel.subcategories = subCategories;
    NavigationService().navigateTo(SubCategoriesView.routeName);
  }

  void navigateToStoreView(int id,String name) {
    ViewStoresViewModel.storeId = id;
    ViewStoresViewModel.storeName = name;
    NavigationService().navigateTo(ViewStoresView.routeName);
  }

  void navigateToSeeAllDealsView(int id,String name) {
    ViewAllDealsViewModel.dealsId = id;
    ViewAllDealsViewModel.dealsTitle = name;
    NavigationService().navigateTo(ViewAllDealsView.routeName);
  }

  // Timer? timer;
  // // fetch dashboard every 30 seconds
  // Future<void> refreshDashboard(BuildContext context) async {
  //   timer = Timer.periodic(const Duration(seconds: 30), (time) async {
  //    fetchDashboard(context);
  //   });
  // }

  Future<void> fetchDashboard(BuildContext context) async{
    fetchJumboDeals(context);
    fetchNiftyDeals(context);
    fetchGaloreDeals(context);
    fetchMegaDeals(context);
    fetchOptimumDeals(context);
    fetchJollyDeals(context);
    //fetchSuperstoresDeals(context);
    fetchDandyDeals(context);
  }

  Future<void> fetchCategories(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http.get(Uri.parse(Apis.baseUrl + Apis.categories), headers: {
        "Accept": "application/json",
        if(StorageService().getString('token') != null ) "Authorization" :  'Bearer ${StorageService().getString('token')}'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        //Profile? temp =  Profile.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
        // _profileService.setProfileDetails = temp.data;
        isLoading = false;
        notifyListeners();
        dPrint('categories fetched:::');
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.internetError,backgroundColor: Colors.red);
    }  catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
      dPrint("Error received when dashboard: ${e.toString()}");
    }
  }

  Future<void> fetchJumboDeals(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http
          .post(Uri.parse(Apis.baseUrl + Apis.dashboard), headers: {
        "Accept": "application/json",
        if(StorageService().getString('token') != null ) "Authorization" :  'Bearer ${StorageService().getString('token')}'
      },body: {
            'name':'JUMBO',
            'limit':'5'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        //Profile? temp =  Profile.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
       // _profileService.setProfileDetails = temp.data;
        isLoading = false;
        notifyListeners();
        dPrint('jumbo fetched:::');
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.internetError,backgroundColor: Colors.red);
    }  catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
      dPrint("Error received when dashboard: ${e.toString()}");
    }
  }
  Future<void> fetchNiftyDeals(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http
          .post(Uri.parse(Apis.baseUrl + Apis.dashboard), headers: {
        "Accept": "application/json",
        if(StorageService().getString('token') != null ) "Authorization" :  'Bearer ${StorageService().getString('token')}'
      },body: {
        'name':'NIFTY',
        'limit':'2'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        //Profile? temp =  Profile.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
        // _profileService.setProfileDetails = temp.data;
        isLoading = false;
        notifyListeners();
        dPrint('nifty fetched:::');
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.internetError,backgroundColor: Colors.red);
    }  catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
      dPrint("Error received when dashboard: ${e.toString()}");
    }
  }
  Future<void> fetchGaloreDeals(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http
          .post(Uri.parse(Apis.baseUrl + Apis.dashboard), headers: {
        "Accept": "application/json",
        if(StorageService().getString('token') != null ) "Authorization" :  'Bearer ${StorageService().getString('token')}'
      },body: {
        'name':'GALORE',
        'limit':'6'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        //Profile? temp =  Profile.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
        // _profileService.setProfileDetails = temp.data;
        isLoading = false;
        notifyListeners();
        dPrint('galore fetched:::');
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.internetError,backgroundColor: Colors.red);
    }  catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
      dPrint("Error received when dashboard: ${e.toString()}");
    }
  }
  Future<void> fetchMegaDeals(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http
          .post(Uri.parse(Apis.baseUrl + Apis.dashboard), headers: {
        "Accept": "application/json",
        if(StorageService().getString('token') != null ) "Authorization" :  'Bearer ${StorageService().getString('token')}'
      },body: {
        'name':'MEGA',
        'limit':'20'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        //Profile? temp =  Profile.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
        // _profileService.setProfileDetails = temp.data;
        isLoading = false;
        notifyListeners();
        dPrint('mega fetched:::');
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.internetError,backgroundColor: Colors.red);
    }  catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
      dPrint("Error received when dashboard: ${e.toString()}");
    }
  }
  Future<void> fetchOptimumDeals(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http
          .post(Uri.parse(Apis.baseUrl + Apis.dashboard), headers: {
        "Accept": "application/json",
        if(StorageService().getString('token') != null ) "Authorization" :  'Bearer ${StorageService().getString('token')}'
      },body: {
        'name':'OPTIMUM',
        'limit':'20'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dev.log('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        //Profile? temp =  Profile.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
        // _profileService.setProfileDetails = temp.data;
        isLoading = false;
        notifyListeners();
        dPrint('optimum deals fetched:::');
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.internetError,backgroundColor: Colors.red);
    }  catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
      dPrint("Error received when dashboard: ${e.toString()}");
    }
  }
  Future<void> fetchJollyDeals(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http
          .post(Uri.parse(Apis.baseUrl + Apis.dashboard), headers: {
        "Accept": "application/json",
        if(StorageService().getString('token') != null ) "Authorization" :  'Bearer ${StorageService().getString('token')}'
      },body: {
        'name':'JOLLY',
        'limit':'20'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        //Profile? temp =  Profile.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
        // _profileService.setProfileDetails = temp.data;
        isLoading = false;
        notifyListeners();
        dPrint('jolly fetched:::');
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.internetError,backgroundColor: Colors.red);
    }  catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
      dPrint("Error received when dashboard: ${e.toString()}");
    }
  }
  Future<void> fetchSuperstoresDeals(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http
          .post(Uri.parse(Apis.baseUrl + Apis.dashboard), headers: {
        "Accept": "application/json",
        if(StorageService().getString('token') != null ) "Authorization" :  'Bearer ${StorageService().getString('token')}'
      },body: {
        'name':'SUPERSTORE',
        'limit':'20'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        //Profile? temp =  Profile.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
        // _profileService.setProfileDetails = temp.data;
        isLoading = false;
        notifyListeners();
        dPrint('dashboard fetched:::');
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.internetError,backgroundColor: Colors.red);
    }  catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
      dPrint("Error received when dashboard: ${e.toString()}");
    }
  }
  Future<void> fetchDandyDeals(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      var response = await http
          .post(Uri.parse(Apis.baseUrl + Apis.dashboard), headers: {
        "Accept": "application/json",
        if(StorageService().getString('token') != null ) "Authorization" :  'Bearer ${StorageService().getString('token')}'
      },body: {
        'name':'DANDY',
        'limit':'5'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        //Profile? temp =  Profile.fromJson(jsonDecode(response.body) as Map<String,dynamic>);
        // _profileService.setProfileDetails = temp.data;
        isLoading = false;
        notifyListeners();
        dPrint('dandy fetched:::');
      }
      //failure
      else {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
        dPrint('error ${response.body}');
      }
    } on SocketException {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.internetError,backgroundColor: Colors.red);
    }  catch (e) {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: AppStrings.unknownError,backgroundColor: Colors.red);
      dPrint("Error received when dashboard: ${e.toString()}");
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
