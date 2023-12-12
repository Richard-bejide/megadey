import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megadey_mobile/views/wallet/wallet_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/colors.dart';
import '../../core/utilities/functions/format_price.dart';
import '../../core/utilities/functions/modal_sheet.dart';
import '../../core/utilities/widgets/rounded_button.dart';
import '../../core/utilities/widgets/text_field.dart';

class WalletView extends StatelessWidget {
  static const routeName = 'walletView';

  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WalletViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => WalletViewModel(),
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
                                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  const SizedBox(height: 20),
                                   Column(
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Container(
                                         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                         width: double.maxFinite,
                                         decoration: BoxDecoration(
                                             color: Palette.primaryColor,
                                             borderRadius: BorderRadius.only(
                                                 topLeft: Radius.circular(16),
                                                 topRight: Radius.circular(16))),
                                         child: Row(
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Padding(
                                                   padding: const EdgeInsets.symmetric(vertical: 20.0),
                                                   child: Text(
                                                     'Wallet History',
                                                     style: TextStyle(
                                                       color: Colors.white,
                                                       fontSize: 17,
                                                       // fontFamily: 'Circular Std',
                                                       fontWeight: FontWeight.w500,
                                                     ),
                                                   ),
                                                 ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(width:1,height: 60,color: Colors.grey),
                                                    const SizedBox(width: 8),
                                                    Column(
                                                      mainAxisAlignment:MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Wallet Balance',
                                                          style: TextStyle(
                                                            color: Colors.white70,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 3),
                                                        Text(
                                                          formatPrice(200000),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 19,
                                                            fontFamily: '',
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 20),
                                                    GestureDetector(
                                                      onTap: (){
                                                        modalSheetWidget(
                                                          context: context,
                                                          title: const Text(
                                                            'Top-up',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 17.0,
                                                                fontWeight: FontWeight.w700,
                                                                color: Colors.black),
                                                          ),
                                                          subtitle: const Text(
                                                            'Top up your wallet for easy payment on megadey',
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
                                                                  labelText: 'Enter amount',
                                                                  controller: model.amountToFund
                                                                ),
                                                                const SizedBox(height: 30.0),
                                                                CustomButton(
                                                                    title: 'Continue',
                                                                    onPressed: (){
                                                                      Navigator.pop(context);
                                                                    },
                                                                    buttonColor: Palette.primaryColor,
                                                                    textColor: Colors.white),
                                                                const SizedBox(height: 8.0),
                                                              ]),
                                                        );
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                                                        decoration: ShapeDecoration(
                                                          color: Color(0xFFFAF5FF),
                                                          shape: RoundedRectangleBorder(
                                                            side: BorderSide(width: 0.20, color: Color(0xFFBB00DA)),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                        child:Text(
                                                          'Top up',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        )
                                                      ),
                                                    )
                                                  ],
                                                )
                                               ],
                                             ),

                                       ),
                                       Container(
                                         padding: const EdgeInsets.symmetric(horizontal: 10,vertical:15),
                                         width: double.maxFinite,
                                         decoration: BoxDecoration(
                                             color: Colors.white,
                                             borderRadius: BorderRadius.only(
                                                 bottomLeft: Radius.circular(16),
                                                 bottomRight: Radius.circular(16))),
                                         child: Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     Text(
                                                       'Funded wallet with bank transfer',
                                                       style: TextStyle(
                                                         color: Colors.black87,
                                                         fontSize: 16,
                                                         fontWeight: FontWeight.w500,
                                                       ),
                                                     ),
                                                     Text(
                                                       'Successful',
                                                       style: TextStyle(
                                                         color: Colors.green,
                                                         fontSize: 12,
                                                         fontWeight: FontWeight.w400,
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                                 Text(
                                                    '+'+formatPrice(32000),
                                                   style: TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 16,
                                                     fontFamily: '',
                                                     fontWeight: FontWeight.w400,
                                                   ),
                                                 ),
                                               ],
                                             ),
                                             const SizedBox(height: 20),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     Text(
                                                       'Funded wallet with bank transfer',
                                                       style: TextStyle(
                                                         color: Colors.black87,
                                                         fontSize: 16,
                                                         fontWeight: FontWeight.w500,
                                                       ),
                                                     ),
                                                     Text(
                                                       'Successful',
                                                       style: TextStyle(
                                                         color: Colors.green,
                                                         fontSize: 12,
                                                         fontWeight: FontWeight.w400,
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                                 Text(
                                                   '+'+formatPrice(32000),
                                                   style: TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 16,
                                                     fontFamily: '',
                                                     fontWeight: FontWeight.w400,
                                                   ),
                                                 ),
                                               ],
                                             ),
                                             const SizedBox(height: 20),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     Text(
                                                       'Funded wallet with bank transfer',
                                                       style: TextStyle(
                                                         color: Colors.black87,
                                                         fontSize: 16,
                                                         fontWeight: FontWeight.w500,
                                                       ),
                                                     ),
                                                     Text(
                                                       'Failed',
                                                       style: TextStyle(
                                                         color: Colors.red,
                                                         fontSize: 12,
                                                         fontWeight: FontWeight.w400,
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                                 Text(
                                                   '+'+formatPrice(14000),
                                                   style: TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 16,
                                                     fontFamily: '',
                                                     fontWeight: FontWeight.w400,
                                                   ),
                                                 ),
                                               ],
                                             ),
                                           ]),
                                       )
                                     ]),
                                  const SizedBox(height: 20),
                                ]),
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
              'My Wallet',
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

}
