import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memoclub/models/Member.dart';
import 'package:provider/provider.dart';

class AuthService with ChangeNotifier {
  Member currentMember = Member();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? user;
  AuthService();

  // Future<Member> getUser() async {
  //   try {
  //     final user = _auth.currentUser;

  //     if (user != null) {
  //       print('User signed in: ${user.email}');
  //       print('Creating Member Object');
  //       // get user info from DatabaseService
  //       Member curr
  //     } else {
  //       print('No user signed in');
  //     }
  //     notifyListeners();
  //     return user;
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  // Allows the app to grab up to date current user from anywhere in the app.
  // Access by useing "Provider.of<AuthService>(context, listen: false).getUser()"
  Future<User?> getUser() async {
    try {
      final currUser = _auth.currentUser;

      if (currUser != null) {
        print('User signed in: ${currUser.email}');
        print('Creating Member Object');
        // get user info from DatabaseService
      } else {
        print('No user signed in');
      }
      notifyListeners();
      return currUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // used by futurebuilder to do an initial check if user is signed in/out
  // happens when app first launches
  Future<User?> firstLogin() async {
    try {
      final currentMember = _auth.currentUser;

      if (currentMember != null) {
        print('User signed in: ${currentMember.email}');
        print('Creating Member Object');
        return currentMember;
        // get user info from DatabaseService
      } else {
        print('No user signed in');
      }
      return currentMember;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  // // Haven't tested yet
  // Future registerWithEmailAndPassword(
  //     {required String email,
  //     required String password,
  //     required String firstName,
  //     required String lastName}) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     User? newUser = result.user;

  //     /// Add the first and last name to the FirebaseUser
  //     String newDisplayName = '$firstName $lastName';

  //     await newUser
  //         ?.updateDisplayName(newDisplayName)
  //         .catchError((error) => print(error));

  //     // Refresh data
  //     await newUser?.reload();

  //     // Need to make this call to get the updated display name; or else display name will be null
  //     User? updatedUser = _auth.currentUser;

  //     print('new display name: ${updatedUser?.displayName}');

  //     notifyListeners();

  //     // Return FirebaseUser with updated information (setting the display name using their first and last name)
  //     return updatedUser;
  //   } catch (e) {
  //     print(e.toString());

  //     return null;
  //   }
  // }

  // sign in with email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? currUser = result.user;
      return currUser!;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // register with email and pass

  Future registerWithEmailAndPassword(String email, String password,
      String firstName, String lastName, DateTime dateRegistered) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? currUser = result.user;
      // create a new document based on new user
      // await DatabaseService(uid: currUser?.uid as String)
      //     .updateUserData(firstName, lastName, 'Customer', dateRegistered);
      return currUser!;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Future createEmailUserInDatabase(User? currUser,) {

  // }

  // anonymous sign in
  Future signInAnon() async {
    print('trying to sign in anonymously');
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? currUser = result.user;
      print("signed in anonymously with user: $currUser");
      notifyListeners();
      return currUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
