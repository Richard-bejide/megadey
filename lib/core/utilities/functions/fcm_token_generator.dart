import 'package:firebase_messaging/firebase_messaging.dart';

///function to generate fcm token
Future<String?> tokenGenerator() async {
  return await FirebaseMessaging.instance.getToken(
      // vapidKey: "BGRvOf4kCGkUOueWwQCIjjuCeHs3SX1hYJriTch2Rz-ukifUKD0hVt-EYtoUgYbNrddIQ6f09WZJVhDVIOE_IFo"
  );
}
