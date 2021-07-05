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
    Member newestMember = Provider.of<Member>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: memoAppBar(context, "Home"),
      appBar: memoAppBar(context, "Home"),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: home_content(context),
      ),
      drawer: memoDrawer(context),
    );
  }
}

Future printUser(BuildContext context) async {
  User? curr = await Provider.of<AuthService>(context, listen: false).getUser();
  print("In home.dart, currUser=$curr");
}

// Widget testFunctionToGetCurrentUser(BuildContext context) {
//   return MaterialButton(
//       onPressed: () => printUser(context),
//       elevation: buttonThemeElevation,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(buttonBorderRadius),
//       ),
//       child: Text('Press to getUser()',
//           style: Theme.of(context)
//               .textTheme
//               .button
//               ?.copyWith(color: kOnButtonColor)),
//       color: kButtonColor);
// }

//HEALTH_ROOM_ROUTE_NAME
Widget roomButtons(BuildContext context) {
  // final String HEALTH_ROOM_ROUTE_NAME = HealthRoom.routeName;
  AuthService _auth = Provider.of<AuthService>(context, listen: false);
  print(Navigator.of(context).toString());

  RoundedRectangleBorder side;
  return Column(children: <Widget>[
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
    // testFunctionToGetCurrentUser(context),
  ]);
}

Widget home_content(BuildContext context) {
  final String HEALTH_ROOM_ROUTE_NAME = HealthRoom.routeName;
  AuthService _auth = Provider.of<AuthService>(context, listen: false);
  print(Navigator.of(context).toString());
  var child;
  return Container(
    padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
    child: ListView(children: <Widget>[
      Card(
          child: ListTile(
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
        subtitle: Text(''),
        trailing: Icon(Icons.more_vert),
        //isThreeLine: true,
      )),
      Card(
        child: ListTile(
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
          subtitle: Text(''),
          trailing: Icon(Icons.more_vert),
          // isThreeLine: true,
        ),
      ),
      Card(
          child: ListTile(
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
        subtitle: Text(''),
        trailing: Icon(Icons.more_vert),
        //  isThreeLine: true,
      )),
      Card(
          child: ListTile(
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
        subtitle: Text(''),
        trailing: Icon(Icons.more_vert),
        // isThreeLine: true,
      )),
      Card(
        child: roomButtons(context),
      ),

      // Google Button
    ]),
  );
}
