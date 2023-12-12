import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megadey_mobile/core/services/signup_service.dart';
import 'package:megadey_mobile/core/utilities/widgets/loading_overlay_widget.dart';
import 'package:megadey_mobile/views/auth/sign_in_with_email/sign_in_with_email_viewmodel.dart';
import 'package:megadey_mobile/views/auth/signup/signup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utilities/widgets/rounded_button.dart';
import '../../../core/utilities/widgets/text_field.dart';
import '../../../app/locator.dart';

class SignInWithEmailView extends StatelessWidget {
  static const routeName = 'signInWithEmailView';

  const SignInWithEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInWithEmailViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => SignInWithEmailViewModel(),
        builder: (context, model, child) => Material(
              child: LoadingOverlayWidget(
                isLoading: locator<SignupService>().showLoadingApple || locator<SignupService>().showLoadingFacebook || locator<SignupService>().showLoadingGoogle,
                child: Scaffold(
                    backgroundColor: Palette.backgroundColor,
                    body: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child:  SingleChildScrollView(
                            child: Form(
                              key: model.signInKey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 150),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Welcome Back',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 0.0,
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 5),
                                        SizedBox(
                                          width: 300,
                                          child: Text(
                                            'Input your login details below',
                                            style:  TextStyle(
                                                color: Palette.customGrey,
                                                letterSpacing: 0.0,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                      const SizedBox(height: 20),
                                      CustomTextBox(
                                          hintText: 'Enter your Email',
                                          labelText: 'Email',
                                          onTap: () {
                                            model.currentTextFieldIndex = 0;
                                            model.notifyListeners();
                                          },
                                          validator: (inputValue) {
                                            if (inputValue == null || inputValue.isEmpty) {
                                              return 'Field is required';
                                            }
                                            if (!model.emailRegex.hasMatch(inputValue)) {
                                              return 'Incorrect format';
                                            }
                                            return null;
                                          },
                                          controller: model.emailController),
                                      const SizedBox(height: 20),
                                      CustomTextBox(
                                          hintText: 'Enter Password',
                                          labelText: 'Password',
                                          onTap: () {
                                            model.currentTextFieldIndex = 1;
                                            model.notifyListeners();
                                          },
                                          obscureText: model.showPassword,
                                          suffix: GestureDetector(
                                            onTap: () {
                                              model.showPassword = !model.showPassword;
                                              model.notifyListeners();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                              child: Icon(
                                                  model.showPassword
                                                      ? Icons.visibility_outlined
                                                      : Icons.visibility_off_outlined,
                                                  size: 20,
                                                  color: Palette.primaryColor),
                                            ),
                                          ),
                                          validator: (inputValue) {
                                            if (inputValue == null || inputValue.isEmpty) {
                                              return 'Field is required';
                                            }
                                            return null;
                                          },
                                          controller: model.passwordController),
                                      const SizedBox(height: 40),
                                      CustomButton(
                                        showLoadingIcon: model.isLoading,
                                          title: 'Login',
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            if (model.signInKey.currentState!.validate()) {
                                              model.loginWithMail(context);
                                            }
                                          },
                                          buttonColor: Palette.primaryColor,
                                          textColor: Colors.white),
                                      GestureDetector(
                                        onTap: (){
                                          model.navigateToForgotPasswordView();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text('Forgot Password?',style:TextStyle(color: Palette.customGrey,fontWeight: FontWeight.w400,fontSize: 14)),
                                              Text(' Reset',style:TextStyle(color: Palette.primaryColor,fontWeight: FontWeight.w400,fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    const SizedBox(height: 50),
                                    Row(
                                      children: [
                                        Expanded(child: Container(color: Palette.customGrey.withOpacity(0.3),height: 1)),
                                        const SizedBox(width:2),
                                        Align(alignment: Alignment.center, child: Text('or continue with', style: TextStyle(color: Palette.customGrey, fontSize: 13, fontWeight: FontWeight.w300)),),
                                        const SizedBox(width:2),
                                        Expanded(child: Container(color: Palette.customGrey.withOpacity(0.3),height: 1)),
                                      ]),
                                    const SizedBox(height: 15),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap:(){
                                            model.signinWithGoogle(context);
                                          },
                                          child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.white,
                                              child: SvgPicture.asset('assets/icons/google_logo.svg', height: 42)),
                                        ),
                                        SizedBox(width: 40),
                                        GestureDetector(
                                          onTap: (){
                                            model.signInWithFacebook(context);
                                          },
                                          child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.white,
                                              child: SvgPicture.asset('assets/icons/Facebook_logo.svg', height: 56)),
                                        ),
                                        SizedBox(width: 40),
                                        defaultTargetPlatform == TargetPlatform.iOS
                                            ? GestureDetector(
                                          onTap: (){
                                            model.signInWithApple(context);
                                          },
                                          child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.white,
                                              child: SvgPicture.asset('assets/icons/apple_logo.svg', height: 56,color: Colors.black)),
                                        )
                                            : const SizedBox(),
                                      ],
                                    ),
                                    const SizedBox(height: 50),
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          NavigationService().navigateTo(SignupView.routeName);
                                        },
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Don't have an account? ",
                                            style: TextStyle(color: Colors.grey),
                                            children: [
                                              TextSpan(
                                                text: 'Create Account',
                                                style: TextStyle(
                                                  color: Palette.primaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                    ])

                            ),
                          ),
                        ),
                      ),
                    ),
              )
            ));
  }

}
