import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megadey_mobile/core/utilities/functions/format_price.dart';
import 'package:megadey_mobile/core/utilities/widgets/rounded_button.dart';
import 'package:megadey_mobile/views/megadey_plans/payment/payment_view.dart';
import 'package:megadey_mobile/views/megadey_plans/selected_premium_plan/selected_premium_plan_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../core/constants/colors.dart';

class SelectedPremiumPlanView extends StatelessWidget {
  static const routeName = 'selectedPremiumPlanView';

  const SelectedPremiumPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectedPremiumPlanViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => SelectedPremiumPlanViewModel(),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      offer('Spotlight Visibility'),
                                      offer('Access to all categories')
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      offer('Social media/Website Link Inclusion'),
                                      offer('Spotlight auto review')
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      offer('Number of items to be Promoted'),
                                      offer('Social media/Email Promotions')
                                    ]),
                                const SizedBox(height: 15),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      offer('Display of Hot deals on banner'),
                                      offer('Spotlight on Mega deals')
                                    ]),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
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
                                  card(formatPrice(11500), '1 Week', () {}),
                                  card(formatPrice(42500), '1 Month', () {}),
                                  card(formatPrice(85050), '3 Months', () {}),
                                  card(formatPrice(149975), '6 Months', () {}),
                                  card(formatPrice(262150), '12 Months', () {}),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomButton(
                                title: 'Proceed to payment',
                                onPressed: () {
                                  NavigationService().navigateTo(PaymentView.routeName);
                                },
                                buttonColor: Palette.primaryColor,
                                textColor: Colors.white),
                          ),
                          const SizedBox(height: 20),
                        ])),
                      ),
                    ])))));
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Text(
        SelectedPremiumPlanViewModel.selectedPlan!,
        style: TextStyle(
          color: Color(0xFFBB00DA),
          fontSize: 30,
          // fontFamily: 'DM Sans',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget offer(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/icons/check.svg', height: 14),
        const SizedBox(width: 6),
        SizedBox(
          width: 120,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: Color(0xFF1F1F1F),
              fontSize: 12,
              // fontFamily: 'Circular Std',
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Widget card(String cost, String duration, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(12),
          decoration: ShapeDecoration(
            color: Color(0xFFF3EAF5),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.5, color: Color(0xFFBB00DA)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                cost,
                style: TextStyle(
                  color: Palette.primaryColor,
                  fontSize: 20,
                  fontFamily: '',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                duration,
                style: TextStyle(
                  color: Palette.primaryColor,
                  fontSize: 15,
                  // fontFamily: 'Circular Std',
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
