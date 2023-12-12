import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SellViewModel extends ReactiveViewModel {

  bool isLoading = false;
  bool loadingCategories = false;
  int currentPage = 0;

  List<Map<String, Object>> categories = [
    {
      "id": '1',
      "title": "Agriculture",
      'subCategories': [
        {'id': 1, 'title': 'Farm Machinery & Equipment'},
        {'id': 2, 'title': 'Meals & Drinks'},
        {'id': 3, 'title': 'Livestock & Poultry'},
        {'id': 4, 'title': 'Feeds, Supplements & Seeds'},
      ]
    },
    {
      "id": '2',
      "title": "Animals",
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
      "id": '3',
      "title": "Apparel",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '4',
      "title": "Baby",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '5',
      "title": "Books",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '6',
      "title": "Computer",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '7',
      "title": "Electronics",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '8',
      "title": "Equipments",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '9',
      "title": "Fashion",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '10',
      "title": "Foods",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '11',
      "title": "Health & Beauty",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '12',
      "title": "Home",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '13',
      "title": "Music",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '14',
      "title": "Properties",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '15',
      "title": "Services",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '16',
      "title": "Sports",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '17',
      "title": "Vehicles",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '18',
      "title": "Security",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '19',
      "title": "Weddings & Events",
      'subCategories': [
        {'id': 1, 'title': 'Men\'s Clothing'},
        {'id': 2, 'title': 'Women\'s Clothing'},
        {'id': 3, 'title': 'Men\'s Plus Size'},
        {'id': 4, 'title': 'Women\'s Plus Size'},
      ]
    },
    {
      "id": '20',
      "title": "More",
    },
  ];

  String? selectedCategory;
  int? selectedCategoryIndex;

  String? selectedSubcategory;
  int? selectedSubcategoryIndex;

  List<String> images = [];

  TextEditingController productName = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();


  bool negotiablePrice = true;


  bool newProduct = true;

  List<Map<String, Object>> getSubCategories(){
    return categories[selectedCategoryIndex!]['subCategories'] as List<Map<String, Object>>;
  }

  void setup(BuildContext context) async {}


  void clearAd(){
    productName.clear();
    productDescription.clear();
    price.clear();
    location.clear();
    quantity.clear();
    discount.clear();
    currentPage = 0;
    selectedCategory = null;
    selectedCategoryIndex = null;
    selectedSubcategory = null;
    selectedSubcategoryIndex = null;

    notifyListeners();
  }


  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
