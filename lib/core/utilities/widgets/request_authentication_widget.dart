import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:megadey_mobile/core/utilities/widgets/rounded_button.dart';
import 'package:megadey_mobile/views/onboarding/onboarding_view.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../constants/colors.dart';
import 'bottomsheet_drag_button.dart';

Future RequestAuthenticationModal(BuildContext context) async {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxHeight: 300, minHeight: 300),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
          return ClipRRect(
            // borderRadius: const BorderRadius.only(
            //   topRight: Radius.circular(20),
            //   topLeft: Radius.circular(20),
            // ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              width: double.infinity,
              child: SizedBox(
                  height: 300,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 3),
                                BottomsheetDragButton(),
                                const SizedBox(height: 25),
                                SvgPicture.asset("assets/icons/logo.svg",height: 50,color: Palette.primaryColor),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 288,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'We\'d like to welcome you to the family! \nClick on the get started button to continue.',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            )),
                        CustomButton(
                            title: 'Get Started',
                            onPressed: () {
                              NavigationService().clearStackAndShow(OnboardingView.routeName);
                            },
                            buttonColor: Palette.primaryColor,
                            textColor: Colors.white),
                        const SizedBox(height: 20),

                      ])),
            ),
          );
        });
      });
}
