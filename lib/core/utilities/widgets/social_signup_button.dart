import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialSignupButton extends StatelessWidget {
  String type;
  String buttonName;
  Function() onTap;
  bool showLoading;

  SocialSignupButton({
    Key? key,
    required this.buttonName,
    required this.onTap,
    required this.type,
     this.showLoading =false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
            width:double.maxFinite,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset('assets/images/logo/$type.svg',height: 24),
              const SizedBox(width: 20.0),
              Text(buttonName,
                  style: const TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.0,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700)),
              const SizedBox(width: 20.0),
              showLoading? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.black,strokeWidth: 3.0)):SizedBox()

            ])),
      ),
    );
  }
}
