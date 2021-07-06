import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memoclub/models/Member.dart';
import 'package:memoclub/screens/profile.dart';
import 'package:memoclub/screens/sign_in.dart';
import 'package:memoclub/screens/styles/buttons.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/services/database.dart';
import 'package:memoclub/shared/appbar.dart';
import 'package:memoclub/shared/inputDecor.dart';
import 'package:memoclub/shared/loading.dart';
import 'package:provider/provider.dart';

class ResetUsernameScreen extends StatefulWidget {
  const ResetUsernameScreen({Key? key}) : super(key: key);
  static final String routeName = '/reset_username';
  @override
  _ResetUsernameScreenState createState() => _ResetUsernameScreenState();
}

class _ResetUsernameScreenState extends State<ResetUsernameScreen> {
  String _username = '';
  final auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String error = '';
  DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    AuthService _auth = Provider.of<AuthService>(context);

    Member currMember = Provider.of<Member>(context);
    return _isLoading
        ? LoadingCircle()
        : Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: memoAppBar(context, "Update Username"),
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
                          textInputDecoration.copyWith(hintText: 'Username'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a username' : null,
                      onChanged: (val) {
                        setState(() => _username = val);
                      }),
                  SizedBox(height: 15.0),
                  MaterialButton(
                      elevation: buttonThemeElevation,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(buttonBorderRadius),
                      ),
                      child: Text('Update Username',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: kOnButtonColor)),
                      color: kButtonColor,
                      onPressed: () async {
                        await _db.updateUsername(currMember.id, _username);
                        Navigator.pushNamed(context, Profile.routeName);
                      }),
                ]))));
  }
}
