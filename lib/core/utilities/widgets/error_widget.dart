import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../enums/error_type.dart';

class ErrorScreen extends StatelessWidget {
  ErrorType errorType;
  Function() onTap;

  ErrorScreen({required this.errorType, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _errorType(context);
  }

  Widget _errorType(BuildContext context) {
    if (errorType == ErrorType.socketException) {
      return _errorView(icon: Icons.network_check_outlined, text: 'You\'re not connected to the internet.', context: context);
    } else if (errorType == ErrorType.httpException) {
      return _errorView(icon: Icons.http, text: 'Couldn\'t find the resource.', context: context);
    } else if (errorType == ErrorType.formatException) {
      return _errorView(icon: Icons.error_outline, text: 'Bad response format.', context: context);
    }
    return _errorView(icon: Icons.error_outline, text: 'An unexpected error has occurred.', context: context);
  }

  Widget _errorView({required IconData icon, required String text, required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30.0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(30.0),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.1)),
              child: Icon(
                icon,
                size: 30.0,
                color: Colors.grey,
              )),
          const SizedBox(height: 30.0),
          SizedBox(
            width: 200,
            child: Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400)),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0), color: Palette.transparent),
                  child: Text('Try again',
                      style: TextStyle(
                          color: Palette.primaryColor, fontSize: 16, fontWeight: FontWeight.w900)),
                )),
          ),
        ],
      ),
    );
  }
}
