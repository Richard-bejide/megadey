import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'animated_logo.dart';

class LoadingOverlayWidget extends StatelessWidget {
  final bool isLoading;
  final String? loadingText;
  final Widget child;

  const LoadingOverlayWidget({Key? key, required this.isLoading, required this.child,this.loadingText = 'Please wait...'})
      : super(key: key);


  @override
  Widget build(BuildContext context) {

    return LoadingOverlay(
      opacity: 0.5,
      color: Colors.black,
      isLoading: isLoading,
      progressIndicator: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           AnimatedLogo(color: Colors.white),
          const SizedBox(height: 15),
          Text(
              loadingText!,
              style: TextStyle(
                  color:  Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                  fontFamily: 'dm_sans')),
          const SizedBox(height: 8),
          SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              color:Colors.white,
              strokeWidth: 2,
            ),
          )

        ],
      ),
      child: child,
    );
  }
}