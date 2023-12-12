import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color borderColor;
  final String title;
  final void Function()? onPressed;
  final Color buttonColor;
  final Color textColor;
  final Color iconColor;
  final bool showLoadingIcon;

  CustomButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.buttonColor,
      required this.textColor,
      this.borderColor = Colors.transparent,
      this.iconColor = Colors.white,
      this.showLoadingIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Center(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 17),
                shape:  RoundedRectangleBorder(
                    side: BorderSide(color: borderColor),
                    borderRadius: BorderRadius.all(Radius.circular(0.0)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title,
                    style: TextStyle(
                        color: textColor,
                        letterSpacing: 0.0,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700)),
                showLoadingIcon
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(color: iconColor, strokeWidth: 3)))
                    : const SizedBox()
              ],
            ),
            onPressed: showLoadingIcon ? null : onPressed),
      ),
    );
  }
}
