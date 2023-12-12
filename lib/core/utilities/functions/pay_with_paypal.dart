// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_braintree/flutter_braintree.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:milk_meets_honey_mobile/utilities/functions/toast.dart';
// import 'package:shirne_dialog/shirne_dialog.dart';
//
// //PAY WITH PAYPAL
//
//
// final String paypalTokenizationKey = dotenv.get('PAYPAL_TOKENIZATION_KEY');
//
// Future<void> payWithPaypal({required String displayName, required String currencyCode,required BuildContext context,required int amount}) async{
//   final request = BraintreePayPalRequest(
//       amount:'${amount}',
//       currencyCode: currencyCode,
//       displayName: displayName,
//       billingAgreementDescription: 'I hereby agree to pay the sum of $currencyCode${amount}.'
//   );
//
//   BraintreePaymentMethodNonce? result = await Braintree.requestPaypalNonce(
//       paypalTokenizationKey,
//       request);
//
//   if (result != null) {
//     showNonce(result,context);
//   }else{
//     showToast(context: context, message: 'Payment Failed!!!', iconType: IconType.error);
//   }
// }
//
// void showNonce(BraintreePaymentMethodNonce nonce,BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (_) => AlertDialog(
//       title: Text('Paypal payment method'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Text('Nonce: ${nonce.nonce}'),
//           SizedBox(height: 16),
//           Text('Type label: ${nonce.typeLabel}'),
//           SizedBox(height: 16),
//           Text('Description: ${nonce.description}'),
//         ],
//       ),
//     ),
//   );
// }
//
