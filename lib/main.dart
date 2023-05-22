import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fit/Screen/HomePage.dart';
import 'package:fit/Screen/Login/Screens/Welcome/welcome_screen.dart';
import 'package:fit/Screen/Menu/NotificationManagerScreen.dart';
import 'package:fit/appLanguage/constanst.dart';
import 'package:fit/appLanguage/local_storage.dart';
import 'package:fit/fcm/NotificationPage.dart';
import 'package:fit/theme/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';

import 'appLanguage/stranslation_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.notification!.body);
  await Firebase.initializeApp();
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> _configureLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  WidgetsFlutterBinding.ensureInitialized();
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

late FirebaseMessaging messaging;
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void notificationTapBackground(NotificationResponse notificationResponse) {
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

Future<void> main() async {
  _configureLocalNotifications();
 // String? token= await FlutterSecureStorage().read(key: 'token')??"";
  //bool islogin=token.isNotEmpty;
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String? title = message.notification?.title;
    String? body = message.notification?.body;
    // Access additional custom data from the `data` field if present

    // Display the notification
    _showNotification(title??"Title", body??"body");
  });

  await GetStorage.init('MyStorage');
  final box = GetStorage('MyStorage');
  String? mode = box.read(THEME_KEY);
  print('mode is $mode');
  bool isLightMode = (mode != null && mode == "light");
  print('is dark mode $isLightMode');
  await LocalStorage.init();
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  //If subscribe based sent notification then use this token
  final fcmToken = await messaging.getToken();
  print("token ne:  "+fcmToken.toString());

  //If subscribe based on topic then use this
  await messaging.subscribeToTopic('flutter_notification');

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
        'flutter_notification', // id
        'flutter_notification_title', // title
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        showBadge: true,
        playSound: true
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = DarwinInitializationSettings();
    final initSettings = InitializationSettings(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin!.initialize(initSettings,
        onDidReceiveNotificationResponse: notificationTapBackground,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);

    await messaging
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  String token= await FlutterSecureStorage().read(key: 'token')??' ';
  print(token??"none");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: Routes.SPLASH,
      themeMode: isLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      defaultTransition: Transition.fade,
      //initialBinding: SplashBinding(),
      translations: TranslationService(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      //getPages: AppPages.pages,
      home:
      //NotificationsPage(),
      token==' '?WelcomeScreen():HomePage(),
      //KHÔNG ĐƯỢC SỬA Ở FILE NÀY KHI CHƯA CÓ Ý KIẾN CỦA LEADER
    ),
  );
}

void _showNotification(String title, String body) async {
  //const AndroidNotificationDetails androidPlatformChannelSpecifics =
   AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'your channel name', // Replace with your own channel name
        'your channel description', // Replace with your own channel description
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: BigTextStyleInformation(body, contentTitle: title),
      );
   NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
      0, title, body, platformChannelSpecifics,
      payload: 'item x');
}

class MyApp extends StatefulWidget {
 // bool islogin;
  //MyApp({Key? key, required this.islogin})
    //  : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Notification',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       navigatorKey: navigatorKey,
//       home: WelcomeScreen(),
//     );
//   }
// }

















// import 'package:firebase_core/firebase_core.dart';
// import 'package:fit/Screen/HomePage.dart';
// import 'package:fit/Screen/Login/Screens/Welcome/welcome_screen.dart';
// import 'package:fit/Screen/Menu/NotificationManagerScreen.dart';
// import 'package:fit/testMessage.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();
// await FirebaseMessaging.instance.getInitialMessage();
//     runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));}
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return TestScreen();
//   }
// }
