// import 'package:flutter/cupertino.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:milk_meets_honey_mobile/utilities/functions/toast.dart';
// import 'package:shirne_dialog/shirne_dialog.dart';
//
// final String payStackPublicKey = dotenv.get('PAYSTACK_PUBLIC_KEY');
//
// //PAY WITH CREDIT CARD
// //async method to charge users card  using paystack and return a response
// void chargeCard(
//     {required BuildContext context,
//     required int amount,
//     required String accessCode,
//     required String email}) async {
//   String publicKeyTest = payStackPublicKey; //pass in the public test key obtained from paystack dashboard here
//   final plugin = PaystackPlugin();
//   //initialize the publicKey
//   await plugin.initialize(publicKey: publicKeyTest);
//   Charge charge = Charge()
//     ..amount = amount * 100 //the money should be in kobo hence the need to multiply the value by 100
//     ..reference = accessCode //reference
//     ..email = email; //receipt will be sent to the business email account
//   CheckoutResponse response = await plugin.checkout(context,
//       method: CheckoutMethod.card,
//       charge: charge,
//       fullscreen: true,
//       hideAmount: false,
//       hideEmail: true,
//       logo: Image.asset('assets/images/logo/Logo mark.png', height: 30.0));
//
//   //check if the response is true or not
//   if (response.status == true) {
//     //you can send some data from the response to an API or use webhook to record the payment on a database
//     plugin.dispose();
//     showToast(context: context, message: 'Payment successful', iconType: IconType.success);
//   } else {
//     //the payment wasn't successful or the user cancelled the payment
//     plugin.dispose();
//     showToast(context: context, message: 'Payment failed', iconType: IconType.error);
//   }
// }
