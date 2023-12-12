import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megadey_mobile/views/megadey_plans/selected_premium_plan/selected_premium_plan_view.dart';
import 'package:megadey_mobile/views/megadey_plans/selected_premium_plan/selected_premium_plan_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/constants/colors.dart';
import 'megadey_plans_viewmodel.dart';

class MegadeyPlansView extends StatelessWidget {
  static const routeName = 'megadeyPlansView';

  const MegadeyPlansView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MegadeyPlansViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => MegadeyPlansViewModel(),
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
                                  card('Mega Deals', () {
                                    SelectedPremiumPlanViewModel.selectedPlan = 'Mega Deals';
                                    NavigationService()
                                        .navigateTo(SelectedPremiumPlanView.routeName);
                                  }),
                                  card('Optimum Deals', () {
                                    SelectedPremiumPlanViewModel.selectedPlan = 'Optimum Deals';
                                    NavigationService()
                                        .navigateTo(SelectedPremiumPlanView.routeName);
                                  }),
                                  card('Galore Deals', () {
                                    SelectedPremiumPlanViewModel.selectedPlan = 'Galore Deals';
                                    NavigationService()
                                        .navigateTo(SelectedPremiumPlanView.routeName);
                                  }),
                                  card('Nifty Deals', () {
                                    SelectedPremiumPlanViewModel.selectedPlan = 'Nifty Deals';
                                    NavigationService()
                                        .navigateTo(SelectedPremiumPlanView.routeName);
                                  }),
                                  card('Dandy Deals', () {
                                    SelectedPremiumPlanViewModel.selectedPlan = 'Dandy Deals';
                                    NavigationService()
                                        .navigateTo(SelectedPremiumPlanView.routeName);
                                  }),
                                  card('Jolly Deals', () {
                                    SelectedPremiumPlanViewModel.selectedPlan = 'Jolly Deals';
                                    NavigationService()
                                        .navigateTo(SelectedPremiumPlanView.routeName);
                                  }),
                                  card('Super stores Deals', () {
                                    SelectedPremiumPlanViewModel.selectedPlan =
                                    'Super stores Deals';
                                    NavigationService()
                                        .navigateTo(SelectedPremiumPlanView.routeName);
                                  }),
                                  card('Jumbo Deals', () {
                                    SelectedPremiumPlanViewModel.selectedPlan = 'Jumbo Deals';
                                    NavigationService()
                                        .navigateTo(SelectedPremiumPlanView.routeName);
                                  }),
                                ],
                              ),
                            ),
                          ),
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
            'Pricing',
            style: TextStyle(
              color: Color(0xFF222121),
              fontSize: 17,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.32,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Choose the right plan for your ads and start selling faster',
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 12,
              // fontFamily: 'DM Sans',
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget card(String title, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: onTap,
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
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
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
