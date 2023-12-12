import 'package:flutter/material.dart';
import 'package:megadey_mobile/views/subcategories/subcategories_viewmodel.dart';
import 'package:stacked/stacked.dart';



class SubCategoriesView extends StatelessWidget {
  static const routeName = 'subCategoriesView';

  const  SubCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubCategoriesViewModel>.reactive(
        onViewModelReady: (model) => model.setup(context),
        viewModelBuilder: () => SubCategoriesViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
              appBar: appBar(model, context),
              backgroundColor: Color(0xFFF6F6F6),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              card(context,model),
                              const SizedBox(height: 20),
                            ],
                          ),
                        )
                ),
              ),
            )));
  }

  AppBar appBar(SubCategoriesViewModel model,BuildContext context){
    return AppBar(
      elevation: 1,
      centerTitle: true,
     title: Text(SubCategoriesViewModel.category ?? '',
         style: TextStyle(
           color: Colors.black,
           fontSize: 17,
           fontWeight: FontWeight.w700,
         )),
    );
  }

  Widget card(BuildContext context,SubCategoriesViewModel model){
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(0))
        ),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: SubCategoriesViewModel.subcategories?.length,
            itemBuilder: (BuildContext context, int index){
              Map<String,dynamic>? subcategory = SubCategoriesViewModel.subcategories?[index];
              return  Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: (){
                    model.navigateToCategoryProductsView(subcategory?['id'],subcategory?['title']);
                  },
                  child: Text(
                    subcategory?['title'] ?? '',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      // fontFamily: 'Circular Std',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            })
    );
  }

}