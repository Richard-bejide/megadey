import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megadey_mobile/core/enums/toast_type.dart';
import 'package:megadey_mobile/core/utilities/functions/toast.dart';
import 'package:megadey_mobile/core/utilities/widgets/rounded_button.dart';
import 'package:megadey_mobile/views/product_description/product_description_viewmodel.dart';
import 'package:megadey_mobile/views/seller_page/seller_page_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/constants/colors.dart';
import '../../core/services/utility_storage_service.dart';
import '../../core/utilities/functions/modal_sheet.dart';
import '../../core/utilities/widgets/request_authentication_widget.dart';
import '../../core/utilities/widgets/text_field.dart';
import '../../core/utilities/widgets/webview_screen.dart';



class ProductDescriptionView extends StatelessWidget {
  static const routeName = 'productDescriptionView';

  const  ProductDescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductDescriptionViewModel>.reactive(
        onViewModelReady: (model) => model.setup(context),
        viewModelBuilder: () => ProductDescriptionViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
              backgroundColor: Color(0xFFF6F6F6),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        appBar(model,context),
                        Expanded(
                          child: SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: false,
                            onRefresh: () async {
                              model.refresh();
                            },
                            header: const WaterDropMaterialHeader(),
                            controller: model.refreshController,
                            child:SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  imagesCarousel(model),
                                  const SizedBox(height: 20),
                                  otherImages(model),
                                  const SizedBox(height: 20),
                                  productDescription(context, model),
                                  const SizedBox(height: 30),
                                  offerAndChat(context),
                                  const SizedBox(height: 40),
                                  categoryDetails(context, model),
                                  const SizedBox(height: 20),
                                  about(context, model),
                                  const SizedBox(height: 20),
                                  sellerDetails(context, model),
                                  const SizedBox(height: 30),
                                  safetyTips(context),
                                  const SizedBox(height: 20),
                                   postAd(context),
                                  const SizedBox(height: 50),
                                  similarProducts(model),
                                  const SizedBox(height: 40),
                                ],
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            )));
  }

  Widget appBar(ProductDescriptionViewModel model,BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back,color: Colors.black,size: 24),
                    const SizedBox(width: 5),
                    Text('Product Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      )),
                  ],
                ),
              ),
              Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  //share product
                  Share.share('www.megadey.com/product_id/232000');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 4.0),
                  child: SvgPicture.asset('assets/icons/share.svg',
                      height: 18, color: Palette.primaryColor),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  //add to favourite
                  model.addToFavourites = !model.addToFavourites;
                  model.notifyListeners();
                  model.addToFavourites
                  ? showToast(context: context, message: 'Added to Wishlist', messageType: ToastMessageType.info)
                  : showToast(context: context, message: 'Removed from Wishlist', messageType: ToastMessageType.info);

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 4.0),
                  child: model.addToFavourites
                      ? Icon(Icons.star,color: Palette.primaryColor,size: 20)
                      : SvgPicture.asset('assets/icons/add_favourite.svg',
                    height: 30,
                    //color: Palette.primaryColor
                  ),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 4.0),
                  child: Icon(Icons.report_gmailerrorred_rounded,color: Palette.primaryColor,size: 20)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget imagesCarousel(ProductDescriptionViewModel model){
    return FlutterCarousel(
      options: CarouselOptions(
        scrollPhysics: ClampingScrollPhysics(),
          pauseAutoPlayOnTouch: true,
          padEnds: false,
          floatingIndicator: true,
          slideIndicator: CircularSlideIndicator(
            alignment: Alignment.bottomCenter,
            itemSpacing: 9,
            indicatorRadius: 4.0,
            currentIndicatorColor: Colors.white,
            indicatorBackgroundColor:  Colors.white.withOpacity(0.3),
          ),
          height: 200,
          aspectRatio: 3 / 2,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          // autoPlayCurve: Curves.elasticInOut,
          reverse: false,
          // enlargeCenterPage: true,
          onPageChanged: (index, reason) {},
          carouselController: model.carouselController,
          scrollDirection: Axis.horizontal),
      items: model.productImages.map((i) {
        return Builder(builder: (BuildContext context) {
          return GestureDetector(
            onTap: (){
              showImages(context);
            },
            child: Container(
                  width: double.maxFinite,
                  height: 176,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    image: DecorationImage(
                      image: AssetImage('${i['image']}'),
                      fit: BoxFit.cover,
                    ),
                  ),
              child: Container(
                width: double.maxFinite,
                height: 176,
                decoration: BoxDecoration(
                  gradient:  LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.2),
                    ],
                  )
                ),
              ),
                ),
          );
        });
      }).toList(),
    );
  }

  Widget otherImages(ProductDescriptionViewModel model){
    return Container(
      height: 100,
      child: ListView.builder(
                  itemCount: model.productImages.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    Map productImage = model.productImages[index];

                    return GestureDetector(
                      onTap: (){
                        model.carouselController?.animateToPage(index,duration: const Duration(milliseconds: 200));
                        model.notifyListeners();
                        showImages(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                                width: 113,
                                height: 90,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(productImage["image"] ?? ''),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                      ),
                    );
                  }),
    );
  }

  Widget productDescription(BuildContext context,ProductDescriptionViewModel model){
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth * 0.55,
                  child: Text(
                    model.title ?? 'Null',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      // fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  model.price ?? 'Null',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    // fontFamily: 'DM Sans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_outlined,size: 16,color: Color(0xFFA09E9E)),
                    const SizedBox(width: 2),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth:screenWidth * 0.3),
                      child: Text(
                        model.location ?? 'Null',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Color(0xFFA09E9E),
                          fontSize:13,
                          // fontFamily: 'Circular Std',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.access_time,size: 16,color: Color(0xFFA09E9E)),
                    const SizedBox(width: 2),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth:screenWidth * 0.3),
                      child: Text(
                        'posted ${model.timePosted}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: Color(0xFFA09E9E),
                          fontSize:13,
                          // fontFamily: 'Circular Std',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(2))
              ),
              child: Text(
                'Promoted',
                style: TextStyle(
                  color: Color(0xFFA09E9E),
                  fontSize:11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ]);
  }

  Widget offerAndChat(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Palette.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              ),
              onPressed: (){
                if(StorageService().getBool('isLoggedIn') == true){
                  modalSheetWidget(
                    context: context,
                    title: const Text(
                      'Make Offer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    subtitle: const Text(
                      'How much do you want to offer for this product?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    content: Column(
                        children: [
                          const SizedBox(height: 10.0),
                          CustomTextBox(
                            keyBoardType: TextInputType.number,
                            hintText: '',
                            labelText: '',
                            //controller: model.offerController
                            onTap: () {

                            },
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Palette.primaryColor,
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                  ),
                                  onPressed: (){},
                                  child: Text('30,000',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ))),
                              const SizedBox(width: 5),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side:BorderSide(color: Palette.primaryColor,width: 2),
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                  ),
                                  onPressed: (){},
                                  child: Text('28,000',
                                      style: TextStyle(
                                        color: Palette.primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ))),
                            ],
                          ),
                          const SizedBox(height: 50.0),
                          CustomButton(
                              title: 'Make Offer',
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              buttonColor: Palette.primaryColor,
                              textColor: Colors.white),
                          const SizedBox(height: 20.0),
                        ]),
                  );
                }else{
                  RequestAuthenticationModal(context);
                }
                    },
              child: Text('Make an offer',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ))),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: TextButton(
              style: TextButton.styleFrom(
                side: BorderSide(
                    width: 1, color: Palette.primaryColor),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
              ),
              onPressed: (){
                if(StorageService().getBool('isLoggedIn') == true){
                  modalSheetWidget(
                    context: context,
                    title: const Text(
                      'Chat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    subtitle: const Text(
                      'Send a quick message to this vendor',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    content: Column(
                        children: [
                          const SizedBox(height: 10.0),
                          CustomTextBox(
                            hintText: '',
                            labelText: '',
                            //controller: model.chatController
                            onTap: () {},
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Palette.primaryColor,
                                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                    ),
                                    onPressed: (){},
                                    child: Text('is it still available?',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ))),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side:BorderSide(color: Palette.primaryColor,width: 2),
                                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                    ),
                                    onPressed: (){},
                                    child: Text('What\'s the last price',
                                        style: TextStyle(
                                          color: Palette.primaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50.0),
                          CustomButton(
                              title: 'Send Message',
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              buttonColor: Palette.primaryColor,
                              textColor: Colors.white),
                          const SizedBox(height: 8.0),
                        ]),
                  );
                }else{
                  RequestAuthenticationModal(context);
                }
                },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/start_chat.svg',color: Palette.primaryColor,height: 15),
                  const SizedBox(width: 6),
                  Text('Start a chat',
                      style: TextStyle(
                        color:Palette.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      )),
                ],
              )),
        ),
      ],
    );
  }

  Widget categoryDetails(BuildContext context,ProductDescriptionViewModel model){
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                       'Gender',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          // fontFamily: 'Circular Std',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                       'Male',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          // fontFamily: 'Circular Std',
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ]),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: screenWidth * 0.4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(
                          'Material',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            // fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Leather',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            // fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: screenWidth * 0.4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(
                          'Size',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            // fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '41,42,43,44,45',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            // fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ]),
                ),
              ]),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * 0.4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:[
                        Text(
                          'Brand',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            // fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Nike',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            // fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ]),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: screenWidth * 0.4,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:[
                        Text(
                          'Condition',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            // fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'New',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            // fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ]),
                ),
              ]),
        ],
      ),
    );
  }

  Widget about(BuildContext context,ProductDescriptionViewModel model){
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text(
              'Product description',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                // fontFamily: 'Circular Std',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae nunc ac elit pellentesque placerat. Morbi velit odio, scelerisque laoreet fermentum et, molestie quis purus. Vestibulum.',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height:1.8,
                // fontFamily: 'Circular Std',
                fontWeight: FontWeight.w200,
              ),
            ),
          ])
    );
  }

   Widget sellerDetails(BuildContext context, ProductDescriptionViewModel model){
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(StorageService().getBool('isLoggedIn') == true){
                        NavigationService().navigateTo(SellerPageView.routeName);
                      }else{
                        RequestAuthenticationModal(context);
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      backgroundImage: AssetImage(model.sellerImg ?? ''),
                      radius: 25,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 150),
                        child: Text(
                          model.sellerName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            // fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: ShapeDecoration(
                          color: Color(0xFFF3E8FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline,color: Colors.black54,size: 14),
                            const SizedBox(width: 2),
                            Text(
                              '${model.accountCreatedOn} on Megadey',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 11,
                                // fontFamily: 'Circular Std',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: ShapeDecoration(
                  color: Color(0xFFF0FDF4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.verified_outlined,color: Colors.black54,size: 14),
                    const SizedBox(width: 2),
                    Text(
                      'Verified',
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 11,
                        // fontFamily: 'Circular Std',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    //
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: ShapeDecoration(
                      color: Color(0xFFD8B4FE),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      SvgPicture.asset('assets/icons/phone.svg',color: Colors.black87,height: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Request a Call back',
                          style: TextStyle(
                            color: Color(0xFF070009),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    //
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: Palette.primaryColor)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icons/phone.svg',color: Palette.primaryColor,height: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Contact Seller',
                          style: TextStyle(
                            color: Palette.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/icons/verified_seller.svg',height: 15,color: Palette.primaryColor),
                  const SizedBox(width: 5),
                  Text(
                    'Verified vendor',
                    style: TextStyle(
                      color: Palette.primaryColor,
                      fontSize: 11,
                      // fontFamily: 'Circular Std',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              const SizedBox(width: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/icons/verified_seller.svg',height: 15,color: Palette.primaryColor),
                  const SizedBox(width: 5),
                  Text(
                    'Replies fast',
                    style: TextStyle(
                      color: Palette.primaryColor,
                      fontSize: 11,
                      // fontFamily: 'Circular Std',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: (){
              //
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Palette.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/start_chat.svg',color: Colors.white,height: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Follow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/icons/verified_seller.svg',height: 15,color: Palette.primaryColor),
                  const SizedBox(width: 5),
                  Text(
                    '767 Following',
                    style: TextStyle(
                      color: Palette.primaryColor,
                      fontSize: 11,
                      // fontFamily: 'Circular Std',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              const SizedBox(width: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/icons/verified_seller.svg',height: 15,color: Palette.primaryColor),
                  const SizedBox(width: 5),
                  Text(
                    '2042 Followers',
                    style: TextStyle(
                      color: Palette.primaryColor,
                      fontSize: 11,
                      // fontFamily: 'Circular Std',
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ],
          )

        ],
      ),
    );
   }

  Widget safetyTips(BuildContext context){
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(4))
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(
                'Safety Tips',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  // fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 250,
                    child: Text(
                      'Do not trust information or deals that are unrealistic',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        // fontFamily: 'Circular Std',
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 250,
                    child: Text(
                      'Deal with verified users who already have a strong rating and reviews',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        // fontFamily: 'Circular Std',
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 250,
                    child: Text(
                      'If it’s high value items or high-priced deal or business, be specifically cautious',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        // fontFamily: 'Circular Std',
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 250,
                    child: Text(
                      'Do not give out financial or any other information',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        // fontFamily: 'Circular Std',
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 2,
                    backgroundColor: Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 250,
                    child: Text(
                      'When you are going about the transaction, make sure that you involve a trusted friend or family member',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        // fontFamily: 'Circular Std',
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: (){
                    NavigationService().navigateToView(WebViewScreen(url: 'https://megadey-95be8.web.app/safety-tips'));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Read More',
                      style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        // fontFamily: 'Circular Std',
                        fontWeight: FontWeight.w200,
                      ),
                  ),
                ),
                ))
            ])
    );
  }

  Widget postAd(BuildContext context){
    return   TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Palette.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
          ),
          onPressed: (){
            if(StorageService().getBool('isLoggedIn') == true){
              //NavigationService().navigateTo(SellerPageView.routeName);
            }else{
              RequestAuthenticationModal(context);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/post_ad.svg',color: Colors.white,height: 18),
              const SizedBox(width: 10),
              Text('Post an Ad',
                  style: TextStyle(
                    color:Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  )),
            ],
          ),
    );
  }

  Widget similarProducts(ProductDescriptionViewModel model){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Similar Products',
          style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              // fontFamily: 'Circular Std',
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
              itemCount: model.similarProducts.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index){
                Map similarProduct = model.similarProducts[index];
                return GestureDetector(
                  onTap: (){
                    model.navigateToProductDescription(similarProduct['id']);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 130,
                            height: 120,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(similarProduct["image"] ?? ''),
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
                                  SizedBox(
                                    width:120,
                                    child: Text(
                                      similarProduct["title"] ?? '',
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        // fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  SizedBox(
                                    width:120,
                                    child: Text(
                                        " ${similarProduct["subtitle"]}",
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
                                  SizedBox(
                                    width:120,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.location_on_outlined,size:13,color: Palette.customGrey),
                                        Text(
                                            similarProduct["location"] ?? '',
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
                                similarProduct["price"] ?? '',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Palette.primaryColor,
                                  fontSize: 14,
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
                );
              }),
        )
      ],
    );
  }


  void showImages(BuildContext context){
    print('tapped');
    MultiImageProvider multiImageProvider = MultiImageProvider([
      Image.asset("assets/images/product1.png",height: 300,width: double.maxFinite).image,
      Image.asset("assets/images/product2.png",height: 300,width: double.maxFinite).image,
      Image.asset("assets/images/product3.png",height: 300,width: double.maxFinite).image,
      Image.asset("assets/images/product1.png",height: 300,width: double.maxFinite).image,
    ]);

    showImageViewerPager(
        context,
        multiImageProvider,
        useSafeArea: true,
        doubleTapZoomable: false,
        immersive: false,
        onPageChanged: (page) {
      print("page changed to $page");
    }, onViewerDismissed: (page) {
      print("dismissed while on page $page");
    });
  }

}