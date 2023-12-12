import 'package:flutter/material.dart';

class NumericPad extends StatelessWidget {
  final Function(int) onNumberSelected;
 final Function() onBackButtonPressed;
  const NumericPad({required this.onNumberSelected,required this.onBackButtonPressed});

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height * 0.5,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: _size.height * 0.11,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(1, context),
                buildNumber(2, context),
                buildNumber(3, context),
              ],
            ),
          ),
          Container(
            height: _size.height * 0.11,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(4, context),
                buildNumber(5, context),
                buildNumber(6, context),
              ],
            ),
          ),
          Container(
            height: _size.height * 0.11,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNumber(7, context),
                buildNumber(8, context),
                buildNumber(9, context),
              ],
            ),
          ),
          Container(
            height: _size.height * 0.11,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildEmptySpace(),
                buildNumber(0, context),
                buildBackspace(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNumber(int number, context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onNumberSelected(number);
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration:  BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1F1F1F),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBackspace(context) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        onNumberSelected(-1);
        onBackButtonPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration:  BoxDecoration(
            color: Colors.grey.withOpacity(0.05),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.backspace_outlined,
              size: 25,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    ));
  }

  Widget buildEmptySpace() {
    return Expanded(
      child: Container(),
    );
  }
}
