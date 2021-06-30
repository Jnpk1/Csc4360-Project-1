import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/screens/sign_in.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/services/database.dart';
import 'package:memoclub/shared/inputDecor.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static final String routeName = '/register';
  @override
  _RegisterState createState() => _RegisterState();
}

// class _RegisterState extends State<Register> {
//   DatabaseService database = DatabaseService();

//   @override
//   Widget build(BuildContext context) {
//     AuthService _auth = Provider.of<AuthService>(context, listen: false);
//     print(Navigator.of(context).toString());
//     return SingleChildScrollView(
//       child: Container(
//           child: Center(
//               child: Column(
//         children: <Widget>[
//           Text('Register Here'),
//           ElevatedButton(
//               onPressed: () async {
//                 var result = await _auth.signInAnon();
//                 // Navigates user to home page if they signed in successfully
//                 if (result != null) {
//                   Navigator.pushNamed(context, Home.routeName);
//                 }
//               },
//               child: Center(child: Text('sign in anon'))),
//         ],
//       ))),
//     );
//   }
class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  String firstName = '';
  String lastName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          title: Text('Register Here'),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              onPressed: () {
                Navigator.pushNamed(context, Home.routeName);
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
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }),
                  SizedBox(height: 15.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      }),
                  SizedBox(height: 15.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'First Name'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter your First Name' : null,
                      onChanged: (val) {
                        setState(() => firstName = val);
                      }),
                  SizedBox(height: 15.0),
                  TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Last Name'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter your Last Name' : null,
                      onChanged: (val) {
                        setState(() => lastName = val);
                      }),
                  SizedBox(height: 15.0),
                  ElevatedButton(
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
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
                            setState(
                                () => error = 'please input a valid email');
                          }
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
