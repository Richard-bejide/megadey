import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megadey_mobile/core/utilities/widgets/bottomsheet_drag_button.dart';
import 'package:megadey_mobile/core/utilities/widgets/rounded_button.dart';
import 'package:megadey_mobile/core/utilities/widgets/webview_screen.dart';
import 'package:megadey_mobile/views/ads_performance/ads_performance_view.dart';
import 'package:megadey_mobile/views/megadey_plans/megadey_plans_view.dart';
import 'package:megadey_mobile/views/my_ads/my_ads_view.dart';
import 'package:megadey_mobile/views/profile/profile_viewmodel.dart';
import 'package:megadey_mobile/views/settings/settings_view.dart';
import 'package:megadey_mobile/views/wallet/wallet_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/constants/colors.dart';

class ProfileView extends StatelessWidget {
  static const routeName = 'profileView';

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        onViewModelReady: (model) => model.setup(context),
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
                backgroundColor: Palette.backgroundColor,
                body: SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      const SizedBox(height: 20),
                      appBar(model, context),
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(children: [
                          const SizedBox(height: 15),
                          card('My Adverts', () {NavigationService().navigateTo(MyAdsView.routeName);}),
                          const SizedBox(height: 15),
                          card('Performance', () {NavigationService().navigateTo(AdsPerformanceView.routeName);}),
                          const SizedBox(height: 15),
                              card('Wallet', () {
                                NavigationService().navigateTo(WalletView.routeName);
                              }),
                              const SizedBox(height: 15),
                          card('Feedback', () {
                            feedbacks(context, model);
                          }),
                          const SizedBox(height: 15),
                              card('Megadey Subscription Plans', () {
                                NavigationService().navigateTo(MegadeyPlansView.routeName);
                              }),
                              const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: double.maxFinite,
                                padding: const EdgeInsets.only(left: 30, top: 15, bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/icons/premium.svg', height: 30),
                                    const SizedBox(width: 15),
                                    Text(
                                      'Optimum Package',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  link('Billing Policy', 'billing-policy'),
                                  Container(height:15,width: 1,color: Colors.black54),
                                  link('About Us', 'about-us'),
                                  Container(height:15,width: 1,color: Colors.black54),
                                  link('Terms of Service', 'terms-of-service'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  link('Cookie Policy', 'cookie-policy'),
                                  Container(height:15,width: 1,color: Colors.black54),
                                  link('Privacy Policy', 'privacy-policy'),
                                  Container(height:15,width: 1,color: Colors.black54),
                                  link('Safety Tips', 'safety-tips'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  link('FAQs', 'faqs'),
                                  Container(height:15,width: 1,color: Colors.black54),
                                  link('Influencers', 'influencers'),
                                  Container(height:15,width: 1,color: Colors.black54),
                                  link('Blogs', 'blog'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: SvgPicture.asset('assets/icons/support.svg', height: 50)),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: CustomButton(
                                title: 'Sign out',
                                onPressed: () {
                                  model.logout();
                                },
                                buttonColor: Palette.primaryColor,
                                textColor: Colors.white),
                          ),
                          const SizedBox(height: 50),
                        ])),
                      ),
                    ])))));
  }

  Widget appBar(ProfileViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 22,
                        backgroundColor: Palette.primaryColor.withOpacity(0.1),
                        backgroundImage: AssetImage('assets/images/messages4.png')),
                    const SizedBox(width: 8),
                    Text(
                      model.username ?? '',
                      style: TextStyle(
                        color: Color(0xFF222121),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.27,
                      ),
                    )
                  ],
                ),
              ]),
          GestureDetector(
              onTap: () {
                NavigationService().navigateTo(SettingsView.routeName);
              },
              child: SvgPicture.asset('assets/icons/setting.svg',
                  color: Palette.primaryColor, height: 25))
        ],
      ),
    );
  }

  Widget card(String title, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(left: 30, top: 15, bottom: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.28,
            ),
          ),
        ),
      ),
    );
  }

  Future feedbacks(BuildContext context, ProfileViewModel model) {
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
                            'Feedbacks',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              // fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'All your feedbacks',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF727272),
                              fontSize: 16,
                              // fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.feedbacks?.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map<String, dynamic>? feedback = model.feedbacks?[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundColor: Colors.grey.withOpacity(0.2),
                                        backgroundImage: AssetImage(feedback?['user_image']),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              feedback?['user_name'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Color(0xFF222121),
                                                fontSize: 16,
                                                // fontFamily: 'Circular Std',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: -0.28,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 180,
                                            child: Text(
                                              feedback?['feedback'],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Color(0xFF9F9F9F),
                                                fontSize: 12,
                                                // fontFamily: 'Circular Std',
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: -0.24,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/icons/smiley_face.svg', height: 20),
                                      const SizedBox(height: 4),
                                      Text(
                                        feedback?['rating'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          // fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ]),
                    )));
          });
        });
  }

  Widget link(String title, String link){
    return InkWell(
      onTap: () {
        NavigationService().navigateToView(WebViewScreen(url: 'https://megadey-95be8.web.app/$link'));
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(4.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
