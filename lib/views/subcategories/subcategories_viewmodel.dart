import 'package:flutter/material.dart';
 import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/locator.dart';
import '../category_products/category_products_view.dart';
import '../category_products/category_products_viewmodel.dart';

class SubCategoriesViewModel extends ReactiveViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  bool isLoading = false;

  static String? category;
  static List<Map<String, dynamic>?>? subcategories;

  void setup(BuildContext context) async {}

  void navigateToCategoryProductsView(int subcategoryId,String? title){
    CategoryProductsViewModel.subcategoryId = subcategoryId;
    CategoryProductsViewModel.title = title;
    NavigationService().navigateTo(CategoryProductsView.routeName);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}