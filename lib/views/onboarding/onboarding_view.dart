import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';
import '../../core/constants/colors.dart';
import '../../core/services/utility_storage_service.dart';
import '../../core/utilities/widgets/rounded_button.dart';
import 'onboarding_viewmodel.dart';

class OnboardingView extends StatelessWidget {
  static const routeName = 'OnboardingView';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<OnboardingViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => OnboardingViewModel(),
        builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
                children: [
              SizedBox.expand(
                  child: FittedBox(
                      // If your background video doesn't look right, try changing the BoxFit property.
                      // BoxFit.cover created the look I was going for.
                      fit: BoxFit.cover,
                      child: SizedBox(
                          width: model.videoPlayerController!.value.size.width,
                          height: model.videoPlayerController!.value.size.height,
                          child: model.videoPlayerController!.value.isInitialized
                              ? VideoPlayer(model.videoPlayerController!)
                              : Container()))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: size.height,
                color: Colors.black.withOpacity(0.4),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                          title: 'Create Account',
                          buttonColor: Palette.primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            StorageService().addBool('skipOnBoarding',true);
                            model.navigateToSignup();
                          }),
                      const SizedBox(height: 10),
                      CustomButton(
                          title: 'Login',
                          buttonColor: Colors.transparent,
                          textColor: Colors.white,
                          borderColor: Colors.white,
                          onPressed: () {
                            StorageService().addBool('skipOnBoarding',true);
                            model.navigateToSignIn();
                          }),
                      const SizedBox(height: 40),
                    ]),
              )
            ])));
  }
}
