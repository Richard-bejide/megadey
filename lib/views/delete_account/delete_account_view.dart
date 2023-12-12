import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/colors.dart';
import '../../core/utilities/widgets/rounded_button.dart';
import 'delete_account_viewmodel.dart';

class DeleteAccountView extends StatelessWidget {
  static const routeName = 'deleteAccountView';

  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DeleteAccountViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => DeleteAccountViewModel(),
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
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          width: 300,
                                          child: Text(
                                            'Are you sure you want to delete your account as this action cannot be undone',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF262626),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        _buildDropdown(model),
                                        const SizedBox(height: 80),
                                        CustomButton(
                                            title: 'Confirm',
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                            },
                                            buttonColor: Palette.primaryColor,
                                            textColor: Colors.white),
                                        const SizedBox(height: 40)
                                      ])
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
              'Delete Account',
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

  Widget _buildDropdown(DeleteAccountViewModel model) {
    return Container(
      padding: const EdgeInsets.only(right: 6,left: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Palette.primaryColor.withOpacity(0.2),width: 0.5),
        borderRadius: BorderRadius.circular(10),
        color:Colors.white,
      ),
      child: DropdownButton<String>(
        value: model.selectedReason,
        isExpanded: true,
        hint: const Text("Why do you want to delete your account"),
        underline: const SizedBox(),
        items: model.reason.map<DropdownMenuItem<String>>((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (String? value) {
          if (value != null) model.selectedReason = value;
          model.notifyListeners();
        },
      ),
    );
  }


}
