import 'package:flutter/material.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/screens/register.dart';
import 'package:memoclub/screens/sign_in.dart';
import 'package:memoclub/screens/styles/buttons.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/shared/appbar.dart';
import 'package:memoclub/shared/inputDecor.dart';

class Welcome extends StatelessWidget {
  final AuthService _auth = AuthService();
  static final String routeName = '/welcome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: memoAppBar(context, "Welcome"),
      body: Center(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/mc.png',
                ),

                // // ),
                SizedBox(height: 15.0),
                MaterialButton(
                    elevation: buttonThemeElevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(buttonBorderRadius),
                    ),
                    child: Text('Register',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: kOnButtonColor)),
                    color: kButtonColor,
                    onPressed: () async {
                      Navigator.pushNamed(context, Register.routeName);
                    }),
                SizedBox(height: 15.0),
                MaterialButton(
                    elevation: buttonThemeElevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(buttonBorderRadius),
                    ),
                    child: Text('Sign In',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: kOnButtonColor)),
                    color: kButtonColor,
                    onPressed: () async {
                      Navigator.pushNamed(context, SignIn.routeName);
                    }),
                SizedBox(height: 15.0),
              ],
            )),
      ),
    );
  }
}
