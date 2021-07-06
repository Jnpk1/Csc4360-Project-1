import 'package:flutter/material.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/screens/sign_in.dart';
import 'package:memoclub/screens/styles/buttons.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/services/database.dart';
import 'package:memoclub/shared/inputDecor.dart';
import 'package:memoclub/shared/loading.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static final String routeName = '/register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  String firstName = '';
  String lastName = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthService _auth = Provider.of<AuthService>(context);
    return _isLoading
        ? LoadingCircle()
        : Scaffold(
            backgroundColor: kBackgroundColor,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                backgroundColor: kPrimaryColor,
                elevation: 0.0,
                title: Text(
                  'Register Here',
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
                      'Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: kOnPrimaryColor),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, SignIn.routeName);
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
                                val!.isEmpty ? 'Enter an email' : null,
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
                                ? 'Enter a password 6+ chars long'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            }),
                        SizedBox(height: 15.0),
                        TextFormField(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: kTextColor),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'First Name'),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter your First Name' : null,
                            onChanged: (val) {
                              setState(() => firstName = val);
                            }),
                        SizedBox(height: 15.0),
                        TextFormField(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: kTextColor),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Last Name'),
                            validator: (val) =>
                                val!.isEmpty ? 'Enter your Last Name' : null,
                            onChanged: (val) {
                              setState(() => lastName = val);
                            }),
                        SizedBox(height: 15.0),
                        MaterialButton(
                            elevation: buttonThemeElevation,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(buttonBorderRadius),
                            ),
                            child: Text('Register',
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(color: kOnButtonColor)),
                            color: kButtonColor,
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                var dateRegistered = DateTime.now();

                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email,
                                        password,
                                        firstName,
                                        lastName,
                                        dateRegistered);

                                if (result == null) {
                                  setState(() {
                                    _isLoading = false;
                                    error = ('please input a valid email');
                                  });
                                } else {
                                  await DatabaseService()
                                      .createUserInDatabaseFromEmail(
                                          result,
                                          email,
                                          password,
                                          firstName,
                                          lastName,
                                          dateRegistered,
                                          firstName + '-' + lastName);
                                  await _auth.createUsernameDuringRegistration(
                                      result, firstName, lastName);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.pushNamed(context, Home.routeName);
                                }
                              } else {
                                setState(() => _isLoading = false);
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
