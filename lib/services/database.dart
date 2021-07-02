import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memoclub/models/Member.dart';

class DatabaseService with ChangeNotifier {
  final _firestoreInstance = FirebaseFirestore.instance;

  DatabaseService();

  static const String USERS_COLLECTION = "users";
  static const String USER_FIRSTNAME_FIELD = "firstName";
  static const String USER_LASTNAME_FIELD = "lastName";
  static const String USER_ID_FIELD = "id";
  static const String USER_EMAIL_FIELD = "email";
  static const String USER_DATE_REGISTERED_FIELD = "dateRegistered";
  static const String USER_ROLE_FIELD = "role";

  static const String USER_SOCIAL_FIELD = "connectedSocials";
  static const String USER_FACEBOOK_FIELD = "facebook";
  static const String USER_GOOGLE_FIELD = "google";

  static const String ROOM_COLLECTION = 'gamesRoom';
  static const String GAMES_ROOM = 'gamesRoom';
  static const String BUSINESS_ROOM = 'businessRoom';
  static const String STUDY_ROOM = 'studyRoom';
  static const String HEALTH_ROOM = 'healthRoom';
  static const String MSG_COLLECTION = 'messages';
  static const String MSG_AUTHOR_FIELD = 'author';
  static const String MSG_CONTENT_FIELD = 'content';
  static const String MSG_DATE_FIELD = 'date';
  static const String MSG_ROOM_FIELD = 'date';

  // TODO: Add methods to create, store, and modify users and messages

  Future createUserInDatabaseFromEmail(
      User? currUser,
      String email,
      String password,
      String firstName,
      String lastName,
      DateTime dateRegistered,
      {String userRole = 'Customer'}) async {
    Map<String, String> connectedSocials = new Map<String, String>();
    connectedSocials[USER_FACEBOOK_FIELD] = "";
    connectedSocials[USER_GOOGLE_FIELD] = "";

    if (currUser != null) {
      _firestoreInstance
          .collection(USERS_COLLECTION)
          .doc(currUser.uid)
          .set({
            USER_EMAIL_FIELD: email,
            USER_FIRSTNAME_FIELD: firstName,
            USER_LASTNAME_FIELD: lastName,
            USER_ID_FIELD: currUser.uid,
            USER_ROLE_FIELD: userRole,
            USER_DATE_REGISTERED_FIELD: dateRegistered,
            USER_SOCIAL_FIELD: connectedSocials
          })
          .then((value) =>
              print('$firstName $lastName created in Firestore Database.'))
          .catchError((error) => print('Failed to create user: $error'));
    } else {
      print('User was null, so could not complete createUserInDatabase()');
    }
  }

  Future<Member> createMemberFromFirebase(User? user) async {
    try {
      if (user != null) {
        _firestoreInstance
            .collection(USERS_COLLECTION)
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot userInfoSnapshot) {
          print(userInfoSnapshot.data());
          print('map of user data');
          print(userInfoSnapshot.data() as Map<String, dynamic>);

          Member currMember =
              Member.fromMap(userInfoSnapshot.data() as Map<String, dynamic>);
          print("currMember inside Database = $currMember");
          return currMember;
        });
      } else {
        return Member();
      }
    } catch (e) {
      print('Error occured in createMemberFromFirebase');
      print(e);
    }
    return Member();
  }
}
