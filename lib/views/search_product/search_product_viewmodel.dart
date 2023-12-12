import 'package:flutter/material.dart';
import 'package:megadey_mobile/views/search_result/search_result_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/locator.dart';
import '../../core/services/utility_storage_service.dart';
import '../search_result/search_result_view.dart';
class SearchProductViewModel extends ReactiveViewModel {

  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();

  bool isLoading = false;
  bool isFetchingSuggestions = false;


  TextEditingController searchController = TextEditingController();

  List<String?>? recentSearches = ['Shirts','Swimwear', 'Outerwear & Costs', 'Suits & Blazers', 'Men\'s Underwear',];

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
      SearchResultViewModel.searchValue = data;
      NavigationService().replaceWith(SearchResultView.routeName);
    });
  }


  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
