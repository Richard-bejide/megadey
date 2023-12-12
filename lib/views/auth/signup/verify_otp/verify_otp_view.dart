import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:megadey_mobile/views/auth/signup/verify_otp/verify_otp_viewmodel.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import '../../../../core/utilities/palette.dart';
import '../../../../core/utilities/widgets/rounded_button.dart';

class SignupOtpView extends StatelessWidget {
  static const routeName = 'signupOtpView';

  const SignupOtpView({super.key});

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<SignupOtpViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => SignupOtpViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 2),
                                    child: Icon(Icons.keyboard_arrow_left,size: 24,color: Colors.black),
                                  )),
                              const SizedBox(height: 10),
                              Text(
                                'Verify email address',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 220,
                                child: Text(
                                    'Please enter the 4 digit code sent to the email you provided',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                              const SizedBox(height: 40),
                              Center(
                                child: Pinput(
                                  length: 6,
                                  defaultPinTheme: PinTheme(
                                    width: 60,
                                    height: 60,
                                    textStyle: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.w700),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey.withOpacity(0.3),width: 1)
                                    ),
                                  ),
                                  submittedPinTheme: PinTheme(
                                    width: 60,
                                    height: 60,
                                    textStyle: TextStyle(fontSize: 28, color:Colors.black, fontWeight: FontWeight.w700),
                                    decoration: BoxDecoration(
                                        color:  Palette.primaryColor.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.grey.withOpacity(0.3),width: 1)
                                    ),
                                  ),
                                  focusedPinTheme: PinTheme(
                                    width: 60,
                                    height: 60,
                                    textStyle: TextStyle(fontSize: 28, color:  Colors.black, fontWeight: FontWeight.w700),
                                    decoration: BoxDecoration(
                                        color: Palette.primaryColor.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Palette.primaryColor,width: 1)
                                    ),
                                  ),
                                  controller: model.otpController,
                                  obscureText: false,
                                  onChanged: (val){
                                    if(val.length != 6) {
                                      model.enabled = false;
                                    }
                                    model.notifyListeners();
                                  },
                                  onCompleted: (val) {
                                    //model.verifyOtp(context);
                                    FocusScope.of(context).unfocus();
                                    model.enabled = true;
                                    model.notifyListeners();
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Haven\'t received a code?',
                                    style: TextStyle(
                                      color: Color(0x7F333333),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: (){
                                      if(!model.isResendingOtp) {
                                        model.resendOtp(context);
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Resend',
                                          style: TextStyle(
                                            color: Palette.primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        model.isResendingOtp
                                            ? SizedBox(height: 20,width: 20,child: CircularProgressIndicator(color: Palette.primaryColor,strokeWidth: 2))
                                            : const SizedBox()
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 50),
                              CustomButton(
                                  iconColor: Colors.white,
                                  showLoadingIcon: model.isLoading,
                                  title: 'Confirm',
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    model.verifyOtp(context);
                                  },
                                  buttonColor: Palette.primaryColor,
                                  textColor: Colors.white),
                              const SizedBox(height: 40)
                            ]),
                  ),
                ),
              ),
            )
        ));
  }
}