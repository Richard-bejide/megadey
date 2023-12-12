import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utilities/widgets/rounded_button.dart';
import '../../../core/utilities/widgets/text_field.dart';
import 'forgot_password_viewmodel.dart';

class ForgotPasswordView extends StatelessWidget {
  static const routeName = 'ForgotPasswordView';

  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => ForgotPasswordViewModel(),
        builder: (context, model, child) => Material(
                child: Scaffold(
              backgroundColor: Palette.backgroundColor,
              body: SafeArea(
                child: WillPopScope(
                  onWillPop: () async {
                    if (model.currentPage == 3) {
                      model.currentPage = 2;
                      model.notifyListeners();
                    } else if (model.currentPage == 2) {
                      model.currentPage = 1;
                      model.notifyListeners();
                    }
                    // else if (model.currentPage == 1) {
                    //   return true;
                    // }
                    return true;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: getCurrentPage(model, context),
                    ),
                  ),
                ),
              ),
            )));
  }

  Widget getCurrentPage(ForgotPasswordViewModel model, BuildContext context) {
    if (model.currentPage == 2) {
      return secondPage(model, context);
    }
    if (model.currentPage == 3) {
      return thirdPage(model, context);
    } else {
      return firstPage(model, context);
    }
  }

  Widget firstPage(ForgotPasswordViewModel model, BuildContext context) {
    return Form(
        key: model.formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Forgot Password?',
                    style: const TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.0,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Enter the email address associated with your account, and we’ll send a password reset link there.',
                    style: TextStyle(
                        color: Palette.customGrey,
                        letterSpacing: 0.0,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextBox(
                  hintText: 'Enter your Email',
                  labelText: 'Email',
                  labelColor:
                      model.currentTextFieldIndex == 0 ? Palette.primaryColor : Palette.customGrey,
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
              const SizedBox(height: 40),
              CustomButton(
                  showLoadingIcon: model.isLoading,
                  title: 'Reset',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (model.formKey.currentState!.validate()) {
                      model.resetPassword(context);
                    }
                  },
                  buttonColor: Palette.primaryColor,
                  textColor: Colors.white),
              const SizedBox(height: 40),
            ]));
  }

  Widget secondPage(ForgotPasswordViewModel model, BuildContext context) {
    return Form(
        key: model.formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: () {
                      model.currentPage = 1;
                      model.notifyListeners();
                    },
                    child: Icon(Icons.arrow_back_ios_new, size: 25, color: Colors.black)),
              ),
              const SizedBox(height: 80),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/mail-icon.png',
                      color: Palette.primaryColor, height: 100, width: 100),
                  const SizedBox(height: 40),
                  Text(
                    'Check your mail',
                    textAlign: TextAlign.center,
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
                      'We’ve sent a password recover link to your mail check your mail for instructions.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Palette.customGrey,
                          letterSpacing: 0.0,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              CustomButton(
                  showLoadingIcon: model.isLoading,
                  title: 'Open Mail App',
                  onPressed: () {
                    model.openMailApp();
                  },
                  buttonColor: Palette.primaryColor,
                  textColor: Colors.white),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Did not receive the mail? Try checking',
                        style: TextStyle(
                            color: Palette.customGrey, fontWeight: FontWeight.w400, fontSize: 14)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(' your spam folder or',
                            style: TextStyle(
                                color: Palette.customGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: 14)),
                        InkWell(
                            highlightColor: Palette.primaryColor.withOpacity(0.2),
                            onTap: () {},
                            child: Text(' Try again',
                                style: TextStyle(
                                    color: Palette.primaryColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ]));
  }

  Widget thirdPage(ForgotPasswordViewModel model, BuildContext context) {
    return Form(
        key: model.formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        model.currentPage = 2;
                        model.notifyListeners();
                      },
                      child: Icon(Icons.arrow_back_ios_new, size: 25, color: Colors.black)),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Create new password',
                        style: const TextStyle(
                            color: Colors.black,
                            letterSpacing: 0.0,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 250,
                        child: Text(
                          'your new password must be different from previously used passwords',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Palette.customGrey,
                              letterSpacing: 0.0,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextBox(
                  hintText: 'Enter Password',
                  labelText: 'New Password',
                  labelColor:
                      model.currentTextFieldIndex == 2 ? Palette.primaryColor : Palette.customGrey,
                  onTap: () {
                    model.currentTextFieldIndex = 2;
                    model.notifyListeners();
                  },
                  obscureText: model.showPassword,
                  suffix: GestureDetector(
                    onTap: () {
                      model.showPassword == !model.showPassword;
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
              const SizedBox(height: 20),
              CustomTextBox(
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                  labelColor:
                      model.currentTextFieldIndex == 3 ? Palette.primaryColor : Palette.customGrey,
                  onTap: () {
                    model.currentTextFieldIndex = 3;
                    model.notifyListeners();
                  },
                  obscureText: model.showConfirmPassword,
                  suffix: GestureDetector(
                    onTap: () {
                      model.showConfirmPassword == !model.showConfirmPassword;
                      model.notifyListeners();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(
                          model.showConfirmPassword
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
                    if (inputValue != model.passwordController.text) {
                      return 'Passwords Mismatched';
                    }
                    return null;
                  },
                  controller: model.confirmPasswordController),
              const SizedBox(height: 100),
              CustomButton(
                showLoadingIcon: model.isLoading,
                  title: 'Reset and Continue',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (model.formKey.currentState!.validate()) {
                      model.setNewPassword(context);
                    }
                  },
                  buttonColor: Palette.primaryColor,
                  textColor: Colors.white),
              const SizedBox(height: 40),
            ]));
  }
}
