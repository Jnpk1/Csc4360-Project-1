import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/screens/register.dart';
import 'package:memoclub/screens/styles/buttons.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/services/database.dart';
import 'package:memoclub/shared/inputDecor.dart';
import 'package:memoclub/shared/appbar.dart';
import 'package:memoclub/shared/loading.dart';
import 'package:auth_buttons/auth_buttons.dart';

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
  bool loading = false;

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

            //Beginning of the form
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
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
                                setState(() => _isLoading = true);
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);

                                if (result == null) {
                                  setState(() {
                                    error = 'INVALID CREDENTIALS';
                                    _isLoading = false;
                                  });
                                } else {
                                  

                                  setState(() {
                                    _isLoading = true;
                                  });
                                  setState(() => _isLoading = false);
                                  Navigator.pushNamed(context, Home.routeName);
                                }
                              }
                            }),

                        //Button to take you to home page.
                        //Delete me before sending in for grade.
                        ElevatedButton.icon(
                          onPressed: () =>
                              Navigator.pushNamed(context, Home.routeName),
                          icon: Icon(Icons.house),
                          label: Text('Take Me To Home Page'),
                        ),

                        //Google sign in button
                        (GoogleAuthButton(onPressed: () async {
                          setState(() => loading = true);

                          dynamic result = await _auth.signInWithGoogle();
                          //error checking
                          if (result == null) {
                            print('Error. Gooogle sign in resulted in null.');
                            setState(() => loading = false);
                          } else {
                            print('Google sign in returned: $result');
                          }
                        })),
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
//previous work
/*
ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, Home.routeName),
        icon: Icon(Icons.business_center),
        label: Text('Business ChatRoom'),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Theme.of(context).colorScheme.primary;
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            )))),
    ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, Home.routeName),
        icon: Icon(Icons.sports_esports_outlined),
        label: Text('Games ChatRoom'),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Theme.of(context).colorScheme.primary;
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            )))),
    ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, Home.routeName),
        icon: Icon(Icons.health_and_safety_outlined),
        label: Text('Public Health ChatRoom'),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Theme.of(context).colorScheme.primary;
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            )))),
    ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, Home.routeName),
        icon: Icon(Icons.book),
        label: Text('Study ChatRoom'),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Theme.of(context).colorScheme.primary;
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            )))),*/