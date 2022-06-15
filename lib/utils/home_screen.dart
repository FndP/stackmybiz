import 'package:flutter/material.dart';
import 'notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  bool _notificationsAllowed = false;

  @override
  void initState() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);

    /*AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      _notificationsAllowed = isAllowed;
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    AwesomeNotifications().actionStream.listen((ReceivedAction action){
      print("Action received!");

      // Avoid to open the notification details page twice

    });*/
    super.initState();
  }

  /*Future<void> requestUserPermission() async {
    showDialog(
        context: context,
        builder: (_) =>
            NetworkGiffyDialog(
              buttonOkText: Text('Allow', style: TextStyle(color: Colors.white)),
              buttonCancelText: Text('Later', style: TextStyle(color: Colors.white)),
              buttonCancelColor: Colors.grey,
              buttonOkColor: Colors.deepPurple,
              buttonRadius: 0.0,
              image: Image.asset("assets/images/animated-bell.gif", fit: BoxFit.cover),
              title: Text('Get Notified!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600)
              ),
              description: Text('Allow Awesome Notifications to send to you beautiful notifications!',
                textAlign: TextAlign.center,
              ),
              onCancelButtonPressed: () async {
                Navigator.of(context).pop();
                _notificationsAllowed = await AwesomeNotifications().isNotificationAllowed();
                setState(() {
                  _notificationsAllowed = _notificationsAllowed;
                });
              },
              onOkButtonPressed: () async {
                Navigator.of(context).pop();
                await AwesomeNotifications().requestPermissionToSendNotifications();
                _notificationsAllowed = await AwesomeNotifications().isNotificationAllowed();
                setState(() {
                  _notificationsAllowed = _notificationsAllowed;
                });
              },
            )
    );
  }*/

  _changeData(String msg) => setState(() => notificationData = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showSnackBarWithTitleAndText(
            title: "This is local notification",message: "You just bookmarked.."
          );
        },
        child: Icon(Icons.notifications_active_outlined),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              notificationTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              notificationBody,
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              notificationData,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }

/*  void fireLocalNotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Simple Notification',
            body: 'Simple body'
        )
    );
  }*/

  void sendNotification() async {

    // if(!_notificationsAllowed){
    //   await requestUserPermission();
    // }

    if(!_notificationsAllowed){
      return;
    }

  /*  AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 100,
            channelKey: "basic_channel",
            title: "Huston! The eagle has landed!",
            body: "A small step for a man, but a giant leap to Flutter's community!",
            notificationLayout: NotificationLayout.BigPicture,
            largeIcon: "https://avidabloga.files.wordpress.com/2012/08/emmemc3b3riadeneilarmstrong3.jpg",
            bigPicture: "https://www.dw.com/image/49519617_303.jpg",
            showWhen: true,
            payload: {
              "secret": "Awesome Notifications Rocks!"
            }
        )
    );*/

  }

}