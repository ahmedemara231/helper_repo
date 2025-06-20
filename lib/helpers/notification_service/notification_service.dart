import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:helper_repo/helpers/cache.dart';

class NotificationService {
  NotificationService({
    required this.onNotificationTap,
    this.channels,
    this.onPermissionGranted,
    this.onPermissionDenied
  });

  final Function()? onPermissionGranted;
  final Function()? onPermissionDenied;

  final List<AndroidNotificationChannel>? channels;
  final Function(RemoteMessage message) onNotificationTap;


  Future<void> setUpNotificationsService() async {
    await _requestPermissions(
          () async => await _continueSettingUpNotificationService(),
          () {},
    );
  }

  Future<void> _continueSettingUpNotificationService()async{
    deviceId;
    if(Platform.isAndroid){
      await _createAndroidChannel(_androidChannel);
      await _createAndroidAppChannels();
    }
    _initLocalNotifications();
    _handleNotificationStates();
  }

  Future<void> _createAndroidAppChannels() async {
    if(channels != null){
      for (var channel in channels!) {
        await _createAndroidChannel(channel);
      }
    }
  }

  Future<String?> get deviceId async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    log('fcm token $fcmToken');
    return fcmToken;
  }

  Future<void> _handleReceivedForegroundNotification() async {
    FirebaseMessaging.onMessage
        .listen((event) => _showNotification(event)); // show local notification
  }

  final FlutterLocalNotificationsPlugin _localNotification = FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel _androidChannel = const AndroidNotificationChannel(
    'default',
    'default',
    description: 'default notification channel',
    importance: Importance.max,
    enableVibration: true,
    showBadge: true,
    enableLights: true,
    playSound: true,
  );

  InitializationSettings get _initSetting {
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const DarwinInitializationSettings iOSInitializationSettings = DarwinInitializationSettings(
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      defaultPresentBanner: true,
      requestSoundPermission: true,
      requestProvisionalPermission: true,
      requestCriticalPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      // onDidReceiveLocalNotification: Called only on iOS < 10 when a local notification is received while the app is in the foreground.
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );
    return initializationSettings;
  }

  Future<void> _initLocalNotifications() async {
    await _localNotification.initialize(
        _initSetting,
        // onDidReceiveBackgroundNotificationResponse: , (iOS 10+ only)
        // Called when user taps local notification and app is in background/terminated

        onDidReceiveNotificationResponse: (details) {
          onNotificationTap(
              RemoteMessage.fromMap(jsonDecode(details.payload!))
          );
        }
    );
  }

  Future<void> _createAndroidChannel(AndroidNotificationChannel channel) async {
    await _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _requestPermissions(Function() whenGranted, Function() whenDenied)async{
    if(Platform.isAndroid){
      _androidPermission(whenGranted, whenDenied);
    }
    if(Platform.isIOS){
      _iosPermission(whenGranted, whenDenied);
    }
  }

  Future<void> _iosPermission(Function() whenGranted, Function() whenDenied)async{
    final result = await _localNotification.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()?.checkPermissions();
    if(!result!.isEnabled){
      final requestResult = await _localNotification.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true);
      if(requestResult?? false){
        whenGranted();
        onPermissionGranted?.call();
        _setIosForegroundPresentationOptions();
      }else{
        whenDenied();
        onPermissionDenied?.call();
      }
    }else{
      final wasAcceptedBefore = await CacheStorage.read(isPermissionAcceptedBefore) ?? false;
      if(!wasAcceptedBefore){
        await CacheStorage.write(isPermissionAcceptedBefore, true);
        whenGranted();
        onPermissionGranted?.call();
      }
    }
  }

  final String isPermissionAcceptedBefore = 'isPermissionAcceptedBefore';
  void _androidPermission(Function() whenGranted, Function() whenDenied)async{
    final result = await _localNotification.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    if(result == null || !result){
      whenDenied();
      onPermissionDenied?.call();
    }else{
      final wasAcceptedBefore = await CacheStorage.read(isPermissionAcceptedBefore) ?? false;
      if (!wasAcceptedBefore) {
        await CacheStorage.write(isPermissionAcceptedBefore, true);
        whenGranted();
        onPermissionGranted?.call();
      }
    }
  }

  NotificationDetails get _notificationDetails {
    final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      _androidChannel.id,
      _androidChannel.name,
      channelDescription: _androidChannel.description,
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
      channelShowBadge: true,
      enableLights: true,
      playSound: true,
    );

    const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentBanner: true,
        presentSound: true
    );
    final NotificationDetails details = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iosNotificationDetails
    );
    return details;
  }

  Future<void> _showNotification(RemoteMessage message) async {
    await _localNotification.show(
        message.hashCode,
        message.notification?.title,
        message.notification?.body,
        _notificationDetails,
        payload: jsonEncode(message.toMap())
    );
  }

  void _handleNotificationStates() async{
    _handleReceivedForegroundNotification();
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log('the msg is ${event.toMap()}');
      onNotificationTap(
        event,
      );
    }); // handle tap from background
    await _handleTerminatedState();
  }

  Future<void> _handleTerminatedState() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if(message != null){
      onNotificationTap(
        message,
      );
    }
  }

  Future<void> _setIosForegroundPresentationOptions()async{
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true
    );
  }
}

Future<void> _backgroundHandler(RemoteMessage message) async {
  log(message.toMap().toString());
}