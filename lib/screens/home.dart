import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoclub/models/Member.dart';
import 'package:memoclub/models/MessageCard.dart';
import 'package:memoclub/screens/boards/business_room.dart';
import 'package:memoclub/screens/boards/games_room.dart';
import 'package:memoclub/screens/boards/health_room.dart';
import 'package:memoclub/screens/boards/study_room.dart';
import 'package:memoclub/screens/register.dart';
import 'package:memoclub/screens/sign_in.dart';
import 'package:memoclub/screens/styles/buttons.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/screens/welcome.dart';
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
  @override
  Widget build(BuildContext context) {
    Member newestMember = Provider.of<Member>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: memoAppBar(context, "Home"),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: home_content(context),
      ),
      drawer: memoDrawer(context),
    );
  }
}

Widget roomButtons(BuildContext context) {
  AuthService _auth = Provider.of<AuthService>(context, listen: false);

  return Column(children: <Widget>[
    MaterialButton(
        onPressed: () async {
          bool didSignOut = await _auth.signOut();
          if (didSignOut) {
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
  ]);
}

Widget home_content(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
    child: ListView(children: <Widget>[
      Card(
          child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        leading: Icon(
          Icons.business_center,
          size: 56.0,
          color: Colors.white,
        ),
        tileColor: kPrimaryColor,
        title: Text(
          'Business \nChatRoom',
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          Navigator.pushNamed(context, BusinessRoom.routeName);
        },
      )),
      Card(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          leading: Icon(
            Icons.sports_esports_outlined,
            size: 56.0,
            color: Colors.white,
          ),
          tileColor: kPrimaryColor,
          title: Text(
            'Games \nChatRoom',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pushNamed(context, GamesRoom.routeName);
          },
        ),
      ),
      Card(
          child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        leading: Icon(
          Icons.health_and_safety_outlined,
          size: 56.0,
          color: Colors.white,
        ),
        tileColor: kPrimaryColor,
        title: Text(
          'Health \nChatRoom',
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          Navigator.pushNamed(context, HealthRoom.routeName);
        },
      )),
      Card(
          child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        leading: Icon(
          Icons.book,
          size: 56.0,
          color: Colors.white,
        ),
        tileColor: kPrimaryColor,
        title: Text(
          'Study \nChatRoom',
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          Navigator.pushNamed(context, StudyRoom.routeName);
        },
      )),
      SizedBox(
        height: 80,
      ),
      roomButtons(context),
    ]),
  );
}
