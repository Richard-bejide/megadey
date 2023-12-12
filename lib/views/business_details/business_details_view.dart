import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/colors.dart';
import '../../core/utilities/widgets/bottomsheet_drag_button.dart';
import '../../core/utilities/widgets/rounded_button.dart';
import '../../core/utilities/widgets/text_field.dart';
import 'business_details_viewmodel.dart';

class BusinessDetailsView extends StatelessWidget {
  static const routeName = 'businessDetailsView';

  const BusinessDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessDetailsViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => BusinessDetailsViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
                backgroundColor: Palette.backgroundColor,
                body: SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          appBar(context),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: SingleChildScrollView(
                                child: Form(
                                  key: model.formKey,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                          const SizedBox(height: 20),
                                          CustomTextBox(
                                              hintText: 'Enter your business name',
                                              labelText: 'Business Name',
                                              controller: model.businessNameController),
                                          const SizedBox(height: 20),

                                          CustomTextBox(
                                             maxLines: 5,
                                              hintText: '',//'Enter your business description',
                                              labelText: 'Business Description',
                                              controller: model.descriptionController),
                                          const SizedBox(height: 20),
                                          CustomTextBox(
                                              hintText: 'www.megadey.com/sneakerella',
                                              labelText: 'Megadey Link',
                                              controller: model.linkController),
                                          const SizedBox(height: 20),
                                          Container(
                                           padding:  const EdgeInsets.all(15),
                                            decoration: ShapeDecoration(
                                              color: Colors.white54,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Store',
                                                      style: TextStyle(
                                                        color: Color(0xFF171717),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                        onTap: (){
                                                          //edit store details
                                                          editStoreDetails(context, model);
                                                        },
                                                        child: SvgPicture.asset('assets/icons/edit.svg',color: Colors.black87,height: 17))
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset('assets/icons/location.svg',height: 20),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      'Oyo State, Ibadan',
                                                      style: TextStyle(
                                                        color: Color(0xFF171717),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset('assets/icons/shop.svg',height: 20),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      'Sneakerella',
                                                      style: TextStyle(
                                                        color: Color(0xFF171717),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset('assets/icons/clock.svg',height: 20),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      '9:30AM - 5PM',
                                                      style: TextStyle(
                                                        color: Color(0xFF171717),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset('assets/icons/calendar-2.svg',height: 20),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      'MON - TUES',
                                                      style: TextStyle(
                                                        color: Color(0xFF171717),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),

                                          ),
                                          const SizedBox(height: 20),
                                          Container(
                                            padding:  const EdgeInsets.all(15),
                                            decoration: ShapeDecoration(
                                              color: Colors.white54,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Delivery',
                                                      style: TextStyle(
                                                        color: Color(0xFF171717),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                        onTap: (){
                                                          //edit delivery details
                                                          editDeliveryDetails(context, model);
                                                        },
                                                        child: SvgPicture.asset('assets/icons/edit.svg',color: Colors.black87,height: 17))
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset('assets/icons/shop.svg',height: 20),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      'Apparel and Clothing',
                                                      style: TextStyle(
                                                        color: Color(0xFF171717),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset('assets/icons/location.svg',height: 20),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      'Oyo State, Ibadan',
                                                      style: TextStyle(
                                                        color: Color(0xFF171717),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset('assets/icons/clock.svg',height: 20),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      '3 - 5 working days',
                                                      style: TextStyle(
                                                        color: Color(0xFF171717),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset('assets/icons/calendar-2.svg',height: 20),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      'Free of Charge',
                                                      style: TextStyle(
                                                        color: Color(0xFF171717),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),

                                          ),
                                          const SizedBox(height: 30),
                                          CustomButton(
                                              showLoadingIcon: model.isLoading,
                                              title: 'Save',
                                              onPressed: () {
                                                FocusScope.of(context).unfocus();
                                                if (model.formKey.currentState!.validate()) {
                                                }
                                              },
                                              buttonColor: Palette.primaryColor,
                                              textColor: Colors.white),
                                          const SizedBox(height: 40)
                                        ])
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ])))));
  }

  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/arrow-left.svg', height: 20, width: 20),
            const SizedBox(width: 7),
            Text(
              'Business Details',
              style: TextStyle(
                color: Color(0xFF222121),
                fontSize: 18,
                // fontFamily: 'Circular Std',
                fontWeight: FontWeight.w700,
                letterSpacing: -0.27,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future editStoreDetails(BuildContext context, BusinessDetailsViewModel model) {
    return showModalBottomSheet(
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BottomsheetDragButton(),
                            const SizedBox(height: 12),
                            Text(
                              'Store details',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                // fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Complete the form below to edit your store details',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                // fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                  children: [
                                    const SizedBox(height: 10.0),
                                    CustomTextBox(
                                      hintText: 'Enter your store name',
                                      labelText: 'Store Name',
                                      //controller: model.chatController
                                    ),
                                    const SizedBox(height: 5.0),
                                    CustomTextBox(
                                      enabled: false,
                                      hintText: 'Select ',
                                      labelText: 'Region',
                                      //controller: model.chatController
                                    ),
                                    const SizedBox(height: 5.0),
                                    CustomTextBox(
                                      hintText: 'Enter your address',
                                      labelText: 'Address',
                                      //controller: model.chatController
                                    ),
                                    const SizedBox(height: 5.0),
                                    CustomTextBox(
                                      hintText: 'How to get to your location',
                                      labelText: 'Landmark',
                                      //controller: model.chatController
                                    ),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        Expanded(child: CustomTextBox(
                                          hintText: '8:30 AM',
                                          labelText: 'Business Hours',
                                          //controller: model.chatController
                                        )),
                                        const SizedBox(width: 20),
                                        Expanded(child: CustomTextBox(
                                          hintText: '5:00 PM',
                                          labelText: '',
                                          //controller: model.chatController
                                        )),
                                      ],
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                side : BorderSide(color: Palette.primaryColor,width: 0.5),
                                                backgroundColor: Palette.primaryColor.withOpacity(0.1),
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                              ),
                                              onPressed: (){},
                                              child: Text('Mon',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                  ))),
                                          const SizedBox(width: 5),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                side : BorderSide(color: Palette.primaryColor,width: 0.5),
                                                backgroundColor: Palette.primaryColor.withOpacity(0.1),
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                              ),
                                              onPressed: (){},
                                              child: Text('Tue',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                  ))),
                                          const SizedBox(width: 5),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                side : BorderSide(color: Palette.primaryColor,width: 0.5),
                                                backgroundColor: Palette.primaryColor.withOpacity(0.1),
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                              ),
                                              onPressed: (){},
                                              child: Text('Wed',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                  ))),
                                          const SizedBox(width: 5),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                side : BorderSide(color: Colors.grey,width: 0.5),
                                                backgroundColor: Colors.grey.withOpacity(0.2),
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                              ),
                                              onPressed: (){},
                                              child: Text('Thur',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                  ))),
                                          const SizedBox(width: 5),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                side : BorderSide(color: Colors.grey,width: 0.5),
                                                backgroundColor: Colors.grey.withOpacity(0.2),
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                              ),
                                              onPressed: (){},
                                              child: Text('Fri',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                  ))),
                                          const SizedBox(width: 5),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                side : BorderSide(color: Colors.grey,width: 0.5),
                                                backgroundColor: Colors.grey.withOpacity(0.2),
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                              ),
                                              onPressed: (){},
                                              child: Text('Sat',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                  ))),
                                          const SizedBox(width: 5),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                side : BorderSide(color: Colors.grey,width: 0.5),
                                                backgroundColor: Colors.grey.withOpacity(0.2),
                                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                              ),
                                              onPressed: (){},
                                              child: Text('Sun',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13,
                                                  ))),
                                          const SizedBox(width: 5),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30.0),
                                    CustomButton(
                                        title: 'Save',
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        buttonColor: Palette.primaryColor,
                                        textColor: Colors.white),
                                    CustomButton(
                                        title: 'Delete',
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        buttonColor:Colors.white,
                                        textColor: Colors.red),
                                    const SizedBox(height: 8.0),
                                  ]),
                            )
                          ]),
                    )));
          });
        });
  }

  Future editDeliveryDetails(BuildContext context, BusinessDetailsViewModel model) {
    return showModalBottomSheet(
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BottomsheetDragButton(),
                            const SizedBox(height: 12),
                            Text(
                              'Delivery details',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                // fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Complete the form below to edit your delivery details',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                // fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    const SizedBox(height: 10.0),
                                    CustomTextBox(
                                      enabled: false,
                                      hintText: 'Select Category',
                                      labelText: 'Category',
                                      //controller: model.chatController
                                    ),
                                    const SizedBox(height: 5.0),
                                    CustomTextBox(
                                      enabled: false,
                                      hintText: 'Select Region',
                                      labelText: 'Region',
                                      //controller: model.chatController
                                    ),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        Expanded(child: CustomTextBox(
                                          hintText: '2',
                                          labelText: 'Total days',
                                          //controller: model.chatController
                                        )),
                                        const SizedBox(width: 20),
                                        Expanded(child: CustomTextBox(
                                          hintText: '5',
                                          labelText: '',
                                          //controller: model.chatController
                                        )),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0),
                                    CustomTextBox(
                                      enabled: false,
                                      labelText: 'Do you charge for delivery?',
                                      hintText: 'Yes',
                                      //controller: model.chatController
                                    ),
                                    const SizedBox(height: 30.0),
                                    CustomButton(
                                        title: 'Save',
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        buttonColor: Palette.primaryColor,
                                        textColor: Colors.white),
                                    CustomButton(
                                        title: 'Delete',
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        buttonColor:Colors.white,
                                        textColor: Colors.red),
                                    const SizedBox(height: 8.0),
                                  ]),
                            )
                          ]),
                    )));
          });
        });
  }
}
