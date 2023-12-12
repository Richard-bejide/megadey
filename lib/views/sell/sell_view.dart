import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:megadey_mobile/core/utilities/widgets/rounded_button.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:megadey_mobile/views/dashboard/dashboard_view.dart';
import 'package:megadey_mobile/views/sell/sell_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/constants/colors.dart';
import '../../core/utilities/widgets/text_field.dart';

class SellView extends StatelessWidget {
  static const routeName = 'sellView';

   SellView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SellViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => SellViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
                backgroundColor: Palette.backgroundColor,
                body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            appBar(model, context),
                            const SizedBox(height: 20),
                            stepper(model, context),
                            const SizedBox(height: 10),
                            Expanded(
                              child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(0),
                                  child: getView(model, context)),
                            ),
                          ]),
                    ))
            )));
  }

  Widget getView(SellViewModel model,BuildContext context){
    if(model.currentPage == 3){
      return submitView(model, context);
    } else if(model.currentPage == 2){
      return addDetailsView(model, context);
    }else if(model.currentPage == 1){
      return addImagesView(model, context);
    }
    else{
      return selectCategoryView(model,context);
    }
  }

  Widget selectCategoryView(SellViewModel model,BuildContext context){
    return Column(children: [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
          decoration:BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4))
          ) ,
          child: dropDown(
              context: context,
              model: model,
              title: 'Category',
              value: model.selectedCategory,
              onTap: (){
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    constraints: const BoxConstraints(maxHeight: 600, minHeight: 600),
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
                        return ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(0),
                              topLeft: Radius.circular(0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              width: double.infinity,
                              child: SizedBox(
                                height: 600,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 10),
                                const Text(
                                  'Category',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Please, choose one of the following \ncategory for your product',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                    const SizedBox(height: 15),
                                    Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: model.categories.length,
                                      itemBuilder: (BuildContext context, int index){
                                        return  Padding(
                                          padding: const EdgeInsets.only(bottom: 5.0),
                                          child: GestureDetector(
                                              onTap: (){
                                                model.selectedCategory = model.categories[index]['title'] as String;
                                                model.selectedCategoryIndex = index;
                                                model.notifyListeners();
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.symmetric(vertical: 20),
                                                decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
                                                child: Text(
                                                  model.categories[index]['title'] as String,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              )),
                                        );
                                      }),
                                ),

                        ]))));
                      });
                    });
            },
          )),
      model.selectedCategoryIndex != null
          ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
          decoration:BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4))
          ) ,
          child: dropDown(
            context: context,
            model: model,
            title: 'Sub-category',
            value: model.selectedSubcategory,
            onTap: (){
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  constraints: const BoxConstraints(maxHeight: 600, minHeight: 600),
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
                      return ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(0),
                            topLeft: Radius.circular(0),
                          ),
                          child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              width: double.infinity,
                              child: SizedBox(
                                  height: 600,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Sub-category',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          'Please, choose one of the following \nsub-category for your product',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(height: 15),
                                        Expanded(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: model.getSubCategories().length,
                                              itemBuilder: (BuildContext context, int index){
                                                Map<String, Object> subcategory = model.getSubCategories()[index];

                                                return  Padding(
                                                  padding: const EdgeInsets.only(bottom: 5.0),
                                                  child: GestureDetector(
                                                      onTap: (){
                                                        model.selectedSubcategory = subcategory['title'] as String;
                                                        model.notifyListeners();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                                        decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
                                                        child: Text(
                                                          '${subcategory['title']}',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      )),
                                                );
                                              }),
                                        ),

                                      ]))));
                    });
                  });
            },
          ))
          : const SizedBox(),
      const SizedBox(height: 40),
      CustomButton(
          title: 'Next',
          onPressed: (){
            if(model.selectedCategory != null && model.selectedSubcategory != null) {
              model.currentPage = 1;
              model.notifyListeners();
            }else{
              Fluttertoast.showToast(msg: 'Select category/sub-category',backgroundColor: Colors.red);
            }
          },
          buttonColor: Palette.primaryColor,
          textColor: Colors.white),
      const SizedBox(height: 50),

    ]);
  }

  Widget addImagesView(SellViewModel model,BuildContext context){
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Feature image',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.28,
            ),
          ),
          Text(
            '(Only for customers on Jumbo and Dandy deals)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.all(15),
            width: double.maxFinite,
           decoration: ShapeDecoration(
           color: Color(0x0CBA00DA),
           shape: RoundedRectangleBorder(
           side: BorderSide(width: 1, color: Color(0xFFBB00DA)),
             )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  SvgPicture.asset('assets/icons/upload_product_image.svg',height: 40,color: Palette.primaryColor),
                  const SizedBox(height: 10),
                  Text(
                    'must not exceed 5 Mb\nSupported formats are *.jpg and *.png',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Palette.primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: CustomButton(title: 'Upload Image', onPressed: (){}, buttonColor: Palette.primaryColor, textColor: Colors.white),
                  )
                ],
              ),
            ),
          const SizedBox(height: 30),
          Text(
            'Product image',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.28,
            ),
          ),
          Text(
            '(Please upload up to 5 images)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
       Row(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
             GestureDetector(
             onTap: (){},
             child: Container(
             width: 50,
             height: 50,
             decoration: ShapeDecoration(
               color: Color(0x0CBA00DA),
               shape: RoundedRectangleBorder(
                 side: BorderSide(width: 0.81, color: Color(0xFFBB00DA)))),
             child: Icon(Icons.add,color: Palette.primaryColor,size: 30),
         )),
             const SizedBox(width: 4),
           GestureDetector(
               onTap: (){},
               child: Container(
                 width: 50,
                 height: 50,
                 decoration: ShapeDecoration(
                     color: Color(0x0CBA00DA),
                     shape: RoundedRectangleBorder(
                         side: BorderSide(width: 0.81, color: Color(0xFFBB00DA)))),
                 child: Icon(Icons.add,color: Palette.primaryColor,size: 30),
               )),
           const SizedBox(width: 4),
           GestureDetector(
               onTap: (){},
               child: Container(
                 width: 50,
                 height: 50,
                 decoration: ShapeDecoration(
                     color: Color(0x0CBA00DA),
                     shape: RoundedRectangleBorder(
                         side: BorderSide(width: 0.81, color: Color(0xFFBB00DA)))),
                 child: Icon(Icons.add,color: Palette.primaryColor,size: 30),
               )),
           const SizedBox(width: 4),
           GestureDetector(
               onTap: (){},
               child: Container(
                 width: 50,
                 height: 50,
                 decoration: ShapeDecoration(
                     color: Color(0x0CBA00DA),
                     shape: RoundedRectangleBorder(
                         side: BorderSide(width: 0.81, color: Color(0xFFBB00DA)))),
                 child: Icon(Icons.add,color: Palette.primaryColor,size: 30),
               )),
           const SizedBox(width: 4),
           GestureDetector(
               onTap: (){},
               child: Container(
                 width: 50,
                 height: 50,
                 decoration: ShapeDecoration(
                     color: Color(0x0CBA00DA),
                     shape: RoundedRectangleBorder(
                         side: BorderSide(width: 0.81, color: Color(0xFFBB00DA)))),
                 child: Icon(Icons.add,color: Palette.primaryColor,size: 30),
               )),
           ],
       ),
       const SizedBox(height: 20),
          Text(
            'Product video',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.28,
            ),
          ),
          Text(
            '(Please upload a video of the product)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
              onTap: (){},
              child: Container(
                width: 60,
                height: 60,
                decoration: ShapeDecoration(
                    color: Color(0x0CBA00DA),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.81, color: Color(0xFFBB00DA)))),
                child: Icon(Icons.video_file_outlined,color: Palette.primaryColor,size: 30),
              )),
          const SizedBox(height: 20),
      CustomButton(
          title: 'Next',
          onPressed: (){
              model.currentPage = 2;
              model.notifyListeners();
          },
          buttonColor: Palette.primaryColor,
          textColor: Colors.white),
      const SizedBox(height: 50),

    ]);
  }

  Widget addDetailsView(SellViewModel model,BuildContext context){
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextBox(
                    hintText: '',
                    labelText: 'Product Name',
                    validator: (inputValue) {
                      if (inputValue == null || inputValue.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    controller: model.productName),
                const SizedBox(height: 5),
                CustomTextBox(
                    hintText: '',
                    labelText: 'Product Details',
                    validator: (inputValue) {
                      if (inputValue == null || inputValue.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    controller: model.productDescription),
                const SizedBox(height: 5),
                CustomTextBox(
                    hintText: '',
                    labelText: 'Location',
                    validator: (inputValue) {
                      if (inputValue == null || inputValue.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    controller: model.location),
                const SizedBox(height: 5),
                CustomTextBox(
                    keyBoardType: TextInputType.number,
                    hintText: '',
                    labelText: 'Quantity',
                    validator: (inputValue) {
                      if (inputValue == null || inputValue.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    controller: model.quantity),
                const SizedBox(height: 5),
                CustomTextBox(
                   keyBoardType: TextInputType.number,
                    hintText: '',
                    labelText: 'Price',
                    validator: (inputValue) {
                      if (inputValue == null || inputValue.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    controller: model.price),
                GestureDetector(
                  onTap: (){
                    model.negotiablePrice = !model.negotiablePrice;
                    model.notifyListeners();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Icon(model.negotiablePrice ? Icons.check_circle_rounded : Icons.check_circle_outline,color:model.negotiablePrice ? Color(0xFFBB00DA) : Colors.grey,size: 18),
                        const SizedBox(width: 3),
                        Text(
                          'Negotiable',
                          style: TextStyle(
                            color: model.negotiablePrice ? Color(0xFFBB00DA) : Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.28,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                CustomTextBox(
                    keyBoardType: TextInputType.number,
                    hintText: '',
                    labelText: 'Discount',
                    validator: (inputValue) {
                      if (inputValue == null || inputValue.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    controller: model.discount),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Price after discount:',
                        style: TextStyle(
                          color: Color(0xFF6D6D6D),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.24,
                        ),
                      ),
                      TextSpan(
                        text: ' 580,000.00',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.24,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton(
                style: TextButton.styleFrom(
                  side: BorderSide(width: 1, color: Palette.primaryColor),
                  backgroundColor: model.newProduct ? Palette.primaryColor : Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                ),
                onPressed: (){
                  model.newProduct = true;
                  model.notifyListeners();
                },
                child: Text('New',
                    style: TextStyle(
                      color: model.newProduct ? Colors.white : Palette.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ))),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: TextButton(
                style: TextButton.styleFrom(
                  side: BorderSide(width: 1, color: Palette.primaryColor),
                  backgroundColor:  !model.newProduct ? Palette.primaryColor : Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                ),
                onPressed: (){
                  model.newProduct = false;
                  model.notifyListeners();
                },
                child:Text('Used',
                    style: TextStyle(
                      color:!model.newProduct ? Colors.white : Palette.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),),
          ),
        ],
      )
    ])),
        const SizedBox(height: 20),
        CustomButton(
            title: 'Next',
            onPressed: (){
              model.currentPage = 3;
              model.notifyListeners();
            },
            buttonColor: Palette.primaryColor,
            textColor: Colors.white),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget submitView(SellViewModel model,BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                description('Product Name', 'Oraimo charger'),
                const SizedBox(height: 20),
                description('Image', 'Feature Image'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 55,
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                      decoration: BoxDecoration(color: Color(0xFFBB00DA)),
                      child: SvgPicture.asset('assets/icons/image.svg',height: 20),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Feature image.jpg',
                          style: TextStyle(
                            color: Color(0xFFBB00DA),
                            fontSize: 15,
                            fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.30,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '2mb',
                          style: TextStyle(
                            color: Color(0xFFBB00DA),
                            fontSize: 12,
                            fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.30,
                          ))
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Text(
                  'Other images',
                  style: TextStyle(
                    color: Color(0xFFBB00DA),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.28,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Container(
                         width: 55,
                         height: 44,
                         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                         decoration: BoxDecoration(color: Color(0xFFBB00DA)),
                         child: SvgPicture.asset('assets/icons/image.svg',height: 20),
                       ),
                       const SizedBox(width: 10),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             'image 1.jpg',
                             style: TextStyle(
                               color: Color(0xFFBB00DA),
                               fontSize: 15,
                               fontFamily: 'Circular Std',
                               fontWeight: FontWeight.w500,
                               letterSpacing: -0.30,
                             ),
                           ),
                           const SizedBox(height: 2),
                           Text(
                               '2mb',
                               style: TextStyle(
                                 color: Color(0xFFBB00DA),
                                 fontSize: 12,
                                 fontFamily: 'Circular Std',
                                 fontWeight: FontWeight.w400,
                                 letterSpacing: -0.30,
                               ))
                         ],
                       )
                     ],
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Container(
                         width: 55,
                         height: 44,
                         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                         decoration: BoxDecoration(color: Color(0xFFBB00DA)),
                         child: SvgPicture.asset('assets/icons/image.svg',height: 20),
                       ),
                       const SizedBox(width: 10),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             'image 2.jpg',
                             style: TextStyle(
                               color: Color(0xFFBB00DA),
                               fontSize: 15,
                               fontFamily: 'Circular Std',
                               fontWeight: FontWeight.w500,
                               letterSpacing: -0.30,
                             ),
                           ),
                           const SizedBox(height: 2),
                           Text(
                               '2mb',
                               style: TextStyle(
                                 color: Color(0xFFBB00DA),
                                 fontSize: 12,
                                 fontFamily: 'Circular Std',
                                 fontWeight: FontWeight.w400,
                                 letterSpacing: -0.30,
                               ))
                         ],
                       )
                     ],
                   ),
                 ],
               ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 55,
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                          decoration: BoxDecoration(color: Color(0xFFBB00DA)),
                          child: SvgPicture.asset('assets/icons/image.svg',height: 20),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'image 1.jpg',
                              style: TextStyle(
                                color: Color(0xFFBB00DA),
                                fontSize: 15,
                                fontFamily: 'Circular Std',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.30,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                                '2mb',
                                style: TextStyle(
                                  color: Color(0xFFBB00DA),
                                  fontSize: 12,
                                  fontFamily: 'Circular Std',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.30,
                                ))
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 55,
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                          decoration: BoxDecoration(color: Color(0xFFBB00DA)),
                          child: SvgPicture.asset('assets/icons/image.svg',height: 20),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'image 2.jpg',
                              style: TextStyle(
                                color: Color(0xFFBB00DA),
                                fontSize: 15,
                                fontFamily: 'Circular Std',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.30,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                                '2mb',
                                style: TextStyle(
                                  color: Color(0xFFBB00DA),
                                  fontSize: 12,
                                  fontFamily: 'Circular Std',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.30,
                                ))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                description('Video', 'Product Video'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 55,
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                      decoration: BoxDecoration(color: Color(0xFFBB00DA)),
                      child: SvgPicture.asset('assets/icons/image.svg',height: 20),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product video.mp4',
                          style: TextStyle(
                            color: Color(0xFFBB00DA),
                            fontSize: 15,
                            fontFamily: 'Circular Std',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.30,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                            '4mb',
                            style: TextStyle(
                              color: Color(0xFFBB00DA),
                              fontSize: 12,
                              fontFamily: 'Circular Std',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.30,
                            ))
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                description('Details', 'Fast charging'),
                const SizedBox(height: 25),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    description('Category', 'Equipments'),
                    const SizedBox(width: 28),
                    description('Sub category', 'Chargers'),
                    const SizedBox(width: 40),
                    description('Location', 'Ibadan, Oyo state, Nigeria'),
                  ]),
                const SizedBox(height: 25),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    description('Quantity', '20'),
                    const SizedBox(width: 40),
                    description('Price', '3,000'),
                    const SizedBox(width: 40),
                    description('Negotiable', 'Yes'),
                  ]),

                const SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      description('Condition', 'New'),
                      const SizedBox(width: 36),
                      description('Discount', '10%'),
                    ]),
              ]),
        ),
        const SizedBox(height: 30),
        CustomButton(
            title: 'Submit',
            onPressed: (){
              successView(context);
            },
            buttonColor: Palette.primaryColor,
            textColor: Colors.white),
        const SizedBox(height: 50),
      ],
    );
  }

