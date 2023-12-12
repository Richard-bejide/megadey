import 'package:flutter/material.dart';
import 'package:megadey_mobile/views/product_description/product_description_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/constants/colors.dart';
import 'favourites_viewmodel.dart';

class FavouritesView extends StatelessWidget {
  static const routeName = 'favouritesView';

  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavouritesViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => FavouritesViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Color(0xFFF6F6F6),
              appBar: appBar(model, context),
              body: favouritesList(model)
            )));
  }

  AppBar appBar(FavouritesViewModel model,BuildContext context){
    return AppBar(
      elevation: 1,
      centerTitle: true,
      title: Text(
        'Wishlist',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          // fontFamily: 'Circular Std',
          fontWeight: FontWeight.w700,
          letterSpacing: -0.40,
        ),
      ),
    );
  }

  Widget favouritesList(FavouritesViewModel model){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
      child: ListView.builder(
          itemCount: model.favourites.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index){
            Map favourite = model.favourites[index];
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                highlightColor: Palette.primaryColor.withOpacity(0.1),
                onTap: (){
                  NavigationService().navigateTo(ProductDescriptionView.routeName);},
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 130,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(favourite["image"] ?? ''),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width:20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                SizedBox(
                                  width:120,
                                  child: Text(
                                    favourite["title"] ?? '',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  width:120,
                                  child: Text(
                                      " ${favourite["subtitle"]}",
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
                                const SizedBox(height: 4),
                                SizedBox(
                                  width:120,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_on_outlined,size:13,color: Palette.customGrey),
                                      Text(
                                          favourite["location"] ?? '',
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Color(0xFF494949),
                                            fontSize: 13,
                                            // fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                            Text(
                              favourite["price"] ?? '',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Palette.primaryColor,
                                fontSize: 15,
                                // fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
