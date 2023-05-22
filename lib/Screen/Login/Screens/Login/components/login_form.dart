import 'package:fit/Controller/SignIn&SignUp/SignIn.dart';
import 'package:fit/Screen/HomePage.dart';
import 'package:fit/Screen/Login/Screens/welcomeApp.dart';
import 'package:fit/Screen/subscreen/showsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: username,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            //cursorColor: Colors.white,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: password,
              textInputAction: TextInputAction.done,
              obscureText: true,
              // cursorColor: Colors.white,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () async {
                // if (password.text.toString() == '12345678') {
                //   await FlutterSecureStorage()
                //       .write(key: "isAdmin", value: username.text.toString());
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => WelcomeApp(
                //           password: password.text.toString(),
                //           username: username.text.toString(),
                //         )),
                //   );
                // }
                //bool isSignIn = await SignIn(username.text.toString(), password.text.toString());
                 if(username.text.toString().isNotEmpty&&password.text.toString().isNotEmpty)
                 {
                   // Navigator.push(
                   //   context,
                   //   MaterialPageRoute(builder: (context) => HomePage()),
                   // );
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => WelcomeApp(username:username.text.toString(), password:password.text.toString())),
                   );
                 }
                else {
                  print(password.text.toString());
                  Alert(
                          context: context,
                          title: "Incorrect",
                          desc: "username or password is not empty !")
                      .show();
                }
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
