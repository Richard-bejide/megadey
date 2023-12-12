import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:megadey_mobile/route_generator.dart';
import 'package:megadey_mobile/views/startup/startup_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/locator.dart';
import 'core/utilities/functions/create_material_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //sets device orientation to portrait mode only
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //change status bar color and brightness
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
  await dotenv.load(fileName: ".env");
  await setupLocator();
  // await Firebase.initializeApp(name :'megadey', options: DefaultFirebaseOptions.currentPlatform);
  // await requestNotificationPermissions();
  // //for receiving fcm messages in background
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // //for receiving fcm messages in foreground
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   RemoteNotification? notification = message.notification;
  //   RemoteMessage? remoteMessage = message;
  //   print("fcm data: ${message.data}");
  //   setupInteractedMessage(remoteMessage);
  //   if (notification != null && message.notification?.android != null) {
  //     flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             'high_importance_channel',
  //             'High Importance Notifications',
  //             icon: "@mipmap/ic_launcher", //android.smallIcon
  //           ),
  //         ));
  //   }
  // });

  runApp(const megadeyApp());
}

class megadeyApp extends StatelessWidget {
  const megadeyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'megaday',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xFFF6F6F6)),
        fontFamily: 'dm_sans',
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
     // navigatorObservers: [locator<AnalyticsService>().getAnalyticsObserver()],
      navigatorKey: locator<NavigationService>().navigatorKey,
      home: const StartupView(),
    );
  }
}

/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("fcm notification: title - ${message.notification?.title}, body - ${message.notification?.body}");
  print("fcm data: ${message.data}");
}*/

