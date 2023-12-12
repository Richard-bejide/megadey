import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  Color boxColor;
  Color borderColor;
  Widget title;
  Widget? subtitle;
  String iconType;
  double elevation;
  Function() onTap;

  OptionTile(
      {Key? key,
      required this.borderColor,
      required this.boxColor,
      required this.title,
        this.subtitle,
      required this.iconType,
      required this.elevation,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              side: BorderSide(color: borderColor.withOpacity(0.2), width: 1),
              backgroundColor: boxColor,
              foregroundColor:Colors.grey.withOpacity(0.05),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(alignment: Alignment.centerLeft, child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  const SizedBox(height: 5),
                  subtitle != null
                      ? subtitle!
                      : const SizedBox(),
                ],
              )),
              Container(alignment: Alignment.centerRight, child: Image.asset("assets/images/icons/$iconType.png"))
            ],
          ),
          onPressed: onTap),
    );
  }
}
