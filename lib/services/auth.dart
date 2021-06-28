import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:memoclub/models/Member.dart';

class AuthService with ChangeNotifier {
  Member currentMember = Member();
  FirebaseAuth _auth = FirebaseAuth.instance;
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

  Future<User?> getUser() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        print('User signed in: ${user.email}');
        print('Creating Member Object');
        // get user info from DatabaseService
      } else {
        print('No user signed in');
      }
      notifyListeners();
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
