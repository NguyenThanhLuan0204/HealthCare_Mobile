import 'dart:convert';
import 'package:fit/Screen/Login/Screens/Welcome/welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web_socket_channel/io.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<bool> isAdmin() async {
  var readAdmin = await const FlutterSecureStorage().read(key: 'isAdmin');
  return readAdmin == "admin" ? true : false;
}

class SocketData {
  String? type;
  String? message;

  SocketData({this.type, this.message});

  SocketData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    return data;
  }
}

Future<String> getDashboardNumber() async {
  var token = await const FlutterSecureStorage().read(key: "token");
  var headers = {'Authorization': 'Bearer $token'};
  var request = http.Request('GET',
      Uri.parse('http://157.245.204.4:8080/api/v1/dashboard/get_db_card'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  var data = await response.stream.bytesToString();
  if (response.statusCode == 200) {
    print(data);
    return data;
  } else {
    print(response.reasonPhrase);
  }
  return "";
}

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Dashboard> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late IOWebSocketChannel webSocketChannel;
  late String text;
  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    webSocketChannel = IOWebSocketChannel.connect('ws://157.245.204.4:5000');
    webSocketChannel.stream.listen((data) {
      text = data.toString();
//noti.fromJson(text)
      // _showNotification(text);
    });
  }

  Future<void> _showNotification(String datatext) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'MEDI HEART', datatext, platformChannelSpecifics,
        payload: 'item x');
  }

  @override
  void dispose() {
    webSocketChannel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    webSocketChannel.sink.add('{"event":"sync","data":{"warning":"BT"}}');
    return Scaffold(
      body: FutureBuilder<String>(
          future: getDashboardNumber(),
          builder: (context, snapshotDashboard) {
            if (snapshotDashboard.hasData) {
              // if (snapshotDashboard.data == '') {
              //   const FlutterSecureStorage().deleteAll();
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) {
              //         return const WelcomeScreen();
              //       },
              //     ),
              //   );
              // };
              List<String> dataDashboard;
              dataDashboard = snapshotDashboard.data!
                  .replaceAll("[", "")
                  .replaceAll("]", "")
                  .split(",")
                  .map((e) => e)
                  .toList();
              var doctor = dataDashboard[0];
              var patients = dataDashboard[1];
              var iot = dataDashboard[2];
              var hospital = dataDashboard[3];
              var rule = dataDashboard[4];
              var record = dataDashboard[5];
              return FutureBuilder<bool>(
                  future: isAdmin(),
                  builder: (context, snapshot1) {
                    if (snapshot1.hasData) {
                      bool isAdmin = snapshot1.data!;
                      return Container(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            isAdmin
                                ? InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.yellow,
                                            Colors.orange
                                          ],
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.all(20.0),
                                      child: Container(
                                          margin: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    doctor.toString(),
                                                    style: TextStyle(
                                                        fontSize: 45,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text('Doctors'.tr,
                                                      style: TextStyle(
                                                          fontSize: 20))
                                                ],
                                              ),
                                              Container(
                                                width: 100,
                                                height: 100,
                                                child: Image.asset(
                                                    'images/dashboard/user-pin-regular-24.png'),
                                              ),
                                            ],
                                          )),
                                    ))
                                : Container(),
                            isAdmin
                                ? InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.cyanAccent,
                                            Colors.green
                                          ],
                                        ),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.all(20.0),
                                      child: Container(
                                          margin: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    patients.toString(),
                                                    style: TextStyle(
                                                        fontSize: 45,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text('Patients'.tr,
                                                      style: TextStyle(
                                                          fontSize: 20))
                                                ],
                                              ),
                                              Container(
                                                width: 100,
                                                height: 100,
                                                child: Image.asset(
                                                    'images/dashboard/body-regular-24.png'),
                                              ),
                                            ],
                                          )),
                                    ))
                                : Container(),
                            InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.deepPurpleAccent,
                                        Colors.green
                                      ],
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  margin: const EdgeInsets.all(20.0),
                                  child: Container(
                                      margin: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                iot.toString(),
                                                style: TextStyle(
                                                    fontSize: 45,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('HeartBeat-IOT'.tr,
                                                  style:
                                                      TextStyle(fontSize: 20))
                                            ],
                                          ),
                                          Container(
                                            width: 100,
                                            height: 100,
                                            child: Image.asset(
                                                'images/dashboard/devices-regular-24.png'),
                                          ),
                                        ],
                                      )),
                                )),
                            InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.pinkAccent,
                                        Colors.purple
                                      ],
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  margin: const EdgeInsets.all(20.0),
                                  child: Container(
                                      margin: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                hospital.toString(),
                                                style: TextStyle(
                                                    fontSize: 45,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('Hospitals'.tr,
                                                  style:
                                                      TextStyle(fontSize: 20))
                                            ],
                                          ),
                                          Container(
                                            width: 100,
                                            height: 100,
                                            child: Image.asset(
                                                'images/dashboard/clinic-regular-24.png'),
                                          ),
                                        ],
                                      )),
                                )),
                            InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.indigoAccent,
                                        Colors.deepPurple
                                      ],
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  margin: const EdgeInsets.all(20.0),
                                  child: Container(
                                      margin: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                rule.toString(),
                                                style: TextStyle(
                                                    fontSize: 45,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('Med-Rules'.tr,
                                                  style:
                                                      TextStyle(fontSize: 20))
                                            ],
                                          ),
                                          Container(
                                            width: 100,
                                            height: 100,
                                            child: Image.asset(
                                                'images/dashboard/blanket-regular-24.png'),
                                          ),
                                        ],
                                      )),
                                )),
                            InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Colors.yellow, Colors.indigo],
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  margin: const EdgeInsets.all(20.0),
                                  child: Container(
                                      margin: const EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                record.toString(),
                                                style: TextStyle(
                                                    fontSize: 45,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text('Med-Records'.tr,
                                                  style:
                                                      TextStyle(fontSize: 20))
                                            ],
                                          ),
                                          Container(
                                            width: 100,
                                            height: 100,
                                            child: Image.asset(
                                                'images/dashboard/bookmark-alt-plus-regular-24.png'),
                                          ),
                                        ],
                                      )),
                                )),
                          ],
                        ),
                      ));
                    } else {
                      return Center(child: const CircularProgressIndicator());
                    }
                  });
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          }),
    );
  }
}

class noti {
  String? type;
  Message? message;

  noti({this.type, this.message});

  noti.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  String? warningType;
  String? message;
  String? event;
  List<String>? data;

  Message({this.warningType, this.message, this.event, this.data});

  Message.fromJson(Map<String, dynamic> json) {
    warningType = json['warningType'];
    message = json['message'];
    event = json['event'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warningType'] = this.warningType;
    data['message'] = this.message;
    data['event'] = this.event;
    data['data'] = this.data;
    return data;
  }
}
