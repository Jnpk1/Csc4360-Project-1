import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/services/database.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static final String routeName = '/register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  DatabaseService database = DatabaseService();

  @override
  Widget build(BuildContext context) {
    AuthService _auth = Provider.of<AuthService>(context, listen: false);
    print(Navigator.of(context).toString());
    return SingleChildScrollView(
      child: Container(
          child: Center(
              child: Column(
        children: <Widget>[
          Text('register page'),
          ElevatedButton(
              onPressed: () async {
                var result = await _auth.signInAnon();
                // Navigates user to home page if they signed in successfully
                if (result != null) {
                  Navigator.pushNamed(context, Home.routeName);
                }
              },
              child: Center(child: Text('sign in anon'))),
        ],
      ))),
    );
  }

  // // HAVE NOT TESTED YET
  // void registerUserWithEmailAndPassword() async {
  //   try {
  //     User? newUser = await Provider.of<AuthService>(context, listen: false)
  //         .registerWithEmailAndPassword(
  //             firstName: _firstName,
  //             lastName: _lastName,
  //             email: _email,
  //             password: _password);
  //     if (newUser != null) {
  //       print(
  //           'Registered user: ${newUser.uid} | Name: ${newUser.displayName} | Email: ${newUser.email} | Password: $_password}');
  //       // Create a new user in the database
  //       database.createUserInDatabaseWithEmail(newUser);

  //       /// Make sure user was also signed in after registration
  //       auth.User currentUser =
  //           await Provider.of<AuthService>(context, listen: false).getUser();
  //       if (currentUser != null) {
  //         print('Registered user was signed in: ${currentUser.uid}');
  //         List<MessageCard> personalMessages =
  //             await firebaseRepository.getPersonalMessages(currentUser);
  //         for (MessageCard messageCard in personalMessages) {
  //           print(messageCard);
  //         }
  //       } else {
  //         print('User was registered but not signed in!');
  //       }
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(
  //               builder: (BuildContext context) => Home(
  //                     firebaseUser: newUser,
  //                   )),
  //           (Route<dynamic> route) => false);
  //     }
  //   } on auth.FirebaseAuthException catch (error) {
  //     print('AuthException: ' + error.message.toString());
  //     return _buildErrorDialog(context, error.toString());
  //   }
  // }
}
