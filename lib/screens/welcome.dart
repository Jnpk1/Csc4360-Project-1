import 'package:flutter/material.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/screens/register.dart';
import 'package:memoclub/screens/sign_in.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/shared/appbar.dart';
import 'package:memoclub/shared/inputDecor.dart';

class Welcome extends StatelessWidget {
  final AuthService _auth = AuthService();
  static final String routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: memoAppBar("Welcome"),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 160.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.0),
              ElevatedButton(
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, Register.routeName);
                  }),
              SizedBox(height: 15.0),
              ElevatedButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, SignIn.routeName);
                  }),
              SizedBox(height: 15.0),
            ],
          )),
    );
  }
}