Future successView(BuildContext context) async{
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      constraints: const BoxConstraints(maxHeight: 500, minHeight: 500),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
          return ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(0),
                topLeft: Radius.circular(0),
              ),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  child: SizedBox(
                      height: 500,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Color(0x7FBB00DA),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Color(0xFFBB00DA),
                                child: SvgPicture.asset('assets/icons/tick-circle.svg',height: 100),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Text(
                              'Successful',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Submitted successfully for review',
                              style: TextStyle(
                                color: Color(0xFF6D6D6D),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 30),
                            CustomButton(
                                title: 'Go Home',
                                onPressed: (){
                                  NavigationService().clearStackAndShow(DashboardView.routeName);
                                },
                                buttonColor: Palette.primaryColor,
                                textColor: Colors.white)


                          ]))));
        });
      });
}

  Widget dropDown({required BuildContext context, required SellViewModel model, required String title,required String? value, required Function() onTap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15,
            // fontFamily: 'Silka',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: onTap,
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: Palette.primaryColor.withOpacity(0.2))),
              width: double.maxFinite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 220,
                    child: Text(
                      value != null ? '${value}' : 'Select',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: value != null ? Colors.black : Colors.black54),
                    ),
                  ),
                  model.loadingCategories
                      ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Palette.primaryColor, strokeWidth: 2))
                      : const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey, size: 25)
                ],
              )),
        ),
      ],
    );
  }

  Widget description(String title,String subtitle){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xFFBB00DA),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.28,
          ),
        ),
        ConstrainedBox(
          constraints:  BoxConstraints(maxWidth: 70),
          child: Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xFF9F9F9F),
              fontSize: 13,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.26,
            ),
          ),
        )
      ],
    );
  }

  Widget appBar(SellViewModel model, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            if(model.currentPage != 0){
              model.currentPage--;
            model.notifyListeners();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: [
               model.currentPage == 0 ? const SizedBox() :  Icon(Icons.arrow_back_ios,color: Colors.black87,size: 24),
                Text(
                  'Post an Ad',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.27,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){
            clearAd(context, model);
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              'Clear Ad',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget stepper(SellViewModel model,BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        eachStepper('Product', 0, model),
        eachStepper('Image', 1, model),
        eachStepper('Details', 2, model),
        eachStepper('Submit', 3, model),
      ],
    );
  }

  Widget eachStepper(String title, int value,SellViewModel model){
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape:BoxShape.circle,
                border: Border.all(width: 1.5, color: model.currentPage == value ? Colors.green : Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.check,color: model.currentPage == value ? Colors.green : Colors.grey,size: 30),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              style: TextStyle(
                color: model.currentPage == value ? Colors.black : Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            )
          ],
        );
  }

  Future clearAd(BuildContext context,SellViewModel model) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context2) {
          return Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: Container(
              width: 240,
              height: 170,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Palette.backgroundColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 260,
                    child: Text(
                      'Do you want to clear your Ad?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: CustomButton(
                            title: 'Yes',
                            onPressed: (){
                              model.clearAd();
                              Navigator.pop(context2);
                            },
                            buttonColor: Palette.backgroundColor,
                            textColor: Palette.primaryColor,
                            borderColor: Palette.primaryColor,
                          )),
                      const SizedBox(width: 20),
                      Expanded(
                          child: CustomButton(
                            title: 'No',
                            onPressed: (){
                              Navigator.pop(context2);
                            },
                            buttonColor: Palette.primaryColor,
                            textColor: Colors.white,
                            borderColor: Palette.primaryColor,
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

}
