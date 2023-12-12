import 'package:flutter/cupertino.dart';

class PlanTypeWidget extends StatelessWidget {
  final Color bgColor;
  final Color titleColor;
  final Color subtitleColor;
  final Color? buttonNameColor;
  final Color? buttonColor;
  final String titleText;
  final String? subtitleText;
  final Function()? buttonOnTap;

  const PlanTypeWidget(
      {Key? key,
      required this.bgColor,
      required this.titleColor,
      required this.subtitleColor,
      this.buttonNameColor,
      this.buttonColor,
      required this.titleText,
       this.subtitleText,
      this.buttonOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              titleText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: titleColor,
                  fontFamily: '',
                  letterSpacing: 0.0,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10.0),
            subtitleText != null
            ? SizedBox(
              width: 200.0,
              child: Text(
                 subtitleText!,
                style: TextStyle(
                    color: subtitleColor,
                    letterSpacing: 0.0,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            )
            : const SizedBox(),
            const SizedBox(height: 20.0),
            buttonOnTap != null
                ? GestureDetector(
              onTap: buttonOnTap,
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                          color: buttonColor, borderRadius: BorderRadius.circular(12.0)),
                      child: Text(
                        'See Price',
                        style: TextStyle(
                            color: buttonNameColor,
                            letterSpacing: 0.0,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                )
                : SizedBox(),
            const SizedBox(height: 10.0),
          ],
        ));
  }
}
