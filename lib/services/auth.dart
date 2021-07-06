import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memoclub/models/Member.dart';
import 'package:memoclub/services/database.dart';
import 'package:provider/provider.dart';

class AuthService with ChangeNotifier {
  Member currentMember = Member();
  DatabaseService _db = DatabaseService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? user;
  AuthService();

  // Allows the app to grab up to date current user from anywhere in the app.
  // Access by useing "Provider.of<AuthService>(context, listen: false).getUser()"
  Future<User?> getUser() async {
    try {
      final currUser = _auth.currentUser;

      if (currUser != null) {
        print('User signed in: ${currUser.email}');
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
      final currUser = _auth.currentUser;

      if (currUser != null) {
        print('User signed in: ${currUser.email}');
        print('Creating Member Object');
        // get user info from DatabaseService
        Map<String, dynamic>? res =
            await _db.getUserInfoFromFirestore(currUser);
        print(res);
        if (res != null) {
          currentMember = Member.fromMap(res);
          // print("Created new member during sign in. $currentMember");
        }
      } else {
        print('No user signed in');
      }
      return currUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> createUsernameDuringRegistration(
      User? user, String firstName, String lastName) async {
    try {
      String newUsername = firstName.trim() + '-' + lastName.trim();
      const int maxLenUsername = 18;
      if (newUsername.length > maxLenUsername) {
        print(
            "WARNING: username is longer than max allowed. Cutting off extra.");
        newUsername = newUsername.substring(0, maxLenUsername + 1);
      }

      await user?.updateDisplayName(newUsername);
      user?.reload();
      User? updatedUser = await getUser();
      print("username is updated to ${updatedUser?.displayName}");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      userCredential = await _auth.signInWithCredential(googleAuthCredential);
      User? user = userCredential.user;
      if (user != null) {
        print(
            'FirebaseUser creation time: ${user.metadata.creationTime} FirebaseUser lastSignInTime: ${user.metadata.lastSignInTime}');
        // If it is a new user (signing in for the first time), create a user in the database
        DateTime? creation = user.metadata.creationTime;
        DateTime? lastSignIn = user.metadata.lastSignInTime;
        if ((creation?.difference(lastSignIn ?? DateTime.now()).abs() ??
                Duration(seconds: 2)) <
            Duration(seconds: 1)) {
          print('Creating new user in Database.');
          await _db.createUserInDatabaseWithGoogle(user);
        }
      }
      print("Signed in with google as {$user}");
      return userCredential;
    } catch (e) {
      print(e);
    }
  }

  // sign in with email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? currUser = result.user;
      return currUser;
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
