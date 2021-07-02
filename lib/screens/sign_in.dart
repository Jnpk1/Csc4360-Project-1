import 'package:flutter/material.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/screens/register.dart';
import 'package:memoclub/screens/styles/buttons.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/services/database.dart';
import 'package:memoclub/shared/inputDecor.dart';
import 'package:memoclub/shared/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static final String routeName = '/sign_in';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingCircle()
        : Scaffold(
            backgroundColor: kBackgroundColor,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                backgroundColor: kPrimaryColor,
                elevation: 0.0,
                title: Text(
                  'Sign In Here',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: kOnPrimaryColor),
                ),
                actions: <Widget>[
                  TextButton.icon(
                    icon: Icon(
                      Icons.person,
                      color: kOnPrimaryColor,
                    ),
                    label: Text(
                      'Register',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: kOnPrimaryColor),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Register.routeName);
                    },
                  )
                ]),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
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
                              setState(() => email = val);
                            }),
                        SizedBox(height: 15.0),
                        TextFormField(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: kTextColor),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            obscureText: true,
                            validator: (val) => val!.length < 6
                                ? 'Incorrect email or password'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            }),
                        SizedBox(height: 15.0),
                        MaterialButton(
                            elevation: buttonThemeElevation,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(buttonBorderRadius),
                            ),
                            child: Text('Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(color: kOnButtonColor)),
                            color: kButtonColor,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                Navigator.pushNamed(context, Home.routeName);
                                if (result == null) {
                                  setState(() => error = 'INVALID CREDENTIALS');
                                }
                              }
                            }),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ))),
          );
  }
}
