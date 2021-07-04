import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memoclub/screens/boards/business_room.dart';
import 'package:memoclub/screens/boards/games_room.dart';
import 'package:memoclub/screens/boards/health_room.dart';
import 'package:memoclub/screens/boards/study_room.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/screens/profile.dart';
import 'package:memoclub/screens/register.dart';
import 'package:memoclub/screens/settings.dart';
import 'package:memoclub/screens/sign_in.dart';
import 'package:memoclub/screens/styles/theme.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/services/database.dart';
import 'package:memoclub/services/member_bloc.dart';
import 'package:memoclub/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:memoclub/screens/welcome.dart';

import 'models/Member.dart';

void main() {
  // This needs to be called before any Firebase services can be used
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppToInitializeFirebase());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [AppToInitializeFirebase] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class AppToInitializeFirebase extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppToInitializeFirebaseState createState() =>
      _AppToInitializeFirebaseState();
}

class _AppToInitializeFirebaseState extends State<AppToInitializeFirebase> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // return SomethingWentWrong();
          return Text(
              "Error ocurred in main.dart when calling Firebase.initializeApp()");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return changeNotifier();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return LoadingCircle();
      },
    );
  }
}

Widget changeNotifier() {
  return ChangeNotifierProvider<AuthService>(
    create: (_) => new AuthService(),
    child: MyApp(), //MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<AuthService>(context, listen: false).firstLogin(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              print("error");
              return Text(snapshot.error.toString());
            }
            print("main.dart: snaphshot.data=${snapshot.data}");
            // return snapshot.hasData ? materialApp() : Register();
            return materialApp(context, snapshot.data, snapshot.hasData);
          } else {
            return LoadingCircle();
          }
        });
  }
}

Widget materialApp(BuildContext context, User? currUser, bool hasData) {
  AuthService _auth = Provider.of<AuthService>(context, listen: false);
  // DatabaseService db = DatabaseService();
  return MultiProvider(
    providers: [
      StreamProvider<Member>.value(
        value: MemberBloc().userSnapshot,
        initialData: Member(),
      ),
    ],
    child: MaterialApp(
        title: 'MemoClub',
        theme: AppTheme.appThemeData,
        home: hasData ? Home() : Welcome(),

        // To navigate to another page enter type the command:
        // Navigator.pushNamed(context, <ClassWithRouteName>.routeName);
        // example: Navigator.pushNamed(context, Register.routeName);
        routes: <String, WidgetBuilder>{
          Home.routeName: (context) => Home(),
          SignIn.routeName: (context) => SignIn(),
          Register.routeName: (context) => Register(),
          Profile.routeName: (context) => Profile(),
          SettingsPage.routeName: (context) => SettingsPage(),
          Welcome.routeName: (context) => Welcome(),
          HealthRoom.routeName: (context) => HealthRoom(),
          GamesRoom.routeName: (context) => GamesRoom(),
          BusinessRoom.routeName: (context) => BusinessRoom(),
          StudyRoom.routeName: (context) => StudyRoom(),
        }),
  );
}
