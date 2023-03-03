import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../const/const.dart';

class PushNotification {
  static OneSignalPushNotification() {
    OneSignal.shared.setAppId(AppConst.oneSignalAppID);

    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) async {
      // event.complete(event.notification);
      await LocalPushNotification(
          id: 01,
          title: event.notification.title,
          body: event.notification.body);
    });
  }

  static Future LocalPushNotification(
      {required id, required title, required body}) async {
    FlutterLocalNotificationsPlugin localNotificationsService =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");

    InitializationSettings settings =
        InitializationSettings(android: androidInitializationSettings);

    await localNotificationsService.initialize(settings);
    final notificationDetail = await _notificationDetails();
    await localNotificationsService.show(id, title, body, notificationDetail);
  }

  static Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "channelId",
      "channelName",
      channelDescription: "Your description",
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );
    return NotificationDetails(android: androidNotificationDetails);
  }
}
