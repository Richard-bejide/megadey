import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/colors.dart';
import '../../core/utilities/widgets/rounded_button.dart';
import '../../core/utilities/widgets/text_field.dart';
import 'change_phone_number_viewmodel.dart';

class ChangePhoneNumberView extends StatelessWidget {
  static const routeName = 'changePhoneNumberView';

  const ChangePhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePhoneNumberViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => ChangePhoneNumberViewModel(),
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
                                          Column( mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('New Phone Number',
                                                  style: TextStyle(
                                                      color: Palette.customGrey,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500)),
                                              const SizedBox(height: 3),
                                              InternationalPhoneNumberInput(
                                                onInputChanged: (PhoneNumber number) {
                                                  model.notifyListeners();
                                                  print(number.phoneNumber);
                                                },
                                                onSubmit: () {
                                                  model.notifyListeners();
                                                },
                                                onFieldSubmitted: (number) {
                                                  model.notifyListeners();
                                                },
                                                onSaved: (PhoneNumber number) {
                                                  model.notifyListeners();
                                                  print('on saved ${number.phoneNumber}');
                                                },
                                                onInputValidated: (bool value) {
                                                  print(value);
                                                },
                                                textStyle: TextStyle(fontSize: 14),
                                                selectorConfig:  SelectorConfig(
                                                  showFlags: false,
                                                  trailingSpace: false,
                                                  setSelectorButtonAsPrefixIcon: true,
                                                  leadingPadding: 0,
                                                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                                ),
                                                ignoreBlank: false,
                                                autoValidateMode: AutovalidateMode.disabled,
                                                selectorTextStyle:  TextStyle(color: Palette.customGrey),
                                                initialValue: model.number,
                                                textFieldController: model.phoneController,
                                                formatInput: true,
                                                keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                                                inputDecoration: InputDecoration(
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: 'Enter phone number',
                                                  disabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(4),
                                                      borderSide: BorderSide(color: Palette.primaryColor.withOpacity(0.2), width: 1.0)),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(4),
                                                      borderSide: BorderSide(color: Palette.primaryColor.withOpacity(0.2), width: 1.0)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(0),
                                                      borderSide: BorderSide(color: Palette.primaryColor)),
                                                  errorBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(0),
                                                      borderSide: BorderSide(color: Colors.red)),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(0),
                                                      borderSide: BorderSide(color: Palette.primaryColor)),
                                                ),
                                                inputBorder:  OutlineInputBorder(borderSide: BorderSide(color: Palette.primaryColor.withOpacity(0.2))),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextBox(
                                              enabled: false,
                                              hintText: 'Voter\'s card',
                                              labelText: 'Select ID',
                                              controller: model.idCardController),
                                          const SizedBox(height: 20),
                                          CustomTextBox(
                                              hintText: '23-024-3544',
                                              labelText: 'ID Number',
                                              controller: model.idCardNoController),
                                          const SizedBox(height: 20),
                                          CustomTextBox(
                                              hintText: 'Enter first Name',
                                              labelText: 'First Name',
                                              controller: model.firstNameController),
                                          const SizedBox(height: 20),
                                          CustomTextBox(
                                              hintText: 'Enter last Name',
                                              labelText: 'Last Name',
                                              controller: model.lastNameController),
                                          const SizedBox(height: 20),
                                          CustomTextBox(
                                              hintText: 'Enter your date of birth',
                                              labelText: 'Date of Birth',
                                              controller: model.dobController),
                                          const SizedBox(height: 20),
                                          GestureDetector(
                                            onTap: (){
                                              //upload
                                            },
                                            child: Container(
                                             padding: const EdgeInsets.all(14),
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(width: 1, color: Palette.primaryColor.withOpacity(0.2)),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children:[
                                                  SvgPicture.asset('assets/icons/document-upload.svg',height: 20,color: Colors.grey),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    'Upload ID Card',
                                                    style: TextStyle(
                                                      color: Color(0xFF727272),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                      letterSpacing: -0.33,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          CustomButton(
                                              showLoadingIcon: model.isLoading,
                                              title: 'Apply',
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
              'Change Phone Number',
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
