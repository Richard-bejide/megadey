import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CallRoundedButton extends StatelessWidget {
  const CallRoundedButton({
    Key? key,
    this.size = 64,
    required this.iconSrc,
    this.color = Colors.white,
    this.iconColor = Colors.black,
    required this.press,
  }) : super(key: key);

  final double size;
  final String iconSrc;
  final Color? color, iconColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child:ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          padding: EdgeInsets.all(15 / 64 * size),
          backgroundColor: color,
          foregroundColor: color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ),
        onPressed: press,
        child: SvgPicture.asset(iconSrc, color: iconColor),
      ),
    );
  }
}