// import 'dart:io';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:rkbuser/constants.dart';
//
// class NotificationServices {
//   /// Use this method to detect when a new notification or a schedule is created
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {}
//
//   /// Use this method to detect every time that a new notification is displayed
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {}
//
//   @pragma("vm:entry-point")
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedAction) async {}
//
//   /// Use this method to detect when the user taps on a notification or action button
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {}
//
//   static initAwesomeNotificationsPlugin() async {
//     await AwesomeNotifications().initialize(null, [
//       NotificationChannel(
//         channelGroupKey: notificationChannelGroupKey,
//         channelKey: notificationChannelKey,
//         channelName: notificationChannelName,
//         channelDescription: notificationChannelDescription,
//       )
//     ], channelGroups: [
//       NotificationChannelGroup(
//           channelGroupKey: notificationChannelGroupKey,
//           channelGroupName: notificationChannelGroupName)
//     ]);
//   }
//
//   static Future<void> requestNotificationPermission() async {
//     bool isAllowedNotifications = await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowedNotifications) {
//       AwesomeNotifications().requestPermissionToSendNotifications().then((value) {
//         if(!value)
//           {
//             exit(0);
//           }
//       });
//     }
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: NotificationServices.onActionReceivedMethod,
//       onDismissActionReceivedMethod: NotificationServices.onDismissActionReceivedMethod,
//       onNotificationCreatedMethod: NotificationServices.onNotificationCreatedMethod,
//       onNotificationDisplayedMethod: NotificationServices.onNotificationDisplayedMethod,
//     );
//
//   }
//
//   static void initIncomingNotifications() {
//     FirebaseMessaging.onMessage.listen((message) {
//       String title = message.notification!.title!;
//       String imageUrl = message.notification!.android?.imageUrl ?? "";
//       String body = message.notification?.body ?? "";
//       if(imageUrl == "") {
//         showTextNotification(title: title, body: body);
//       }
//       else{
//         showImageNotification(title: title, imageUrl: imageUrl);
//       }
//     });
//   }
//
//   static Future<void> showImageNotification({required String title, required String imageUrl}) async {
//     AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: 1,
//           channelKey: notificationChannelKey,
//           title: title,
//           bigPicture: imageUrl,
//           notificationLayout: NotificationLayout.BigPicture,
//           fullScreenIntent: true,
//         )
//     );
//   }
//
//   static Future<void> showTextNotification({required String title, required String body}) async {
//     AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: 1,
//           channelKey: notificationChannelKey,
//           title: title,
//           body: body,
//           notificationLayout: NotificationLayout.BigText
//         )
//     );
//   }
//
// }