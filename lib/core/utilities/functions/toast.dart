import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../enums/toast_type.dart';

void showToast(
    {required BuildContext context, required String message, required ToastMessageType messageType}) {
  //alert(context: context, message: message, alertType: messageType);
  showSnackBar(context: context, message: message, alertType: messageType);
}


void showSnackBar({required BuildContext context, required String message,required ToastMessageType alertType}) {
  if (alertType == ToastMessageType.success) {
    return showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          messagePadding : const EdgeInsets.symmetric(horizontal: 15),
          maxLines: 3,
          textStyle : const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white,fontFamily: 'sora'),
          message: message,
        )
    );
  } else if (alertType == ToastMessageType.info) {
    return showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          messagePadding : const EdgeInsets.symmetric(horizontal: 15),
          maxLines: 3,
          textStyle : const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white,fontFamily: 'sora'),
          message: message,
        )
    );
  } else {
    Vibrate.vibrate(); //vibrate device
    return showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          messagePadding : const EdgeInsets.symmetric(horizontal: 15),
          maxLines: 3,
          textStyle : const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white,fontFamily: 'sora'),
          message: message,
        )
    );
  }
}

//
// Future<bool?> alert({
//   required BuildContext context,
//   required String message,
//   required ToastMessageType alertType,
// }) {
//   return Alert(
//     context: context,
//     title:getTitle(alertType),
//     desc: message,
//     image: Lottie.asset(_getImage(alertType),height: 100,width: 100),
//     padding: const EdgeInsets.all(20),
//     closeIcon:  Padding(
//         padding:  const EdgeInsets.only(right:10.0),
//         child:  Container(
//           height: 30,
//           width: 30,
//           decoration:  BoxDecoration(
//               shape: BoxShape.circle, color:  Colors.black.withOpacity(0.05)),
//           child:const  Icon(
//               Icons.close,
//               size: 18,
//               color: Colors.black87
//           ),
//         )),
//     style: AlertStyle(
//       backgroundColor: Colors.white,
//       overlayColor: Colors.black54,
//       isButtonVisible: false,
//       animationType: AnimationType.grow,
//       buttonAreaPadding: const EdgeInsets.all(0),
//       alertPadding: const EdgeInsets.all(4),
//       constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.8,maxWidth: MediaQuery.of(context).size.width * 0.8),
//       titleStyle:  TextStyle(color: getColor(alertType), fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'sora'),
//       descStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 14, fontFamily: 'sora'),
//       isCloseButton: true,
//       isOverlayTapDismiss: true,
//       descTextAlign: TextAlign.center,
//       animationDuration: const Duration(milliseconds: 400),
//       alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       alertAlignment: Alignment.center,
//     ),
//     // type: alertType,
//   ).show();
// }
//
// Color getColor(ToastMessageType type) {
//   if (type == ToastMessageType.success) {
//     return Colors.green;
//   }
//   if (type == ToastMessageType.info) {
//     return Colors.blue;
//   }
//   return Colors.red;
// }
//
// String _getImage(ToastMessageType type) {
//   if (type == ToastMessageType.success) {
//     return 'assets/animations/success.json';
//   }
//   if (type == ToastMessageType.info) {
//     return 'assets/animations/info.json';
//   }
//   return 'assets/animations/error.json';
// }
//
// String getTitle(ToastMessageType type) {
//   if (type == ToastMessageType.success) {
//     return 'Successful';
//   }
//   if (type == ToastMessageType.info) {
//     return 'Info';
//   }
//   return 'Failed';
// }
//
//
// AlertType getAlertType(ToastMessageType type) {
//   if (type == ToastMessageType.success) {
//     return AlertType.success;
//   }
//   if (type == ToastMessageType.info) {
//     return   AlertType.info;
//   }
//   return  AlertType.error;
// }

