import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:megadey_mobile/views/search_product/search_product_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/colors.dart';

class SearchProductView extends StatelessWidget {
  static const routeName = 'searchProductView';

  const SearchProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchProductViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => SearchProductViewModel(),
        builder: (context, model, child) => Material(
                child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Color(0xFFF6F6F6),
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back_rounded, color: Colors.black54, size: 24),
                            ),
                            _searchWidget(model, context, model.searchController),
                          ],
                        ),
                    const SizedBox(height: 4),
                    Divider(color: Colors.grey.withOpacity(0.3)),
                    const SizedBox(height: 5),
                    model.isFetchingSuggestions
                     ? Center(
                       child: SizedBox(
                        height: 200,
                        width: 50,
                        child:  LoadingIndicator(
                            indicatorType: Indicator.ballSpinFadeLoader,
                            colors: [Palette.primaryColor],
                            strokeWidth: 6,
                            ),
                    ),
                     )
                     : model.suggestions != null && model.suggestions!.isNotEmpty
                        ? _suggestionsView(model)
                        : _recentSearchesView(model)
                  ],
                ),
              ),
            )));
  }

  Widget _searchWidget(SearchProductViewModel model, BuildContext context, TextEditingController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Container(
          width: double.maxFinite,
          height: 50,
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onChanged: (value) async {
              if(value.isEmpty){
                model.suggestions?.clear();
                model.notifyListeners();
              }else {
                await model.fetchSuggestions(value).then((value) {
                  if (model.suggestions != null && model.suggestions!.isNotEmpty)
                    _suggestionsView(model);
                });
              }
            },
            onSubmitted: (value) {
              FocusScope.of(context).unfocus();
              model.searchProduct(value);
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.0),
                borderSide: BorderSide(color: Colors.black26, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.0),
                borderSide: BorderSide(color: Palette.primaryColor, width: 1),
              ),
              contentPadding: EdgeInsets.only(left: 5.0),
              prefixIcon: Icon(Icons.search_rounded, color: Colors.black38),
              suffixIcon: InkWell(
                  onTap: (){
                    model.searchController.clear();
                    model.suggestions?.clear();
                    model.notifyListeners();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.close, color: Colors.grey),
                  )),
              hintText: "What are you searching for?",
              hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.7), fontSize: 15.0, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  Widget _suggestionsView(SearchProductViewModel model) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          model.recentSearches != null && model.recentSearches!.isNotEmpty
              ? Align(
            alignment:Alignment.centerLeft,
            child: Text(
                      'Suggestions',
                      style: TextStyle(
                        color: Color(0xFF8E8E8E),
                        fontSize: 13,
                        // fontFamily: 'Circular Std',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.24,
                      ),
                    ),
              )
              : SizedBox(),
          const SizedBox(height: 5),
          Container(
            constraints: BoxConstraints(maxHeight: 500),
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.suggestions?.length,
              itemBuilder: (BuildContext context, int index) {
                String? suggestion = model.suggestions?[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        model.notifyListeners();
                        model.searchProduct(suggestion ?? '');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        child:
                            Text(suggestion ?? '',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    // fontFamily: 'Circular Std',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                      ),
                    ),
                    Container(
                        height: 1, width: double.maxFinite, color: Colors.grey.withOpacity(0.2)),
                  ],
                );
              },
            ),
          )
        ]));
  }

  Widget _recentSearchesView(SearchProductViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          model.recentSearches != null && model.recentSearches!.isNotEmpty
              ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    'Recent search',
                    style: TextStyle(
                      color: Color(0xFF8E8E8E),
                      fontSize: 13,
                      // fontFamily: 'Circular Std',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.24,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      model.recentSearches?.clear();
                      model.notifyListeners();
                    },
                    child: Text(
                      'Clear',
                      style: TextStyle(
                        color: Palette.primaryColor,
                        fontSize: 13,
                        // fontFamily: 'Circular Std',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.24,
                      ),
                    ),
                  )
                ])
              : SizedBox(),
          const SizedBox(height: 5),
          Container(
            constraints: BoxConstraints(maxHeight: 500),
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.recentSearches?.length,
              itemBuilder: (BuildContext context, int index) {
                String? recentSearch = model.recentSearches?[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        //search
                        model.searchController.text = recentSearch ?? '';
                        model.notifyListeners();
                        model.searchProduct(recentSearch ?? '');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(recentSearch ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  // fontFamily: 'Circular Std',
                                  fontWeight: FontWeight.w600,
                                )),
                            Icon(Icons.refresh, size: 20, color: Colors.black26)
                          ],
                        ),
                      ),
                    ),
                    Container(
                        height: 1, width: double.maxFinite, color: Colors.grey.withOpacity(0.2)),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
