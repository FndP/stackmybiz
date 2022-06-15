import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    // Handle data message
    final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    final notification = message.data['notification'];
  }
  // Or do other work.
}

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final streamCtlr = StreamController<String>.broadcast();
  final titleCtlr = StreamController<String>.broadcast();
  final bodyCtlr = StreamController<String>.broadcast();

  setNotifications() {
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(
          (message) async {

        if (message.data.containsKey('data')) {
          // Handle data message
          // showSnackBarWithTitleAndText(message: message.data['data'],title: "");
          streamCtlr.sink.add(message.data['data']);
        }
        if (message.data.containsKey('notification')) {
          // Handle notification message
          // showSnackBarWithTitleAndText(message: message.data['notification'],title: "");
          streamCtlr.sink.add(message.data['notification']);
        }

        showSnackBarWithTitleAndText(message: message.notification!.body!,title: message.notification!.title!);
        // Or do other work.
        titleCtlr.sink.add(message.notification!.title!);
        bodyCtlr.sink.add(message.notification!.body!);
      },
    );
    // With this token you can test it easily on your phone
    final token =
    _firebaseMessaging.getToken().then((value) => print('Token: $value'));
  }

  dispose() {
    streamCtlr.close();
    bodyCtlr.close();
    titleCtlr.close();
  }
}


void showSnackBarWithTitleAndText({required String title, required String message}) {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 100,
          channelKey: "basic_channel",
          title: title,
          body:message,
          notificationLayout: NotificationLayout.BigPicture,
          largeIcon: "https://avidabloga.files.wordpress.com/2012/08/emmemc3b3riadeneilarmstrong3.jpg",
          bigPicture: "https://www.dw.com/image/49519617_303.jpg",
          showWhen: true,
          payload: {
            "secret": "Awesome Notifications Rocks!"
          }
      )
  );
/*  Get.snackbar(title, message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white *//*.withOpacity(0.5)*//*,
      animationDuration: Duration(milliseconds: 500),
      duration: Duration(seconds: 2));*/
}