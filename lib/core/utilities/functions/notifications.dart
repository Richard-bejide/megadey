//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked_services/stacked_services.dart';


///NOTIFICATIONS

///request permissions for fcm
Future<void> requestNotificationPermissions() async {
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  /////////
  //for ios
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  //for android
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}
//
// /// init awesome notification for local notifications
// void initAwesomeNotifications() {
//   AwesomeNotifications().initialize(null, // icon for your app notification
//       [
//         NotificationChannel(
//             channelKey: 'key1',
//             channelName: 'MMH',
//             channelDescription: "notification",
//             //defaultColor: Color(0XFF9050DD),
//             //ledColor: Colors.white,
//             playSound: true,
//             enableLights: true,
//             enableVibration: true)
//       ]);
// }

///WHEN FCM NOTIFICATION IS TAPPED EITHER IN FOREGROUND OR BACKGROUND
Future<void> setupInteractedMessage(RemoteMessage? message) async {
    // if (message != null && message.data['call_type'] != null) {
    //   locator<CallService>().setMatchName = message.data['caller_name'];
    //   locator<NavigationService>().navigateTo(PickupView.routeName);
    // }
}

//
// ///for local notifications
// void basicNotification(
//     {required int id,
//       required String title,
//       required String body,
//       String? image,
//       required NotificationSchedule schedule}) async {
//   AwesomeNotifications().createNotification(
//       content: NotificationContent(
//           id: id,
//           channelKey: 'key1',
//           title: title,
//           notificationLayout: NotificationLayout.BigText,
//           body: body,
//           largeIcon: image,
//           displayOnBackground: true,
//           displayOnForeground: true,
//           wakeUpScreen: true),
//       schedule: schedule);
// }
//
// ///
// void notificationWithButton(
//     {required BuildContext context,
//       required int id,
//       required String title,
//       required String body,
//       String? image,
//       required NotificationSchedule schedule}) async {
//   AwesomeNotifications().createNotification(
//       content: NotificationContent(
//           id: id,
//           channelKey: 'key1',
//           title: title,
//           body: body,
//           largeIcon: image,
//           displayOnBackground: true,
//           displayOnForeground: true,
//           wakeUpScreen: true),
//       schedule: schedule,
//       actionButtons: [
//         NotificationActionButton(
//           key: 'button1',
//           label: 'Button1',
//           enabled: true,
//           color: Palette.primaryColor,
//         )
//       ]);
//   AwesomeNotifications().actionStream.listen((
//       action,
//       ) {
//     if (action.buttonKeyPressed == 'button1') {
//       //locator<NavigationService>().navigateTo(Routes.view);
//     }
//   });
// }
//
// ///to list all local scheduled notifications
// Future<void> listScheduledNotifications(BuildContext context) async {
//   List<NotificationModel> activeSchedules =
//   await AwesomeNotifications().listScheduledNotifications();
//   for (NotificationModel schedule in activeSchedules) {
//     debugPrint('pending notification: ['
//         'id: ${schedule.content!.id}, '
//         'title: ${schedule.content!.titleWithoutHtml}, '
//         'schedule: ${schedule.schedule.toString()}'
//         ']');
//   }
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         content: Text('${activeSchedules.length} schedules founded'),
//         actions: [
//           TextButton(
//             child: Text('OK', style: TextStyle(color: Colors.black)),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
