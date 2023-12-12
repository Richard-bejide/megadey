import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megadey_mobile/views/seller_page/seller_page_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/constants/colors.dart';
import '../product_description/product_description_view.dart';
import '../product_description/product_description_viewmodel.dart';


class SellerPageView extends StatelessWidget {
  static const routeName = 'sellerPageView';

  const SellerPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ViewModelBuilder<SellerPageViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => SellerPageViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
                backgroundColor: Color(0xFFF6F6F6),
                body: SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          appBar(model, context),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Image.asset('assets/images/seller_banner.png',height: 140,width: 340),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: Palette.primaryColor,
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                              ),
                                              onPressed:(){},
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset('assets/icons/phone.svg',color: Colors.white,height: 15),
                                                  const SizedBox(width: 6),
                                                  Text('Contact vendor',
                                                      style: TextStyle(
                                                        color:Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 15,
                                                      )),
                                                ],
                                              )),
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
                                              onPressed:(){},
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
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                      SvgPicture.asset('assets/icons/location2.svg',height: 25),
                                        const SizedBox(width: 5),
                                        Text(
                                          'ayojones@gmail.com',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            // fontFamily: 'Circular Std',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ]),
                                    const SizedBox(height: 10),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/icons/email.svg',height: 25),
                                          const SizedBox(width: 5),
                                          Text(
                                            'Ikeja, Lagos',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              // fontFamily: 'Circular Std',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )

                                        ]),
                                    const SizedBox(height: 15),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(4))
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                              onTap:(){},
                                              child: SvgPicture.asset('assets/icons/facebook.svg',height: 30)),
                                          const SizedBox(width: 30),
                                          GestureDetector(
                                              onTap:(){},
                                              child: SvgPicture.asset('assets/icons/twitter.svg',height: 30)),
                                          const SizedBox(width: 30),
                                          GestureDetector(
                                              onTap:(){},
                                              child: Image.asset('assets/images/instagram.png',height: 33)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    products(model)
                                  ],
                                ),
                              ),
                            ),
                          )
                         ])))));
  }

  Widget appBar(SellerPageViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_outlined, color: Colors.black, size: 20),
                  const SizedBox(width: 4),
                  CircleAvatar(
                      radius: 22,
                      backgroundColor: Palette.primaryColor.withOpacity(0.1),
                      backgroundImage: AssetImage('assets/images/messages4.png')),
                  const SizedBox(width: 8),
                  Text(
                    'Sarah Ayo',
                    style: TextStyle(
                      color: Color(0xFF222121),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.27,
                    ),
                  )
                ]),
          ),
          GestureDetector(
              onTap: () {},
              child: SvgPicture.asset('assets/icons/share.svg',
                  color: Palette.primaryColor, height: 20))
        ],
      ),
    );
  }

  Widget products(SellerPageViewModel model){
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Listed Products',
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
              itemCount: model.products.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index){
                Map product = model.products[index];
                return InkWell(
                  highlightColor: Palette.primaryColor.withOpacity(0.1),
                  onTap: (){
                    ProductDescriptionViewModel.id = product['id'];
                    NavigationService().navigateTo(ProductDescriptionView.routeName);                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 5.0),
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
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
                                image: AssetImage(product["image"] ?? ''),
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
                                      product["title"] ?? '',
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
                                        " ${product["subtitle"]}",
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
                                            product["location"] ?? '',
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
                                product["price"] ?? '',
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

}
