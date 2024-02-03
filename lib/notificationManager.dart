import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'main.dart'; // Ensure globalDebtList is defined here
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class NotificationManager {
  FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationManager() {
    tz.initializeTimeZones();  // Initialize timezone data
    var androidInitialize = const AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(android: androidInitialize);
    localNotificationsPlugin.initialize(initializationSettings);
  }

  void scheduleNotifications() {
    for (var debt in globalDebtList) {
      if (debt.dueDate.isBefore(DateTime.now())) {
        continue; // Skip past due debts
      }

      var scheduledNotificationDateTime = tz.TZDateTime.from(debt.dueDate, tz.local);
      var androidDetails = const AndroidNotificationDetails(
        "channel_id",  // 1st positional argument
        "channel_name",  // 2nd positional argument
        // Other parameters as named arguments
        channelDescription: "channel_description",
        importance: Importance.max,
        // Add other required named parameters here
      );
      var generalNotificationDetails = NotificationDetails(android: androidDetails);

      localNotificationsPlugin.zonedSchedule(
        debt.hashCode,
        'Debt Reminder',
        '${debt.debtorName} in the name of ${debt.amount} tl is due today!',
        scheduledNotificationDateTime,
        generalNotificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }
}