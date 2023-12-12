import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class IconButtonWidget extends StatelessWidget {
  String iconPath;
  Function() onTap;

  IconButtonWidget({required this.iconPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: _size.height * 0.04,
        width: _size.width * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.3)),
        ),
        child: Center(
          child: SvgPicture.asset(iconPath,height: 16),
        ),
      ),
    );
  }
}
