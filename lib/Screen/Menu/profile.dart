import 'package:fit/Screen/HomePage.dart';
import 'package:fit/Screen/Login/Screens/Welcome/welcome_screen.dart';
import 'package:fit/appLanguage/language_button.dart';
import 'package:fit/darkmode/dart_mode_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String value = "7500";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FutureBuilder<String>(
                    future: getDisplayName(),
                    builder: (context,snapshot) {
                      return Text(
                        snapshot.data.toString(),
                        style: kTitleTextStyle,
                      );
                    }
                ),
                const SizedBox(width: 20,),
                const CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage('images/fitimage.png'),
                )
              ],
            ),
          ),
          const Mode_Dark_Button(),
          LanguageButton(),
        GestureDetector(
          onTap: () => {
          const FlutterSecureStorage().deleteAll(),
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return WelcomeScreen();
            },
          ),
        ),
          },
          // onTap: () => showLocaleDialog(context),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: 48,
                width: 374,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor,
                        // spreadRadius: 10,
                        blurRadius: 3,
                        offset: const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    'Log Out'.tr,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const Positioned.fill(
                left: 20,
                child: Align(
                  child: Icon(
                    Icons.exit_to_app,
                    color: Colors.green,
                  ),
                  // child: ChangeThemeButtonWidget(),
                  alignment: Alignment.centerLeft,
                ),
              )
            ],
          ),
        ),
          // Container(
          //   padding: EdgeInsets.only(bottom: 10),
          //   alignment: Alignment.bottomCenter,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       const FlutterSecureStorage().deleteAll();
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return WelcomeScreen();
          //           },
          //         ),
          //       );
          //     },
          //     style: ElevatedButton.styleFrom(
          //
          //         backgroundColor: Colors.green,
          //         textStyle: TextStyle(
          //             fontWeight: FontWeight.bold),
          //     ),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Icon(Icons.exit_to_app),
          //         SizedBox(width: 20.0),
          //         Text("Log Out".tr),
          //       ],
          //     ),
          //   ),
          // )

        ]),
      ),

    );
  }
}

class FloatingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint yellowcolor = Paint()
      ..color = Colors.amber
      ..strokeWidth = 5;
    Paint greencolor = Paint()
      ..color = Colors.green
      ..strokeWidth = 5;
    Paint redcolor = Paint()
      ..color = Colors.red
      ..strokeWidth = 5;
    Paint bluecolor = Paint()
      ..color = Colors.green
      ..strokeWidth = 5;

    canvas.drawLine(Offset(size.width * 0.27, size.height * 0.5),
        Offset(size.width * 0.5, size.height * 0.5), yellowcolor);

    canvas.drawLine(
        Offset(size.width * 0.5, size.height * 0.5),
        Offset(size.width * 0.5, size.height - (size.height * 0.27)),
        greencolor);

    canvas.drawLine(
        Offset(size.width * 0.5, size.height * 0.5),
        Offset(size.width-(size.width * 0.27), size.height*0.5),
        bluecolor);

    canvas.drawLine(
        Offset(size.width * 0.5, size.height * 0.5),
        Offset(size.width*0.5, size.height*0.27),
        redcolor);


  }

  @override
  bool shouldRepaint(FloatingPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(FloatingPainter oldDelegate) => false;
}