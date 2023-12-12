import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/colors.dart';
import 'manage_notifications_viewmodel.dart';

class ManageNotificationsView extends StatelessWidget {
  static const routeName = 'manageNotificationsView';

  const ManageNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageNotificationsViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => ManageNotificationsViewModel(),
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
                              Container(
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(4))),
                                child:
                                    Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                  tile(
                                      'Hot deals and recommendations',
                                      buildSwitchToggle(model.hotDeals, (newValue) {
                                        model.hotDeals = newValue;
                                        model.notifyListeners();
                                      })),
                                  tile(
                                      'Info about your Ads',
                                      buildSwitchToggle(model.adsInfo, (newValue) {
                                        model.adsInfo = newValue;
                                        model.notifyListeners();
                                      })),
                                  tile(
                                      'Subscription Plans',
                                      buildSwitchToggle(model.sub, (newValue) {
                                        model.sub = newValue;
                                        model.notifyListeners();
                                      })),
                                  tile(
                                      'Your Subscription',
                                      buildSwitchToggle(model.yourSubs, (newValue) {
                                        model.yourSubs = newValue;
                                        model.notifyListeners();
                                      })),
                                  tile(
                                      'Messages',
                                      buildSwitchToggle(model.messages, (newValue) {
                                        model.messages = newValue;
                                        model.notifyListeners();
                                      })),
                                  tile(
                                      'Feedback',
                                      buildSwitchToggle(model.feedback, (newValue) {
                                        model.feedback = newValue;
                                        model.notifyListeners();
                                      })),
                                  tile(
                                      'SMS Info Notification',
                                      buildSwitchToggle(model.sms, (newValue) {
                                        model.sms = newValue;
                                        model.notifyListeners();
                                      })),
                                  tile(
                                      'Megadey web notifications',
                                      buildSwitchToggle(model.webNotification, (newValue) {
                                        model.webNotification = newValue;
                                        model.notifyListeners();
                                      })),
                                ]),
                              ),
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
              'Manage Notifications',
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

  Widget tile(String title, Widget trailing) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF262626),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing
        ],
      ),
    );
  }

  buildSwitchToggle(bool value, Function(bool newValue) onChanged) {
    return  SizedBox(
      height: 20,
      width: 20,
      child: Switch(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: value,
        activeColor: Palette.primaryColor,
        onChanged: onChanged,
      ),
    );
  }
}
