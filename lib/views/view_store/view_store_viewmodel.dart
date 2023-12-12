import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../core/services/utility_storage_service.dart';
import '../product_description/product_description_view.dart';
import '../product_description/product_description_viewmodel.dart';

class ViewStoresViewModel extends ReactiveViewModel {

  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  bool isLoading = false;
  bool isFetchingSuggestions = false;

  bool useListView = true;
  bool isTyping = false;

  static String? storeName;
  static int? storeId;

  int? totalProductFound = 14023;
  String? storeBanner = 'assets/images/storebanner.png';

  List<Map<String, Object>> productsFound = [
    {
      "id": 1,
      "image": "assets/images/galore_deal.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    },
    {
      "id": 2,
      "image": "assets/images/galore_deal.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    }, {
      "id": 3,
      "image": "assets/images/galore_deal.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    }, {
      "id": 4,
      "image": "assets/images/galore_deal.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    },
    {
      "id": 5,
      "image": "assets/images/galore_deal.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    },
    {
      "id": 6,
      "image": "assets/images/galore_deal.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    },
    {
      "id": 7,
      "image": "assets/images/galore_deal.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    },
    {
      "id": 8,
      "image": "assets/images/galore_deal.png",
      "title": "Lipstick",
      "subtitle": "Health & Beauty",
      "price": "N1,500"
    },
  ];


  TextEditingController searchController = TextEditingController();

  List<String?>? suggestions = [];


  void setup(BuildContext context) async {
  }

  Future<void> fetchSuggestions(String data) async{
    isFetchingSuggestions = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () async {
      suggestions = ['$data','$data $data','$data $data $data'];
      isFetchingSuggestions = false;
      notifyListeners();
    });
  }

  void searchProduct(String data){
    Future.delayed(const Duration(seconds: 1), () async {
      // isLoading = false;
      // isFetchingSuggestions = false;
      // useListView = false;
      // isTyping = false;
      // totalProductFound = 14023;
      // suggestions = [];
      //SearchResultViewModel.searchValue = data;
     // NavigationService().replaceWith(SearchResultView.routeName);

    });
  }

  void navigateToProductDescription(int id) {
    ProductDescriptionViewModel.id = id;
    NavigationService().navigateTo(ProductDescriptionView.routeName);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
