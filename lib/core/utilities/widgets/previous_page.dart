import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class PreviousPage extends StatelessWidget {
  const PreviousPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
      ),
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.red,
            size: 17.0,
          )),
    );
  }
}
