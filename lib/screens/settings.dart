import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoclub/models/Member.dart';
import 'package:memoclub/models/socialMedia.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/screens/register.dart';
import 'package:memoclub/screens/reset.dart';
import 'package:memoclub/screens/sign_in.dart';
import 'package:memoclub/screens/styles/buttons.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/screens/welcome.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/services/database.dart';
import 'package:memoclub/shared/appbar.dart';
import 'package:memoclub/shared/drawer.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  static final String routeName = 'settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  String _urlToLink = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    AuthService _auth = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: memoAppBar(context, "Settings"),
      body: Center(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),
                MaterialButton(
                    elevation: buttonThemeElevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(buttonBorderRadius),
                    ),
                    child: Text('Change Password',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: kOnButtonColor)),
                    color: kButtonColor,
                    onPressed: () async {
                      Navigator.pushNamed(context, ResetScreen.routeName);
                    }),
                SizedBox(height: 15.0),
                MaterialButton(
                    elevation: buttonThemeElevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(buttonBorderRadius),
                    ),
                    child: Text('Change Username',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: kOnButtonColor)),
                    color: kButtonColor,
                    onPressed: () async {
                      Navigator.pushNamed(context, SignIn.routeName);
                    }),
                SizedBox(height: 15.0),
                //**\\\
                //**This Form is for the User to insert their Social Media URL
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: TextFormField(
                          onChanged: (input) => _urlToLink = input,
                          style: TextStyle(color: Colors.black),

                          decoration: const InputDecoration(
                            hintText: 'Enter Social Media URL',
                            enabledBorder: OutlineInputBorder(),
                          ),
                          //This is check if input is valid
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'URL is empty.';
                            }

                            bool test1 =
                                value.toLowerCase().contains("facebook");
                            bool test2 =
                                value.toLowerCase().contains("instagram");
                            // print("test1 is $test1 and test2 is $test2");
                            if (test1 || test2) {
                              return null;
                            } else {
                              return "URL must be facebook or instagram";
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              primary: Colors.deepPurple[600]),
                          child: const Text('Submit'),
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Process Data

                              User? currUser = await Provider.of<AuthService>(
                                      context,
                                      listen: false)
                                  .getUser();
                              String key = _urlToLink;
                              print(
                                  "currUser is = $currUser, sending to database...");
                              print(
                                  "userinput is = $key, sending to database...");

                              DatabaseService db = DatabaseService();
                              if (key.toLowerCase().contains('facebook')) {
                                await db.updateFacebookProfile(currUser, key);
                              } else {
                                await db.updateInstagramProfile(currUser, key);
                              }

                              // db.updateFacebookProfile(currUser, key);
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(content: Text('Processing Data')));
                            } else {
                              setState(() {
                                error =
                                    "URL must contain facebook or instagram";
                              });
                            }
                          },
                        ),
                      ),
                      // Text(
                      //   error,
                      //   style: TextStyle(color: Colors.red, fontSize: 14.0),
                      // ),
                    ],
                  ),
                ),
                MaterialButton(
                    onPressed: () async {
                      bool didSignOut = await _auth.signOut();
                      if (didSignOut) {
                        // this navigator command pops all history from the navigator,
                        // and then sends them to home screen. This prevent them from
                        // signing out, then pressing back on native button to re-enter the app
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Welcome.routeName, (Route<dynamic> route) => false);
                      }
                    },
                    elevation: buttonThemeElevation,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text('Sign Out',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: kOnButtonColor)),
                    color: kButtonColor),
              ],
            )),
      ),
    );
  }

//this method isn't used
  form() {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          //Input for Social Media URL
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter in your Social Media URL',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter in a URL';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Process Data

                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
