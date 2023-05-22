import 'package:fit/Controller/SignIn&SignUp/SignIn.dart';
import 'package:fit/Screen/HomePage.dart';
import 'package:fit/Screen/Login/Screens/Login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class WelcomeApp extends StatefulWidget {
  final String username;
  final String password;
  const WelcomeApp({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  State<WelcomeApp> createState() => _WelcomeAppState();
}

class _WelcomeAppState extends State<WelcomeApp> {
  bool shutdownlogin=true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: SignIn(widget.username, widget.password),
        builder: (context, snapshot) {
          if (shutdownlogin) {
          // if (snapshot.hasData) {
            if (shutdownlogin != false) {
            //if (snapshot.data != false) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor:Colors.green,
                  title: Text("Thông báo"),
                ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    const Text(
                      "Đăng nhập thành công",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: const Text("Đi đến Trang Home"))
                ],
              ),
                  ));
            } else {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor:Colors.green,
                  title: Text("Thông báo"),
                ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    const Text(
                      "Đăng nhập thất bại,\nvui lòng kiểm tra lại Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text("Quay lại trang LoginPage"))
                ],
              ),
                  ));
            }
          } else {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor:Colors.green,
                  title: Text("Đang đăng nhập ...."),
                ),
                body: const Center(child: CircularProgressIndicator()));
          }
        });
  }
}
