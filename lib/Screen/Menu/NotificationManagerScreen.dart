import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  List<RemoteMessage> notifications = [];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        setState(() {
          notifications.add(message);
        });
      }
    });
    FirebaseMessaging.onMessage.listen((message) {
      setState(() {
        notifications.add(message);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message.notification!.title!),
          action: SnackBarAction(
            label: 'View',
            onPressed: () {
              // Navigate to notification details page
            },
          ),
        ),
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationDetailsPage(message: message),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.green,
        title: Text('Notifications Realtime'.tr),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(notifications[index].notification!.title!),
            subtitle: Text(notifications[index].notification!.body!),
            onTap: () {
              // Navigate to notification details page
            },
          );
        },
      ),
    );
  }
}

class NotificationDetailsPage extends StatelessWidget {
  final RemoteMessage message;

  const NotificationDetailsPage({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Details'),
      ),
      body: Center(
        child: Text(message.notification!.body!),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
//
// class NotificationsPage extends StatefulWidget {
//   const NotificationsPage({
//     super.key,
//   });
//
//
//   @override
//   State<NotificationsPage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<NotificationsPage> {
//   final TextEditingController _controller = TextEditingController();
//   final _channel = WebSocketChannel.connect(
//     Uri.parse('ws://localhost:5000'),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Form(
//               child: TextFormField(
//                 controller: _controller,
//                 decoration: const InputDecoration(labelText: 'Send a message'),
//               ),
//             ),
//             const SizedBox(height: 24),
//             StreamBuilder(
//               stream: _channel.stream,
//               builder: (context, snapshot) {
//                 return Text(snapshot.hasData ? '${snapshot.data}' : '');
//               },
//             )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _sendMessage,
//         tooltip: 'Send message',
//         child: const Icon(Icons.send),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       _channel.sink.add(_controller.text);
//     }
//   }
//
//   @override
//   void dispose() {
//     _channel.sink.close();
//     _controller.dispose();
//     super.dispose();
//   }
// }