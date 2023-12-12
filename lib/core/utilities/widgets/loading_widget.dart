import 'package:flutter/material.dart';
import 'animated_logo.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;
  final String? text;

  const LoadingWidget({Key? key, required this.color, this.text = 'Loading...'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           AnimatedLogo(color: color),
          const SizedBox(height: 15),
          Text(
              text!,
              style: TextStyle(
                  color:  color,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                  fontFamily: 'dm_sans')),
          const SizedBox(height: 8),
          SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              color:color,
              strokeWidth: 2,
            ),
          )

        ],
      )
    );
  }
}
