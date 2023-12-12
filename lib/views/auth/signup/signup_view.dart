import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:megadey_mobile/core/utilities/widgets/loading_overlay_widget.dart';
import 'package:megadey_mobile/views/auth/signup/signup_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utilities/widgets/rounded_button.dart';
import '../../../core/utilities/widgets/text_field.dart';
import '../../../app/locator.dart';
import '../../../core/services/signup_service.dart';
import '../sign_in_with_email/sign_in_with_email_view.dart';

class SignupView extends StatelessWidget {
  static const routeName = 'signupView';

  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, child) => Material(
              child: LoadingOverlayWidget(
                isLoading: locator<SignupService>().showLoadingApple ||
                    locator<SignupService>().showLoadingFacebook ||
                    locator<SignupService>().showLoadingGoogle,
                child: Scaffold(
                    backgroundColor: Palette.backgroundColor,
                    body: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Create Account',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 300,
                                    child: Text(
                                      'Fill in the following information to create account and get started.',
                                      style: TextStyle(
                                          color: Palette.customGrey,
                                          letterSpacing: 0.0,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: model.signupKey,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 10),
                                                CustomTextBox(
                                                    hintText: 'Enter your Email',
                                                    labelText: 'Email',
                                                    onTap: () {
                                                      model.currentTextFieldIndex = 0;
                                                      model.notifyListeners();
                                                    },
                                                    validator: (inputValue) {
                                                      if (inputValue == null ||
                                                          inputValue.isEmpty) {
                                                        return 'Field is required';
                                                      }
                                                      if (!model.emailRegex.hasMatch(inputValue)) {
                                                        return 'Incorrect format';
                                                      }
                                                      return null;
                                                    },
                                                    controller: model.emailController),
                                                const SizedBox(height: 10),
                                                CustomTextBox(
                                                    hintText: 'Enter your first name',
                                                    labelText: 'First Name',
                                                    onTap: () {
                                                      model.currentTextFieldIndex = 1;
                                                      model.notifyListeners();
                                                    },
                                                    validator: (inputValue) {
                                                      if (inputValue == null ||
                                                          inputValue.isEmpty) {
                                                        return 'Field is required';
                                                      }
                                                      if (!model.nameRegex.hasMatch(inputValue)) {
                                                        return 'Incorrect format';
                                                      }
                                                      return null;
                                                    },
                                                    controller: model.firstNameController),
                                                const SizedBox(height: 10),
                                                CustomTextBox(
                                                    hintText: 'Enter your last name',
                                                    labelText: 'Last Name',
                                                    onTap: () {
                                                      model.currentTextFieldIndex = 2;
                                                      model.notifyListeners();
                                                    },
                                                    validator: (inputValue) {
                                                      if (inputValue == null ||
                                                          inputValue.isEmpty) {
                                                        return 'Field is required';
                                                      }
                                                      if (!model.nameRegex.hasMatch(inputValue)) {
                                                        return 'Incorrect format';
                                                      }
                                                      return null;
                                                    },
                                                    controller: model.lastNameController),
                                                const SizedBox(height: 10),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Phone Number',
                                                        style: TextStyle(
                                                            color: Palette.customGrey,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w500)),
                                                    const SizedBox(height: 3),
                                                    InternationalPhoneNumberInput(
                                                      onInputChanged: (PhoneNumber number) {
                                                        model.currentTextFieldIndex = 3;
                                                        model.notifyListeners();
                                                        print(number.phoneNumber);
                                                      },
                                                      onSubmit: () {
                                                        model.currentTextFieldIndex = 3;
                                                        model.notifyListeners();
                                                      },
                                                      onFieldSubmitted: (number) {
                                                        model.currentTextFieldIndex = 3;
                                                        model.notifyListeners();
                                                      },
                                                      onSaved: (PhoneNumber number) {
                                                        model.currentTextFieldIndex = 3;
                                                        model.notifyListeners();
                                                        model.phoneNumber = number.phoneNumber;
                                                        print('on saved ${number.phoneNumber}');
                                                      },
                                                      onInputValidated: (bool value) {
                                                        print(value);
                                                      },
                                                      textStyle: TextStyle(fontSize: 14),
                                                      selectorConfig: SelectorConfig(
                                                        showFlags: false,
                                                        trailingSpace: false,
                                                        setSelectorButtonAsPrefixIcon: true,
                                                        leadingPadding: 0,
                                                        selectorType:
                                                            PhoneInputSelectorType.BOTTOM_SHEET,
                                                      ),
                                                      ignoreBlank: false,
                                                      autoValidateMode: AutovalidateMode.disabled,
                                                      selectorTextStyle:
                                                          TextStyle(color: Palette.customGrey),
                                                      initialValue: model.number,
                                                      textFieldController: model.phoneController,
                                                      formatInput: true,
                                                      keyboardType:
                                                          const TextInputType.numberWithOptions(
                                                              signed: false, decimal: false),
                                                      inputDecoration: InputDecoration(
                                                        contentPadding: const EdgeInsets.symmetric(
                                                            vertical: 5.0, horizontal: 15.0),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        hintText: 'Enter phone number',
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(0),
                                                            borderSide: BorderSide(
                                                                color: Palette.primaryColor
                                                                    .withOpacity(0.2))),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(0),
                                                            borderSide: BorderSide(
                                                                color: Palette.primaryColor)),
                                                        errorBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(0),
                                                            borderSide:
                                                                BorderSide(color: Colors.red)),
                                                        focusedErrorBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(0),
                                                            borderSide: BorderSide(
                                                                color: Palette.primaryColor)),
                                                      ),
                                                      inputBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Palette.primaryColor
                                                                  .withOpacity(0.2))),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                CustomTextBox(
                                                    hintText: 'Enter Password',
                                                    labelText: 'Password',
                                                    onTap: () {
                                                      model.currentTextFieldIndex = 4;
                                                      model.notifyListeners();
                                                    },
                                                    obscureText: model.showPassword,
                                                    suffix: GestureDetector(
                                                      onTap: () {
                                                        model.showPassword = !model.showPassword;
                                                        model.notifyListeners();
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                        child: Icon(
                                                            model.showPassword
                                                                ? Icons.visibility_outlined
                                                                : Icons.visibility_off_outlined,
                                                            size: 20,
                                                            color: Palette.primaryColor),
                                                      ),
                                                    ),
                                                    validator: (inputValue) {
                                                      if (inputValue == null ||
                                                          inputValue.isEmpty) {
                                                        return 'Field is required';
                                                      }
                                                      return null;
                                                    },
                                                    controller: model.passwordController),
                                                const SizedBox(height: 10),
                                                CustomTextBox(
                                                    obscureText: model.showConfirmPassword,
                                                    suffix: GestureDetector(
                                                      onTap: () {
                                                        model.showConfirmPassword =
                                                            !model.showConfirmPassword;
                                                        model.notifyListeners();
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                        child: Icon(
                                                            model.showConfirmPassword
                                                                ? Icons.visibility_outlined
                                                                : Icons.visibility_off_outlined,
                                                            size: 20,
                                                            color: Palette.primaryColor),
                                                      ),
                                                    ),
                                                    hintText: 'Confirm Password',
                                                    labelText: 'Confirm Password',
                                                    onTap: () {
                                                      model.currentTextFieldIndex = 5;
                                                      model.notifyListeners();
                                                    },
                                                    validator: (inputValue) {
                                                      if (inputValue == null ||
                                                          inputValue.isEmpty) {
                                                        return 'Field is required';
                                                      }
                                                      if (inputValue !=
                                                          model.passwordController.text) {
                                                        return 'Passwords Mismatched';
                                                      }
                                                      return null;
                                                    },
                                                    controller: model.confirmPasswordController),
                                                const SizedBox(height: 20),
                                                CustomButton(
                                                    showLoadingIcon: model.isLoading,
                                                    title: 'Create Account',
                                                    onPressed: () {
                                                      FocusScope.of(context).unfocus();
                                                      if (model.signupKey.currentState!
                                                          .validate()) {
                                                        model.createAccount(context);
                                                      }
                                                    },
                                                    buttonColor: Palette.primaryColor,
                                                    textColor: Colors.white),
                                                InkWell(
                                                  highlightColor:
                                                      Palette.primaryColor.withOpacity(0.2),
                                                  onTap: () {
                                                    NavigationService()
                                                        .replaceWith(SignInWithEmailView.routeName);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('Already have an account?',
                                                            style: TextStyle(
                                                                color: Palette.customGrey,
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 14)),
                                                        Text(' Login',
                                                            style: TextStyle(
                                                                color: Palette.primaryColor,
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 14)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Row(children: [
                                                  Expanded(
                                                      child: Container(
                                                          color:
                                                              Palette.customGrey.withOpacity(0.3),
                                                          height: 1)),
                                                  const SizedBox(width: 2),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text('or continue with',
                                                        style: TextStyle(
                                                            color: Palette.customGrey,
                                                            fontSize: 13,
                                                            fontWeight: FontWeight.w300)),
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Expanded(
                                                      child: Container(
                                                          color:
                                                              Palette.customGrey.withOpacity(0.3),
                                                          height: 1)),
                                                ]),
                                                const SizedBox(height: 10),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        model.signUpWithGoogle(context);
                                                      },
                                                      child: CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor: Colors.white,
                                                          child: SvgPicture.asset(
                                                              'assets/icons/google_logo.svg',
                                                              height: 42)),
                                                    ),
                                                    SizedBox(width: 40),
                                                    GestureDetector(
                                                      onTap: () {
                                                        model.signUpWithFacebook(context);
                                                      },
                                                      child: CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor: Colors.white,
                                                          child: SvgPicture.asset(
                                                              'assets/icons/Facebook_logo.svg',
                                                              height: 56)),
                                                    ),
                                                    defaultTargetPlatform == TargetPlatform.iOS
                                                        ? Row(
                                                            children: [
                                                              SizedBox(width: 40),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  model.signUpWithApple(context);
                                                                },
                                                                child: CircleAvatar(
                                                                    radius: 20,
                                                                    backgroundColor: Colors.white,
                                                                    child: SvgPicture.asset(
                                                                        'assets/icons/apple_logo.svg',
                                                                        height: 56,
                                                                        color: Colors.black)),
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                                const SizedBox(height: 40)
                                              ])
                                        ]),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    )),
              ),
            ));
  }
}
