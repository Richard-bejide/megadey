import 'package:flutter/material.dart';

class SkipPage extends StatelessWidget {
  final Function() onTap;
  const SkipPage({Key? key,required this.onTap}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0,top: 5.0),
      child: InkWell(
        onTap:onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text('Skip',
              style: TextStyle(
                  color: Colors.red, fontSize: 16, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
