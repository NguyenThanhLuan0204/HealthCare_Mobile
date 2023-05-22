import 'package:fit/Screen/Login/constants.dart';
import 'package:flutter/material.dart';
import '../../Login/login_screen.dart';
import '../../Signup/signup_screen.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, elevation: 10,
            padding: EdgeInsets.fromLTRB(100,30,100,30),
            shape: StadiumBorder(),
          ),
          child: Text(
              "Sign In".toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, elevation: 10,
            padding: EdgeInsets.fromLTRB(100,30,100,30),
            shape: StadiumBorder(),
          ),
          child: Text(
            "Sign Up".toUpperCase(), style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
