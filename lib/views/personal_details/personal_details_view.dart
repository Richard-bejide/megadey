import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:megadey_mobile/views/my_ads/my_ads_view.dart';
import 'package:megadey_mobile/views/personal_details/personal_details_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/constants/colors.dart';
import '../../core/utilities/widgets/rounded_button.dart';
import '../../core/utilities/widgets/text_field.dart';

class PersonalDetailsView extends StatelessWidget {
  static const routeName = 'personalDetailsView';

  const PersonalDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PersonalDetailsViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => PersonalDetailsViewModel(),
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
                                              enabled: false,
                                              hintText: 'Enter your full name',
                                              labelText: 'Full Name',
                                              controller: model.nameController),
                                          const SizedBox(height: 20),
                                          Column( mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Phone Number',
                                                  style: TextStyle(
                                                      color: Palette.customGrey,
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w500)),
                                              const SizedBox(height: 3),
                                              InternationalPhoneNumberInput(
                                                isEnabled: false,
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
                                              hintText: 'Enter your Email',
                                              labelText: 'Email',
                                              controller: model.emailController),
                                          const SizedBox(height: 20),
                                          CustomTextBox(
                                              hintText: 'Enter your address',
                                              labelText: 'Address Line',
                                              controller: model.addressController),
                                          const SizedBox(height: 20),
                                          CustomTextBox(
                                              hintText: 'Select your location',
                                              labelText: 'Location',
                                              controller: model.locationController),
                                          Padding(
                                            padding: const EdgeInsets.only(left:12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 10),
                                                Text(
                                                  'Social Media Links',
                                                  style: TextStyle(
                                                    color: Color(0xFF171717),
                                                    fontSize: 16,
                                                    // fontFamily: 'Circular Std',
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: -0.33,
                                                  )),
                                                Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset('assets/icons/facebook.svg',height: 30),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                          child: CustomTextBox(
                                                              hintText: 'paste your facebook page link',
                                                              labelText: '',
                                                              controller: model.facebookLinkController))
                                                    ]),
                                                const SizedBox(height: 5),
                                                Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SvgPicture.asset('assets/icons/twitter.svg',height: 30),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                          child: CustomTextBox(
                                                              hintText: 'paste your twitter page link',
                                                              labelText: '',
                                                              controller: model.twitterLinkController))
                                                    ]),
                                                const SizedBox(height: 5),
                                                Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Image.asset('assets/images/instagram.png',height: 33),
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                          child: CustomTextBox(
                                                              hintText: 'paste your instagram page link',
                                                              labelText: '',
                                                              controller: model.instaLinkController))
                                                    ]),
                                              ],
                                            ),
                                          ) ,
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
              'Personal Details',
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
