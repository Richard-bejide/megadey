import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megadey_mobile/views/business_details/business_details_view.dart';
import 'package:megadey_mobile/views/change_email/change_email_view.dart';
import 'package:megadey_mobile/views/change_language/change_language_view.dart';
import 'package:megadey_mobile/views/change_password/change_password_view.dart';
import 'package:megadey_mobile/views/delete_account/delete_account_viewmodel.dart';
import 'package:megadey_mobile/views/manage_notifications/manage_notifications_view.dart';
import 'package:megadey_mobile/views/my_ads/my_ads_view.dart';
import 'package:megadey_mobile/views/personal_details/personal_details_view.dart';
import 'package:megadey_mobile/views/settings/settings_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/constants/colors.dart';
import '../change_phone_number/change_phone_number_view.dart';
import '../delete_account/delete_account_view.dart';

class SettingsView extends StatelessWidget {
  static const routeName = 'settingsView';

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => SettingsViewModel(),
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
                        child: SingleChildScrollView(
                            child: Column(children: [
                          const SizedBox(height: 15),
                          card('Personal Details', () {
                            NavigationService().navigateTo(PersonalDetailsView.routeName);
                          }),
                          const SizedBox(height: 15),
                          card('Business Details', () {
                            NavigationService().navigateTo(BusinessDetailsView.routeName);
                          }),
                          const SizedBox(height: 15),
                          card('Change Phone Number', () {
                            NavigationService().navigateTo(ChangePhoneNumberView.routeName);
                          }),
                          const SizedBox(height: 15),
                          card('Change Email Address', () {
                            NavigationService().navigateTo(ChangeEmailView.routeName);
                          }),
                          const SizedBox(height: 15),
                          card('Change Language', () {
                            NavigationService().navigateTo(ChangeLanguageView.routeName);
                          }),
                          const SizedBox(height: 15),
                          card('Change Password', () {
                            NavigationService().navigateTo(ChangePasswordView.routeName);
                          }),
                          const SizedBox(height: 15),
                          card('Manage Notifications', () {
                            NavigationService().navigateTo(ManageNotificationsView.routeName);
                          }),
                              const SizedBox(height: 15),
                              card('Logout', () {
                                model.logout();
                              }),
                          const SizedBox(height: 15),
                          card('Delete Account', () {
                            NavigationService().navigateTo(DeleteAccountView.routeName);
                          }),
                          const SizedBox(height: 50),
                        ])),
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
              'Settings',
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

  Widget card(String title, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.28,
                ),
              ),
              Icon(Icons.keyboard_arrow_right, size: 20, color: Colors.black)
            ],
          ),
        ),
      ),
    );
  }
}
