import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoclub/screens/register.dart';
import 'package:memoclub/screens/sign_in.dart';
import 'package:memoclub/services/auth.dart';
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
      appBar: memoAppBar("Home"),
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
  return ElevatedButton(
      onPressed: () => printUser(context), child: Text('Press to getUser()'));
}

Widget roomButtons(BuildContext context) {
  final String HEALTH_ROOM_ROUTE_NAME = SignIn.routeName;
  AuthService _auth = Provider.of<AuthService>(context, listen: false);
  print(Navigator.of(context).toString());

  return Column(children: <Widget>[
    ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, HEALTH_ROOM_ROUTE_NAME),
        child: Text('health_board')),
    ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, HEALTH_ROOM_ROUTE_NAME),
        child: Text('study_board')),
    ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, HEALTH_ROOM_ROUTE_NAME),
        child: Text('business_board')),
    ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, Register.routeName),
        child: Text('register_page')),
    ElevatedButton(
        onPressed: () async {
          bool didSignOut = await _auth.signOut();
          if (didSignOut) {
            // this navigator command pops all history from the navigator,
            // and then sends them to home screen. This prevent them from
            // signing out, then pressing back on native button to re-enter the app
            Navigator.of(context).pushNamedAndRemoveUntil(
                Register.routeName, (Route<dynamic> route) => false);
          }
        },
        child: Text('sign out')),
    testFunctionToGetCurrentUser(context),
  ]);
}
