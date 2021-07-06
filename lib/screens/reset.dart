import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memoclub/screens/sign_in.dart';
import 'package:memoclub/screens/styles/buttons.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/shared/appbar.dart';
import 'package:memoclub/shared/inputDecor.dart';
import 'package:memoclub/shared/loading.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);
  static final String routeName = '/reset';
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late String _email;
  final auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingCircle()
        : Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: memoAppBar(context, "Reset Password"),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    child: Column(children: <Widget>[
                  SizedBox(height: 15.0),
                  TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: kTextColor),
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter your email' : null,
                      onChanged: (val) {
                        setState(() => _email = val);
                      }),
                  SizedBox(height: 15.0),
                  MaterialButton(
                      elevation: buttonThemeElevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(buttonBorderRadius),
                      ),
                      child: Text('Send Reset Request',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: kOnButtonColor)),
                      color: kButtonColor,
                      onPressed: () async {
                        auth.sendPasswordResetEmail(email: _email);
                        Navigator.pushNamed(context, SignIn.routeName);
                      }),
                ]))));
  }
}
