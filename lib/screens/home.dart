import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoclub/models/MessageCard.dart';
import 'package:memoclub/screens/register.dart';
import 'package:memoclub/screens/sign_in.dart';
import 'package:memoclub/screens/styles/buttons.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/screens/welcome.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/services/database.dart';
import 'package:memoclub/shared/appbar.dart';
import 'package:memoclub/shared/drawer.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  static final String routeName = '/home';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  int _counter = 0;

  void _sendToRegisterPage() {
    Navigator.pushNamed(context, Register.routeName);
  }

  Future printUser() async {
    User? curr =
        await Provider.of<AuthService>(context, listen: false).getUser();
    print("In home.dart, currUser=$curr");
  }

  @override
  Widget build(BuildContext context) {
    // printUser();
    return Scaffold(
      appBar: memoAppBar(context, "Home"),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: roomButtons(context),
      ),
      drawer: memoDrawer(context),
    );
  }
}

Future printUser(BuildContext context) async {
  User? curr = await Provider.of<AuthService>(context, listen: false).getUser();
  print("In home.dart, currUser=$curr");
}

Widget testFunctionToGetCurrentUser(BuildContext context) {
  return MaterialButton(
      onPressed: () => printUser(context),
      elevation: buttonThemeElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonBorderRadius),
      ),
      child: Text('Press to getUser()',
          style: Theme.of(context)
              .textTheme
              .button
              ?.copyWith(color: kOnButtonColor)),
      color: kButtonColor);
}

Widget roomButtons(BuildContext context) {
  final String HEALTH_ROOM_ROUTE_NAME = SignIn.routeName;
  AuthService _auth = Provider.of<AuthService>(context, listen: false);
  print(Navigator.of(context).toString());

  return Column(children: <Widget>[
    MaterialButton(
        onPressed: () => Navigator.pushNamed(context, HEALTH_ROOM_ROUTE_NAME),
        elevation: buttonThemeElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
        child: Text('Health Room',
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: kOnButtonColor)),
        color: kButtonColor),
    MaterialButton(
        onPressed: () => Navigator.pushNamed(context, HEALTH_ROOM_ROUTE_NAME),
        elevation: buttonThemeElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
        child: Text('Study Room',
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: kOnButtonColor)),
        color: kButtonColor),
    MaterialButton(
        onPressed: () => Navigator.pushNamed(context, HEALTH_ROOM_ROUTE_NAME),
        elevation: buttonThemeElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
        child: Text('Business Board',
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: kOnButtonColor)),
        color: kButtonColor),
    MaterialButton(
        onPressed: () => Navigator.pushNamed(context, Register.routeName),
        elevation: buttonThemeElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
        child: Text('Register Page',
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: kOnButtonColor)),
        color: kButtonColor),
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
    MaterialButton(
        onPressed: () async {
          MessageCard mc = MessageCard(
              author: "nate",
              content: "filler content",
              date: DateTime.now(),
              room: "healthRoom");
          DatabaseService db = DatabaseService();
          await db.createMessageInDatabase(mc);
          print("Added $mc to Firestore.");
        },
        elevation: buttonThemeElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text('Create Dummy Message Health Room',
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: kOnButtonColor)),
        color: kButtonColor),
    MaterialButton(
        onPressed: () async {
          MessageCard mc = MessageCard(
              author: "nate",
              content: "filler content",
              date: DateTime.now(),
              room: "studyRoom");
          DatabaseService db = DatabaseService();
          await db.createMessageInDatabase(mc);
          print("Added $mc to Firestore.");
        },
        elevation: buttonThemeElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text('Create Dummy Message Study Room',
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: kOnButtonColor)),
        color: kButtonColor),
    MaterialButton(
        onPressed: () async {
          MessageCard mc = MessageCard(
              author: "nate",
              content: "filler content",
              date: DateTime.now(),
              room: "businessRoom");
          DatabaseService db = DatabaseService();
          await db.createMessageInDatabase(mc);
          print("Added $mc to Firestore.");
        },
        elevation: buttonThemeElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text('Create Dummy Message Business Room',
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: kOnButtonColor)),
        color: kButtonColor),
    MaterialButton(
        onPressed: () async {
          MessageCard mc = MessageCard(
              author: "nate",
              content: "filler content",
              date: DateTime.now(),
              room: "gamesRoom");
          DatabaseService db = DatabaseService();
          await db.createMessageInDatabase(mc);
          print("Added $mc to Firestore.");
        },
        elevation: buttonThemeElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text('Create Dummy Message Games Room',
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: kOnButtonColor)),
        color: kButtonColor),
    testFunctionToGetCurrentUser(context),
  ]);
}
