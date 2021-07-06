import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoclub/screens/reset.dart';
import 'package:memoclub/screens/sign_in.dart';
import 'package:memoclub/screens/styles/buttons.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/screens/welcome.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/services/database.dart';
import 'package:memoclub/shared/appbar.dart';
import 'package:memoclub/shared/drawer.dart';
import 'package:memoclub/shared/inputDecor.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static final String routeName = '/settings';
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _urlToLink = '';
  String error = '';
  String successMessage = '';
  @override
  Widget build(BuildContext context) {
    AuthService _auth = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: memoAppBar(context, "Settings"),
      drawer: memoDrawer(context),
      body: Center(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
            child: Column(
              children: <Widget>[
                Flexible(child: SizedBox(height: 15.0)),

                Text(
                  "Connect a Facebook or Instagram Webpage",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: kPrimaryColor),
                ),

                //**This Form is for the User to insert their Social Media URL
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 50.0),
                        child: TextFormField(
                          onChanged: (input) => _urlToLink = input,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: Colors.black),
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Enter Social Media URL'),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'URL is empty.';
                            }
                            RegExp validURL = RegExp(
                                r".*(facebook|fb|instagram)\.[a-z]+(\/[a-zA-Z0-9#]+\/?)*$");

                            if (!validURL.hasMatch(value.toLowerCase())) {
                              setState(() => successMessage = '');
                              return "URL must be facebook or instagram";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: MaterialButton(
                          elevation: buttonThemeElevation,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(buttonBorderRadius),
                          ),
                          child: Text('Submit',
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(color: kOnButtonColor)),
                          color: kButtonColor,
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Process Data
                              String _originalUrl = _urlToLink;
                              _urlToLink = _urlToLink.toLowerCase();

                              User? currUser = await Provider.of<AuthService>(
                                      context,
                                      listen: false)
                                  .getUser();
                              String key = _urlToLink;
                              print(
                                  "currUser is = $currUser, sending to database...");

                              DatabaseService db = DatabaseService();
                              int idx = _urlToLink
                                  .indexOf(RegExp(r"(fb\.|facebook\.)"));

                              if (idx >= 0) {
                                // contains facebook
                                String _formattedLink = "https://" +
                                    _originalUrl.substring(
                                        idx, _urlToLink.length);
                                await db.updateFacebookProfile(
                                    currUser, _formattedLink);
                                setState(() {
                                  successMessage =
                                      "Successfully connected Facebook";
                                });
                              } else if (_urlToLink.contains("instagram\.")) {
                                // contains instagram
                                String _formattedLink = "https://" +
                                    _originalUrl.substring(
                                        _urlToLink
                                            .indexOf(RegExp(r"instagram")),
                                        _urlToLink.length);
                                await db.updateInstagramProfile(
                                    currUser, _formattedLink);
                                setState(() {
                                  successMessage =
                                      "Successfully connected Instagram";
                                });
                              } else {
                                // Should NEVER happen
                                print(
                                    "ERROR, url passed validation but did not contain facebook or instagram.");
                                setState(() {
                                  error =
                                      "URL must contain facebook or instagram";
                                });
                              }
                            }
                          },
                        ),
                      ),
                      Text(
                        successMessage,
                        style: TextStyle(color: Colors.green, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
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
                Flexible(child: SizedBox(height: 15.0)),
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
}
