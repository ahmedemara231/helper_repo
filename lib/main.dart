import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helper_repo/helpers/notification_service/notification_service.dart';
import 'package:helper_repo/widgets/easy_pagination.dart';
import 'package:helper_repo/widgets/internet_supporter_widget/test.dart';
import 'package:helper_repo/widgets/route_aware/route_aware.dart';
import 'package:helper_repo/widgets/route_aware/route_observer.dart';
import 'package:helper_repo/widgets/route_aware/test.dart';
import 'package:helper_repo/widgets/socket_widget/test.dart';

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
      home: const PagifyTest(),
    );
  }
}
