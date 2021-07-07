import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show File, Platform;
import 'package:http/http.dart' as http;
import 'package:rxdart/subjects.dart';

class NotificationPlugin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  //final BehaviorSubject<ReceivedNotification> didReceivedLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
  var initializationSettings;

  NotificationPlugin._() {
    init();
  }

  init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    //if (Platform.isIOS) {
      //_requestIOSPermission();
    //}
    initializePlatformSpecifics();
  }

  initializePlatformSpecifics() {
    var initializationSettingsAndroid = AndroidInitializationSettings('raindrop');
    //var initializationSettingsIOS = IOSInitializationSettings(
      //requestAlertPermission: true,
      //requestBadgePermission: true,
      //requestSoundPermission: false,
      //onDidReceiveLocalNotification: (id, title, body, payload) async {
        //ReceivedNotification receivedNotification = ReceivedNotification(
          //  id: id, title: title, body: body, payload: payload);
        //didReceivedLocalNotificationSubject.add(receivedNotification);
      //},
    //);//
    initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  }

  //_requestIOSPermission() {
   // flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>().requestPermissions(
     // alert: false,
      //badge: true,
      //sound: true,
    //);
  //}

  //setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    //didReceivedLocalNotificationSubject.listen((receivedNotification) {
      //onNotificationInLowerVersions(receivedNotification);
    //});
  //}

  //setOnNotificationClick(Function onNotificationClick) async {
    //await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      //  onSelectNotification: (String payload) async {
        //  onNotificationClick(payload);
        //});
  //}

  Future<void> showNotification() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    //var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Deneme',
      'Deneme', //null
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }


  Future<void> showDailyAtTime9() async {
    var time = Time(9, 0, 0);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 6',
      'CHANNEL_NAME 6',
      "CHANNEL_DESCRIPTION 6",
      importance: Importance.max,
      priority: Priority.high,
    );
   // var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Water Time',
      'Drink water for your body', //null
      time,
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> showDailyAtTime12() async {
    var time = Time(12, 28, 03);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 7',
      'CHANNEL_NAME 7',
      "CHANNEL_DESCRIPTION 7",
      importance: Importance.max,
      priority: Priority.high,
    );
    // var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Water Time',
      'Drink water for your body', //null
      time,
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }
  Future<void> showDailyAtTime15() async {
    var time = Time(15, 0, 0);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 8',
      'CHANNEL_NAME 8',
      "CHANNEL_DESCRIPTION 8",
      importance: Importance.max,
      priority: Priority.high,
    );
    // var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Water Time',
      'Drink water for your body', //null
      time,
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> showDailyAtTime18() async {
    var time = Time(18, 0, 0);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 9',
      'CHANNEL_NAME 9',
      "CHANNEL_DESCRIPTION 9",
      importance: Importance.max,
      priority: Priority.high,
    );
    // var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Water Time',
      'Drink water for your body', //null
      time,
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> showDailyAtTime21() async {
    var time = Time(21, 0, 0);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 10',
      'CHANNEL_NAME 10',
      "CHANNEL_DESCRIPTION 10",
      importance: Importance.max,
      priority: Priority.high,
    );
    // var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Water Time',
      'Drink water for your body', //null
      time,
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> showWeeklyAtDayTime() async {
    var time = Time(21, 5, 0);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 5',
      'CHANNEL_NAME 5',
      "CHANNEL_DESCRIPTION 5",
      importance: Importance.max,
      priority: Priority.high,
    );
    //var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
      0,
      'Test Title at ${time.hour}:${time.minute}.${time.second}',
      'Test Body', //null
      Day.saturday,
      time,
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> repeatNotification() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 3',
      'CHANNEL_NAME 3',
      "CHANNEL_DESCRIPTION 3",
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: DefaultStyleInformation(true, true),
    );
    //var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Repeating Test Title',
      'Repeating Test Body',
      RepeatInterval.hourly,
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> scheduleNotification() async {
    var scheduleNotificationDateTime = DateTime.now().add(Duration(minutes: 90));
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 1',
      'CHANNEL_NAME 1',
      "CHANNEL_DESCRIPTION 1",
      icon: 'raindrop',
      largeIcon: DrawableResourceAndroidBitmap('raindrop'),
      enableLights: true,
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: DefaultStyleInformation(true, true),
    );
    //var iosChannelSpecifics = IOSNotificationDetails(
     // sound: 'my_sound.aiff',
    //);
    var platformChannelSpecifics = NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'Water Time',
      'Drink water for your body',
      scheduleNotificationDateTime,
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }

  Future<void> showNotificationWithAttachment() async {
    var attachmentPicturePath = await _downloadAndSaveFile(
        'https://via.placeholder.com/800x200', 'attachment_img.jpg');
    //var iosChannelSpecifics = IOSNotificationDetails(
     // attachments: [IOSNotificationAttachment(attachmentPicturePath)],
    //);
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(attachmentPicturePath),
      contentTitle: '<b>Attached Image</b>',
      htmlFormatContentTitle: true,
      summaryText: 'Test Image',
      htmlFormatSummaryText: true,
    );
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL ID 2',
      'CHANNEL NAME 2',
      'CHANNEL DESCRIPTION 2',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );
    var notificationDetails =
    NotificationDetails(android: androidChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Title with attachment',
      'Body with Attachment',
      notificationDetails,
    );
  }

  _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(url);
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<int> getPendingNotificationCount() async {
    List<PendingNotificationRequest> p =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return p.length;
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();

//class ReceivedNotification {
  //final int id;
  //final String title;
  //final String body;
  //final String payload;
  //ReceivedNotification({
    //@required this.id,
    //@required this.title,
    //@required this.body,
    //@required this.payload,
// });
//}