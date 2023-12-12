import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/colors.dart';
import '../../core/utilities/widgets/rounded_button.dart';
import '../../core/utilities/widgets/text_field.dart';
import 'change_password_viewmodel.dart';

class ChangePasswordView extends StatelessWidget {
  static const routeName = 'changePasswordView';

  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => ChangePasswordViewModel(),
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
                                child: Form(
                                  key: model.formKey,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                          const SizedBox(height: 20),
                                          CustomTextBox(
                                              obscureText: true,
                                              hintText: 'Enter your old password',
                                              labelText: 'Old Password',
                                              controller: model.oldPasswordController),
                                          const SizedBox(height: 20),
                                          CustomTextBox(
                                              obscureText: true,
                                              hintText: 'Enter your new password',
                                              labelText: 'New Password',
                                              controller: model.newPasswordController),
                                          const SizedBox(height: 20),
                                          CustomTextBox(
                                              obscureText: true,
                                              hintText: 'Confirm your new password',
                                              labelText: 'Confirm Password',
                                              controller: model.confirmNewPasswordController),
                                          const SizedBox(height: 30),
                                          CustomButton(
                                              showLoadingIcon: model.isLoading,
                                              title: 'Save',
                                              onPressed: () {
                                                FocusScope.of(context).unfocus();
                                                if (model.formKey.currentState!.validate()) {
                                                }
                                              },
                                              buttonColor: Palette.primaryColor,
                                              textColor: Colors.white),
                                          const SizedBox(height: 40)
                                        ])
                                      ]),
                                ),
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
              'Change Password',
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

}
