import 'package:fit/Controller/SignIn&SignUp/SignIn.dart';
import 'package:fit/Controller/SignIn&SignUp/SignUp.dart';
import 'package:fit/Screen/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController displayname = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmpassword = TextEditingController();
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            //cursorColor: Colors.white,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your username",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: displayname,
              textInputAction: TextInputAction.next,
              obscureText: false,
              decoration: InputDecoration(
                hintText: "Display Name",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
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
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: confirmpassword,
              textInputAction: TextInputAction.done,
              obscureText: true,
              // cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Confirm password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () async {
              bool isSignIn = await SignUp(email.text, displayname.text,password.text, confirmpassword.text);
              if(isSignIn){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }else{
                Alert(
                    context: context,
                    title: "Failed Login",
                    desc: "Incorrect Email Or Password.")
                    .show();
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
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