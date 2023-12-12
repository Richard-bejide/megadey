import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megadey_mobile/core/utilities/widgets/rounded_button.dart';
import 'package:megadey_mobile/views/megadey_plans/payment/payment_viewmodel.dart';
import 'package:megadey_mobile/views/megadey_plans/selected_premium_plan/selected_premium_plan_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utilities/functions/format_price.dart';

class PaymentView extends StatelessWidget {
  static const routeName = 'paymentView';

  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => PaymentViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
                backgroundColor: Palette.backgroundColor,
                body: SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          appBar(),
                          Expanded(
                            child: SingleChildScrollView(
                                child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(4)),
                                          color: Colors.white),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          card(),
                                          const SizedBox(height: 20),
                                          paymentOption('Paystack', 'Checkout with paystack'),
                                          const SizedBox(height: 20),
                                          paymentOption('Paypal', 'Use paypal to make payments'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Center(
                                    child: Text(
                                      'secure payments',
                                      style: TextStyle(
                                        color: Color(0xC1A3A3A3),
                                        fontSize: 11,
                                        // fontFamily: 'Circular Std',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.22,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 60),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: CustomButton(title: 'Pay', onPressed: (){}, buttonColor: Palette.primaryColor, textColor: Colors.white),
                                  )

                                ])),
                          ),
                        ])))));
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Plan',
            style: TextStyle(
              color: Color(0xFF222121),
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.32,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 270,
            child: Text(
              'please make payment to start enjoying all the \nfeatures as soon as possible',
              style: TextStyle(
                color: Color(0xFF6D6D6D),
                fontSize: 13,
                // fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget card() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(4),
        decoration: ShapeDecoration(
          color: Color(0xFFF3EAF5),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFBB00DA)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 65,
                  height: 65,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Color(0xFFFCDDFF)),
                  child: SvgPicture.asset('assets/icons/crown.svg', height: 22),
                ),
                const SizedBox(width: 4),
                Text(
                  SelectedPremiumPlanViewModel.selectedPlan!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    // fontFamily: 'Circular Std',
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  formatPrice(22000),
                  style: TextStyle(
                    color: Palette.primaryColor,
                    fontSize: 17,
                    fontFamily: '',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '1 month',
                  style: TextStyle(
                    color: Color(0xFF979797),
                    fontSize: 12,
                    // fontFamily: 'Circular Std',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }

  Widget paymentOption(String method,String subtitle){
    return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2)
                  ),
                child: SvgPicture.asset('assets/icons/$method.svg',height: 25)
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      // fontFamily: 'Circular Std',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.26,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 13,
                      // fontFamily: 'Circular Std',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.20,
                    ),
                  )
                ],
              )
            ],
          );
  }
}
