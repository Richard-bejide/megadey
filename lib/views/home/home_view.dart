import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megadey_mobile/core/utilities/widgets/loading_overlay_widget.dart';
import 'package:megadey_mobile/views/notifications/notifications_view.dart';
import 'package:megadey_mobile/views/search_product/search_product_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../core/constants/colors.dart';
import '../../core/utilities/widgets/loading_widget.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  static const routeName = 'homeView';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        onViewModelReady: (model) => model.setup(context),
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => Material(
                child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: model.isLoadingDashboard
                      ?  LoadingWidget(color:Palette.primaryColor)
                      :Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      appBar(model,context),
                      Expanded(
                       child:
                    // SmartRefresher(
                    //   enablePullDown: true,
                    //   enablePullUp: false,
                    //   onRefresh: () async {
                    //     model.refresh(context);
                    //   },
                    //   header: const WaterDropMaterialHeader(),
                    //   controller: model.refreshController,
                    //   child:
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            jumboDeals(model),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration:BoxDecoration(
                                        color: Colors.grey.withOpacity(0.07),
                                        borderRadius: BorderRadius.all(Radius.circular(16))
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/icons/target.svg',height: 13),
                                          const SizedBox(width: 2),
                                          Text(
                                            'Verified sellers',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  const SizedBox(width: 7),
                                  Container(
                                    decoration:BoxDecoration(
                                        color: Colors.grey.withOpacity(0.07),
                                        borderRadius: BorderRadius.all(Radius.circular(16))
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/icons/target.svg',height: 13),
                                          const SizedBox(width: 2),
                                          Text(
                                            'Nation wide Delivery',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  const SizedBox(width: 7),
                                  Container(
                                    decoration:BoxDecoration(
                                        color: Colors.grey.withOpacity(0.07),
                                        borderRadius: BorderRadius.all(Radius.circular(16))
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/icons/target.svg',height: 13),
                                          const SizedBox(width: 2),
                                          Text(
                                            '24 Hours Service',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  const SizedBox(width: 7),
                                  Container(
                                    decoration:BoxDecoration(
                                        color: Colors.grey.withOpacity(0.07),
                                        borderRadius: BorderRadius.all(Radius.circular(16))
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/icons/target.svg',height: 13),
                                          const SizedBox(width: 2),
                                          Text(
                                            'Safe & Secure',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 9,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            categories(model),
                            const SizedBox(height: 20),
                            niftyDeals(model),
                            const SizedBox(height: 20),
                            galoreDeals(model),
                            const SizedBox(height: 20),
                            megaDeals(model),
                            const SizedBox(height: 20),
                            optimumDeals(model),
                            const SizedBox(height: 20),
                            jollyDeals(model),
                            const SizedBox(height: 20),
                            superStores(model),
                            const SizedBox(height: 20),
                            dandyDeals(model),
                            const SizedBox(height: 50),
                            trending(model),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    )
                //  )
                    ]),
                ),
              ),
            )));
  }

  Widget appBar(HomeViewModel model,BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(TextSpan(
            children: [
              TextSpan(
                text: 'Mega',
                style: TextStyle(
                  color: Palette.primaryColor,
                  fontSize: 22.78,
                  //fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'day',
                style: TextStyle(
                  color: Color(0xFF121212),
                  fontSize: 22.78,
                  // fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  //search
                  NavigationService().navigateTo(SearchProductView.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 4.0),
                  child: SvgPicture.asset('assets/icons/search.svg',
                      height: 18, color: Palette.primaryColor),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  //notifications
                  NavigationService().navigateTo(NotificationsView.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 4.0),
                  child: SvgPicture.asset('assets/icons/notifications.svg',
                      height: 18, color: Palette.primaryColor),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget jumboDeals(HomeViewModel model){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jumbo Deals',
          style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              // fontFamily: 'Circular Std',
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 1),
        FlutterCarousel(
          options: CarouselOptions(
            pauseAutoPlayOnTouch: false,
            padEnds: false,
              floatingIndicator: true,
              slideIndicator: CircularSlideIndicator(
                alignment: Alignment.bottomCenter,
                itemSpacing: 10,
                indicatorRadius: 4.0,
                currentIndicatorColor: Colors.white,
                indicatorBackgroundColor:  Colors.white60,
              ),
              height: 200,
              aspectRatio: 3 / 2,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
             // autoPlayCurve: Curves.elasticInOut,
              reverse: false,
              // enlargeCenterPage: true,
              onPageChanged: (index, reason) {},
              scrollDirection: Axis.horizontal),
          items: model.jumboDeals.map((i) {
            return Builder(builder: (BuildContext context) {
              return InkWell(
                highlightColor: Palette.primaryColor.withOpacity(0.1),
                onTap: () {
                  model.navigateToProductDescription(i['id'] as int);
                },
                child: Container(
                          width: double.maxFinite,
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.only(top: 10, right: 10, bottom: 8),                        height: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.grey.withOpacity(0.1),
                          image: DecorationImage(
                            image: AssetImage('${i['image']}'), fit: BoxFit.fill,
                          ),
                        ),
                        child:Container(
                          width: double.maxFinite,
                          height: 190,
                          padding: const EdgeInsets.all(20),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.black.withOpacity(0.1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${i['title']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '${i['subtitle']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      //fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${i['price']}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  //fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
              );
            });
          }).toList(),
        ),
      ],
    );
  }

  Widget categories(HomeViewModel model){
    return Column(
      children:[
        Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            //fontFamily: 'Circular Std',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing:1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio:0.7),
          itemCount: model.categories.length,
          itemBuilder: (BuildContext context, int index) {
            Map category = model.categories[index];
            return categoryCard(
                onTap: (){
                  //go to category
                   model.navigateToSubCategoriesView(
                       categoryId: category['id'],
                       categoryTitle: category['title'],
                       subCategories: category['subCategories']
                   );
                },
                title: category['title'],
                image: category['image'],
                color: category['color']);
          }),
    ]);
  }

  Widget categoryCard({required String? title, required String? image,required Color? color,required Function() onTap}){
    return InkWell(
      highlightColor: Palette.primaryColor.withOpacity(0.1),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: 90,
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color?.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: image != null
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/categories/$image.png',height: 50,width: 50),
                const SizedBox(height: 5),
                SizedBox(
                  width: 90,
                  height: 50,
                  child: Text(StringUtils.capitalize(title ?? 'Null'),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  )),
                )
              ],
            )
            : SizedBox(
              width: 90,
              child: Text(StringUtils.capitalize(title ?? 'Null'),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    // fontFamily: 'Circular Std',
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget niftyDeals(HomeViewModel model){
    return  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text(
             'Nifty Deals',
             style: TextStyle(
               color: Colors.black,
               fontSize: 17,
               // fontFamily: 'Circular Std',
               fontWeight: FontWeight.w600),
           ),
           InkWell(
             onTap: (){
               //see more nifty deals
               model.navigateToSeeAllDealsView(2, 'Nifty Deals');
             },
             child: Text(
               'See more',
               style: TextStyle(
                 color: Palette.primaryColor,
                 fontSize: 13,
                 // fontFamily: 'Circular Std',
                 fontWeight: FontWeight.w300,
               ),
             ),
           )
         ],
       ),
          const SizedBox(height: 5),
          Container(
              height: 220,
              width: double.maxFinite,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: Color(0xFFF6F6F6)),
              child:Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        model.navigateToProductDescription(model.niftyDeals[0]['id'] as int);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          padding: const  EdgeInsets.all(4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.maxFinite,
                                height: 135,
                                alignment: Alignment.topRight,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                                  image: DecorationImage(
                                    image: AssetImage('${model.niftyDeals[0]["image"]}'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Padding(
                                  padding:  const EdgeInsets.only(right: 5,top: 3),
                                  child: GestureDetector(
                                    onTap: (){
                                      //add to favourites
                                    },
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.grey.withOpacity(0.2),
                                      child: Icon(Icons.star_border_purple500_outlined,color: Colors.white,size: 20),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height:10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:80,
                                    child: Text(
                                      '${model.niftyDeals[0]["title"]}',
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        // fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${model.niftyDeals[0]["price"]}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width:80,
                                child: Text(
                                    '${model.niftyDeals[0]["subtitle"]}',
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Color(0xFF494949),
                                      fontSize: 11,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        model.navigateToProductDescription(model.niftyDeals[1]['id'] as int);
                      },
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        padding: const  EdgeInsets.all(4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 135,
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                                image: DecorationImage(
                                  image: AssetImage('${model.niftyDeals[1]["image"]}'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Padding(
                                padding:  const EdgeInsets.only(right: 5,top: 3),
                                child: GestureDetector(
                                  onTap: (){
                                    //add to favourites
                                  },
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.grey.withOpacity(0.2),
                                    child: Icon(Icons.star_border_purple500_outlined,color: Colors.white,size: 20),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height:10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:80,
                                  child: Text(
                                    '${model.niftyDeals[1]["title"]}',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${model.niftyDeals[1]["price"]}',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    // fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width:80,
                              child: Text(
                                  '${model.niftyDeals[1]["subtitle"]}',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0xFF494949),
                                    fontSize: 11,
                                    // fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
              )
        ],
      );
  }

  Widget galoreDeals(HomeViewModel model) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Galore Deals',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  // fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: (){
                //see more galore deals
                model.navigateToSeeAllDealsView(3, 'Galore Deals');

              },
              child: Text(
                'See more',
                style: TextStyle(
                  color: Palette.primaryColor,
                  fontSize: 13,
                  // fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Container(
          height: 360,
            width: double.maxFinite,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Color(0xFFF6F6F6)),
            child:
            GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
               // physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing:10.0,
                    mainAxisSpacing: 3.0,
                    childAspectRatio:1.2),
                itemCount: model.galoreDeals.length,
                itemBuilder: (BuildContext context, int index) {
                  Map galoreDeal = model.galoreDeals[index];
                  return InkWell(
                    onTap: (){
                      model.navigateToProductDescription(galoreDeal['id'] as int);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        padding: const  EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 130,
                              height: 120,
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                                image: DecorationImage(
                                  image: AssetImage(galoreDeal["image"] ?? ''),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Padding(
                               padding:  const EdgeInsets.only(right: 5,top: 3),
                                child: GestureDetector(
                                  onTap: (){
                                    //add to favourites
                                  },
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.grey.withOpacity(0.2),
                                    child: Icon(Icons.star_border_purple500_outlined,color: Colors.white,size: 17),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height:10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:60,
                                  child: Text(
                                    galoreDeal["title"] ?? '',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  galoreDeal["price"] ?? '',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    // fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width:60,
                              child: Text(
                                  galoreDeal["subtitle"] ?? '',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0xFF494949),
                                    fontSize: 9,
                                    // fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ],
    );
  }

  Widget megaDeals(HomeViewModel model){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Mega Deals',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      // fontFamily: 'Circular Std',
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 4),
                Countdown(
                  seconds: 10000,
                  build: (BuildContext context, double time) => Text(
                    "${model.intToTime(time.toInt())}s",
                    style:  TextStyle(fontSize: 14,color: Palette.primaryColor),
                  ),
                  interval: const Duration(seconds: 1),
                  controller: model.countdownController,
                  onFinished: () {
                    //
                  },
                ),

              ],
            ),
            InkWell(
              onTap: (){
                //see more mega deals
                model.navigateToSeeAllDealsView(4, 'Mega Deals');
              },
              child: Text(
                'See more',
                style: TextStyle(
                  color: Palette.primaryColor,
                  fontSize: 13,
                  // fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Container(
            height: 220,
            width: double.maxFinite,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Color(0xFFF6F6F6)),
            child:
            ListView.builder(
                itemCount: model.megaDeals.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  Map megaDeal = model.megaDeals[index];

                  return InkWell(
                    onTap: (){
                      model.navigateToProductDescription(megaDeal['id'] as int);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        padding: const  EdgeInsets.all(4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 133,
                              height: 135,
                                alignment: Alignment.topRight,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                                image: DecorationImage(
                                  image: AssetImage(megaDeal["image"] ?? ''),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Padding(
                                padding:  const EdgeInsets.only(right: 5,top: 3),
                                child: GestureDetector(
                                  onTap: (){
                                    //add to favourites
                                  },
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.grey.withOpacity(0.2),
                                    child: Icon(Icons.star_border_purple500_outlined,color: Colors.white,size: 20),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height:10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:80,
                                  child: Text(
                                    megaDeal["title"] ?? '',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  megaDeal["price"] ?? '',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    // fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width:80,
                              child: Text(
                                  megaDeal["subtitle"] ?? '',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0xFF494949),
                                    fontSize: 11,
                                    // fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ],
    );
  }

  Widget optimumDeals(HomeViewModel model){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Optimum Deals',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  // fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: (){
                //see more optimum deals
                model.navigateToSeeAllDealsView(5, 'Optimum Deals');
              },
              child: Text(
                'See more',
                style: TextStyle(
                  color: Palette.primaryColor,
                  fontSize: 13,
                  // fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Container(
            height: 220,
            width: double.maxFinite,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Color(0xFFF6F6F6)),
            child:
            ListView.builder(
                itemCount: model.optimumDeals.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  Map optimumDeal = model.optimumDeals[index];

                  return InkWell(
                    onTap: (){
                      model.navigateToProductDescription(optimumDeal['id'] as int);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        padding: const  EdgeInsets.all(4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 133,
                              height: 135,
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                                image: DecorationImage(
                                  image: AssetImage(optimumDeal["image"] ?? ''),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Padding(
                                padding:  const EdgeInsets.only(right: 5,top: 3),
                                child: GestureDetector(
                                  onTap: (){
                                    //add to favourites
                                  },
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.grey.withOpacity(0.2),
                                    child: Icon(Icons.star_border_purple500_outlined,color: Colors.white,size: 20),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height:10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:80,
                                  child: Text(
                                    optimumDeal["title"] ?? '',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  optimumDeal["price"] ?? '',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    // fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width:80,
                              child: Text(
                                  optimumDeal["subtitle"] ?? '',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0xFF494949),
                                    fontSize: 11,
                                    // fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ],
    );
  }

  Widget jollyDeals(HomeViewModel model){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Jolly Deals',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  // fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: (){
                //see more jolly deals
                model.navigateToSeeAllDealsView(6, 'Jolly Deals');
              },
              child: Text(
                'See more',
                style: TextStyle(
                  color: Palette.primaryColor,
                  fontSize: 13,
                  // fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Container(
            height: 220,
            width: double.maxFinite,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Color(0xFFF6F6F6)),
            child:
            ListView.builder(
                itemCount: model.jollyDeals.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  Map jollyDeal = model.jollyDeals[index];

                  return InkWell(
                    onTap: (){
                      model.navigateToProductDescription(jollyDeal['id'] as int);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        padding: const  EdgeInsets.all(4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 133,
                              height: 135,
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                                image: DecorationImage(
                                  image: AssetImage(jollyDeal["image"] ?? ''),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Padding(
                                padding:  const EdgeInsets.only(right: 5,top: 3),
                                child: GestureDetector(
                                  onTap: (){
                                    //add to favourites
                                  },
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.grey.withOpacity(0.2),
                                    child: Icon(Icons.star_border_purple500_outlined,color: Colors.white,size: 20),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height:10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:80,
                                  child: Text(
                                    jollyDeal["title"] ?? '',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  jollyDeal["price"] ?? '',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    // fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width:80,
                              child: Text(
                                  jollyDeal["subtitle"] ?? '',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0xFF494949),
                                    fontSize: 11,
                                    // fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ],
    );
  }

  Widget superStores(HomeViewModel model){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Super Stores',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  // fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Color(0xFFF6F6F6)),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onTap:(){
                      model.navigateToStoreView(1, 'Hitch Global');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Hitch Globals',textAlign: TextAlign.center,style: TextStyle(color: Palette.primaryColor,fontSize: 16,fontWeight: FontWeight.w600)),
                    )),
                Container(
                    height: 220,
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: Color(0xFFF6F6F6)),
                    child:
                    ListView.builder(
                        itemCount: model.superStores1.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index){
                          Map superStores1 = model.superStores1[index];

                          return InkWell(
                            onTap: (){
                              model.navigateToProductDescription(superStores1['id'] as int);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(16))
                                ),
                                padding: const  EdgeInsets.all(4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 133,
                                      height: 135,
                                      alignment: Alignment.topCenter,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                                        image: DecorationImage(
                                          image: AssetImage(superStores1["image"] ?? ''),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Padding(
                                        padding:  const EdgeInsets.only(right: 5,top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                            padding: const EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topRight:Radius.circular(14),bottomRight: Radius.circular(14))
                                            ),
                                            child: Text(
                                            '${superStores1["discount"]} off',
                                            style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            )),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                //add to favourites
                                              },
                                              child: CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Colors.grey.withOpacity(0.2),
                                                child: Icon(Icons.star_border_purple500_outlined,color: Colors.white,size: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height:10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:80,
                                          child: Text(
                                            superStores1["title"] ?? '',
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              // fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          superStores1["price"] ?? '',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            // fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width:80,
                                      child: Text(
                                          superStores1["subtitle"] ?? '',
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Color(0xFF494949),
                                            fontSize: 11,
                                            // fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w500,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                const SizedBox(height: 20),
                InkWell(
                    onTap:(){
                      model.navigateToStoreView(1, 'Techy Store');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Techy Store',textAlign: TextAlign.center,style: TextStyle(color: Palette.primaryColor,fontSize: 16,fontWeight: FontWeight.w600)),
                    )),
                Container(
                    height: 220,
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: Color(0xFFF6F6F6)),
                    child:
                    ListView.builder(
                        itemCount: model.superStores2.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index){
                          Map superStores2 = model.superStores2[index];

                          return InkWell(
                            onTap: (){
                              model.navigateToProductDescription(superStores2['id'] as int);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(16))
                                ),
                                padding: const  EdgeInsets.all(4),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 133,
                                      height: 135,
                                      alignment: Alignment.topCenter,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                                        image: DecorationImage(
                                          image: AssetImage(superStores2["image"] ?? ''),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Padding(
                                        padding:  const EdgeInsets.only(right: 5,top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(4.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(topRight:Radius.circular(14),bottomRight: Radius.circular(14))
                                              ),
                                              child: Text(
                                                  '${superStores2["discount"]} off',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                //add to favourites
                                              },
                                              child: CircleAvatar(
                                                radius: 12,
                                                backgroundColor: Colors.grey.withOpacity(0.2),
                                                child: Icon(Icons.star_border_purple500_outlined,color: Colors.white,size: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height:10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:80,
                                          child: Text(
                                            superStores2["title"] ?? '',
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              // fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          superStores2["price"] ?? '',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            // fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width:80,
                                      child: Text(
                                          superStores2["subtitle"] ?? '',
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Color(0xFF494949),
                                            fontSize: 11,
                                            // fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w500,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
            ]))
      ],
    );

  }

  Widget dandyDeals(HomeViewModel model){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dandy Deals',
          style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              // fontFamily: 'Circular Std',
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 1),
        FlutterCarousel(
          options: CarouselOptions(
              pauseAutoPlayOnTouch: false,
              padEnds: false,
              floatingIndicator: true,
              slideIndicator: CircularSlideIndicator(
                alignment: Alignment.bottomCenter,
                itemSpacing: 9,
                indicatorRadius: 4.0,
                currentIndicatorColor: Palette.primaryColor,
                indicatorBackgroundColor:  Colors.grey.withOpacity(0.3),
              ),
              height: 225,
              aspectRatio: 3 / 2,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              // autoPlayCurve: Curves.elasticInOut,
              reverse: false,
              // enlargeCenterPage: true,
              onPageChanged: (index, reason) {},
              scrollDirection: Axis.horizontal),
          items: model.dandyDeals.map((i) {
            return Builder(builder: (BuildContext context) {
              return InkWell(
                highlightColor: Palette.primaryColor.withOpacity(0.1),
                onTap: () {
                  model.navigateToProductDescription(i['id'] as int);
                },
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 10, right: 10, bottom: 8,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: double.maxFinite,
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.grey.withOpacity(0.1),
                            image: DecorationImage(
                              image: AssetImage('${i['image']}'), fit: BoxFit.fill,
                            ),
                          ),
                          child:Container(
                            width: double.maxFinite,
                            height: 190,
                            padding: const EdgeInsets.all(20),
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              color: Colors.black.withOpacity(0.1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${i['title']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        // fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      '${i['subtitle']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        //fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${i['price']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    //fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              );
            });
          }).toList(),
        ),
      ],
    );
  }

  Widget trending(HomeViewModel model){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending Products',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  // fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: (){
                //see more trending
                //model.navigateToSeeAllDealsView(3, 'Galore Deals');

              },
              child: Text(
                'See more',
                style: TextStyle(
                  color: Palette.primaryColor,
                  fontSize: 13,
                  // fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Color(0xFFF6F6F6)),
            child:
            GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                 physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing:10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio:0.9),
                itemCount: model.trending.length,
                itemBuilder: (BuildContext context, int index) {
                  Map trending = model.trending[index];
                  return InkWell(
                    onTap: (){
                      model.navigateToProductDescription(trending['id'] as int);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16))
                        ),
                        padding: const  EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              height: 120,
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
                                image: DecorationImage(
                                  image: AssetImage(trending["image"] ?? ''),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Padding(
                                padding:  const EdgeInsets.only(right: 5,top: 3),
                                child: GestureDetector(
                                  onTap: (){
                                    //add to favourites
                                  },
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.grey.withOpacity(0.2),
                                    child: Icon(Icons.star_border_purple500_outlined,color: Colors.white,size: 17),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height:10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:80,
                                  child: Text(
                                    trending["title"] ?? '',
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  trending["price"] ?? '',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    // fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width:80,
                              child: Text(
                                  trending["subtitle"] ?? '',
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Color(0xFF494949),
                                    fontSize: 9,
                                    // fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ],
    );  }
}