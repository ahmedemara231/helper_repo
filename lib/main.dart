import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helper_repo/helpers/notification_service/notification_service.dart';
import 'package:helper_repo/widgets/easy_pagination.dart';
import 'package:helper_repo/widgets/internet_supporter_widget/test.dart';
import 'package:helper_repo/widgets/pop_scope_test/first_screen.dart' show FirstScreen;
import 'package:helper_repo/widgets/pop_scope_test/zero_screen.dart';
import 'package:helper_repo/widgets/route_aware/route_aware.dart';
import 'package:helper_repo/widgets/route_aware/route_observer.dart';
import 'package:helper_repo/widgets/route_aware/test.dart';
import 'package:helper_repo/widgets/socket_widget/test.dart';
import 'package:helper_repo/widgets/timer_test.dart';

import 'extentions/test.dart';
import 'helpers/permission_handler/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // log('done');
    // NotificationService(
    //     onReceiveForegroundNotification: (msg){},
    //     onNotificationTap: (message) {}
    // ).periodicallyShow(
    //     message: RemoteMessage(notification: RemoteNotification(title: 'title', body: 'body')),
    //     repeatInterval: RepeatInterval.everyMinute
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        AppNavigationObserver.instance,
        // AppRouteObserver.instance
      ],
      home: NotificationDemo(),
    );
  }
}


/// 1. Define your own Notification
class MyNotification extends Notification {
  final String message;
  MyNotification(this.message);
}

class NotificationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification Example")),
      body: Center(
        /// 3. Wrap subtree with NotificationListener
        child: NotificationListener<MyNotification>(
          onNotification: (notification) {
            debugPrint("🔔 Received notification: ${notification.message}");
            // return true = stop bubbling, false = let it go up further
            return true;
          },
          child: const NotificationSender(),
        ),
      ),
    );
  }
}

/// 2. Dispatch notification from a child widget
class NotificationSender extends StatelessWidget {
  const NotificationSender({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("Send Notification"),
      onPressed: () {
        // Dispatch notification upward
        MyNotification("Hello from child!").dispatch(context);
      },
    );
  }
}
