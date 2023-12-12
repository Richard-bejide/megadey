import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:megadey_mobile/views/view_all_deals/view_all_deals_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/constants/colors.dart';
import '../../core/utilities/widgets/category_filter.dart';

class ViewAllDealsView extends StatelessWidget {
  static const routeName = 'viewAllDealsView';

  const ViewAllDealsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewAllDealsViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => ViewAllDealsViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Color(0xFFF6F6F6),
              body: model.isTyping
                  ? Stack(
                  children:[
                    _searchWidget(model, context, model.searchController),
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
                        ? Positioned(
                        left: 0,
                        right:0,
                        top: 75,
                        child: _suggestionsView(model))
                        : const SizedBox()
                  ])
                  : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBar(model, context),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20.0),
                      child:  ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0.0),
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            height: 120,
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: model.filters?.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index){
                                Map<String, Object>? filter = model.filters?[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height:50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Palette.primaryColor.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(Radius.circular(12)))
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: 70,
                                        child: Text('${filter?['title']}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                      )
                                    ]),
                                );
                              }),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(color: Palette.primaryColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    'Newest',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(color: Color(0xFF9602AF)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          //use filters
                                          NavigationService().navigateToView(ApplyFilters(category: ''));
                                          },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset('assets/icons/filter.svg',color: Colors.white,height: 20),
                                            const SizedBox(width:5),
                                            Text(
                                              'Filters',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                // fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            ViewAllDealsViewModel.dealsTitle ?? '',
                            style: TextStyle(
                              color: Color(0xFF121212),
                              fontSize: 22.78,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: 300,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${model.totalProductFound} ',
                                    style: TextStyle(
                                      color: Color(0xFF595959),
                                      fontSize: 16,
                                      // fontFamily: 'Circular Std',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.28,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'products found',
                                    style: TextStyle(
                                      color: Color(0xFF595959),
                                      fontSize: 14,
                                      // fontFamily: 'Circular Std',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.28,
                                    ),
                                  ),

                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          listViewOfProducts(model),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget appBar(ViewAllDealsViewModel model,BuildContext context){
    return Container(
      color: Palette.primaryColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0,top: 50,left: 20,right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back,color: Colors.black,size: 24),
                ],
              ),
            ),
            Expanded(child: _searchWidget(model, context, model.searchController)),
            GestureDetector(
              onTap: () {},
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 4.0),
                  child:  CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.star_border_outlined,color: Palette.primaryColor,size: 20))
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchWidget(ViewAllDealsViewModel model, BuildContext context, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0),
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
            // prefixIcon: InkWell(
            //     onTap: (){
            //       model.isTyping = !model.isTyping;
            //       model.notifyListeners();
            //     },
            //     child: Icon(Icons.arrow_back_rounded, color: Colors.black38,size: 24,)),
            // suffixIcon: InkWell(
            //     onTap: (){
            //       model.searchController.clear();
            //       model.suggestions?.clear();
            //       model.notifyListeners();
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.only(right: 5.0),
            //       child: Icon(Icons.close, color: Colors.grey),
            //     )),
            hintText: "Search Deals",
            hintStyle: TextStyle(
                color: Colors.grey.withOpacity(0.7), fontSize: 15.0, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _suggestionsView(ViewAllDealsViewModel model) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 5),
          Container(
            constraints: BoxConstraints(maxHeight: 500),
            width: double.maxFinite,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius : 3,
                      spreadRadius : 3,
                      color: Colors.black12
                  )
                ],
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

  Widget listViewOfProducts(ViewAllDealsViewModel model){
    return  ListView.builder(
        itemCount: model.productsFound.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index){
          Map productFound = model.productsFound[index];

          return InkWell(
            onTap: (){
              model.navigateToProductDescription(productFound['id']);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                color: Colors.white,
                padding: const  EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 153,
                      height: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(productFound["image"] ?? ''),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(width:10),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                            width:100,
                            child: Text(
                              productFound["title"] ?? '',
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                // fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width:100,
                            child: Text(
                                productFound["subtitle"] ?? '',
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Color(0xFF494949),
                                  fontSize: 13,
                                  // fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            productFound["price"] ?? '',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              // fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ]
                    ),

                  ],
                ),
              ),
            ),
          );
        });
  }
}
