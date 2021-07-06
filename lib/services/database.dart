import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memoclub/models/Member.dart';
import 'package:memoclub/models/MessageCard.dart';

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
  static const String USER_USERNAME_FIELD = "username";

  static const String USER_SOCIAL_FIELD = "connectedSocials";
  static const String USER_FACEBOOK_FIELD = "facebook";
  static const String USER_INSTAGRAM_FIELD = "instagram";

  static const String ROOM_COLLECTION = 'allRooms';
  static const String GAMES_ROOM = 'gamesRoom';
  static const String BUSINESS_ROOM = 'businessRoom';
  static const String STUDY_ROOM = 'studyRoom';
  static const String HEALTH_ROOM = 'healthRoom';
  static const String MSG_COLLECTION = 'messages';
  static const String MSG_AUTHOR_FIELD = 'author';
  static const String MSG_CONTENT_FIELD = 'content';
  static const String MSG_DATE_FIELD = 'date';
  static const String MSG_ROOM_FIELD = 'room';
  static const List ALL_ROOMS = [
    GAMES_ROOM,
    BUSINESS_ROOM,
    HEALTH_ROOM,
    STUDY_ROOM
  ];

  Future createUserInDatabaseFromEmail(
      User? currUser,
      String email,
      String password,
      String firstName,
      String lastName,
      DateTime dateRegistered,
      String username,
      {String userRole = 'Customer'}) async {
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
            USER_SOCIAL_FIELD: {
              USER_FACEBOOK_FIELD: "",
              USER_INSTAGRAM_FIELD: ""
            },
            USER_USERNAME_FIELD: username,
          })
          .then((value) =>
              print('$firstName $lastName created in Firestore Database.'))
          .catchError((error) => print('Failed to create user: $error'));
    } else {
      print('User was null, so could not complete createUserInDatabase()');
    }
  }

  Future createUserInDatabaseWithGoogle(User currUser) async {
    List userName = currUser.displayName?.split(' ') ?? List.empty();
    print(userName);
    if (userName.length > 0) {
      await FirebaseFirestore.instance
          .collection(USERS_COLLECTION)
          .doc(currUser.uid)
          .set({
        USER_FIRSTNAME_FIELD: userName[0],
        USER_LASTNAME_FIELD: userName[1],
        USER_EMAIL_FIELD: currUser.email,
        USER_DATE_REGISTERED_FIELD: DateTime.now(),
        USER_ROLE_FIELD: 'Customer',
        USER_SOCIAL_FIELD: {USER_FACEBOOK_FIELD: "", USER_INSTAGRAM_FIELD: ""},
        USER_ID_FIELD: currUser.uid,
        USER_USERNAME_FIELD: currUser.displayName,
      });
    }
  }

  Future createSocialMediaAcct(String socialMedia) async {}
  Future<Map<String, dynamic>?> getUserInfoFromFirestore(User? currUser) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> result = await _firestoreInstance
          .collection(USERS_COLLECTION)
          .doc(currUser?.uid)
          .get();

      print("VALUE IN DB PULLED IS ${result.data()}");
      return result.data();
    } catch (e) {
      print(e);
    }
  }

  Future createMessageInDatabase(MessageCard msgCardToAdd) async {
    try {
      // checks to make sure room collection exists
      if (ALL_ROOMS.contains(msgCardToAdd.room)) {
        _firestoreInstance
            .collection(ROOM_COLLECTION)
            .doc(msgCardToAdd.room)
            .collection(MSG_COLLECTION)
            .add({
          MSG_AUTHOR_FIELD: msgCardToAdd.author,
          MSG_CONTENT_FIELD: msgCardToAdd.content,
          MSG_DATE_FIELD: msgCardToAdd.date,
          MSG_ROOM_FIELD: msgCardToAdd.room,
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<MessageCard>> getAllHealthMessages() async {
    List<MessageCard> _messageList = [];
    print("trying to gather messages...");
    try {
      _firestoreInstance
          .collection(ROOM_COLLECTION)
          .doc(HEALTH_ROOM)
          .collection(MSG_COLLECTION)
          .get()
          .then((res) {
        res.docs.forEach((element) {
          // print(MessageCard.fromMap(element.data()));
          _messageList.add(MessageCard.fromMap(element.data()));
          print('list is now $_messageList');
        });
        return _messageList;
      });
    } catch (e) {
      print(e);
    }
    return _messageList;
  }

  List<MessageCard> convertToMessageList(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<MessageCard> _healthMessageList = [];
    snapshot.docs.forEach((element) {
      _healthMessageList.add(MessageCard.fromMap(element.data()));
    });
    return _healthMessageList;
  }

  Stream<List<MessageCard>> get healthMessages => _firestoreInstance
      .collection(ROOM_COLLECTION)
      .doc(HEALTH_ROOM)
      .collection(MSG_COLLECTION)
      .orderBy("date", descending: true)
      // .limit(20)
      .snapshots()
      .map(convertToMessageList);

  Stream<List<MessageCard>> get gamesMessages => _firestoreInstance
      .collection(ROOM_COLLECTION)
      .doc(GAMES_ROOM)
      .collection(MSG_COLLECTION)
      .orderBy("date", descending: true)
      // .limit(20)
      .snapshots()
      .map(convertToMessageList);

  Future updateFacebookProfile(
    User? currUser,
    String facebookURL,
  ) async {
    if (currUser != null) {
      _firestoreInstance
          .collection(USERS_COLLECTION)
          .doc(currUser.uid)
          .update({"$USER_SOCIAL_FIELD.$USER_FACEBOOK_FIELD": facebookURL})
          .then((value) => print('Updated Facebook Account $facebookURL.'))
          .catchError((error) => print('Failed to create user: $error'));
    } else {
      print('User was null, so could not complete updateFacebookProfile()');
    }
  }

  Future updateInstagramProfile(
    User? currUser,
    String instagramURL,
  ) async {
    if (currUser != null) {
      _firestoreInstance
          .collection(USERS_COLLECTION)
          .doc(currUser.uid)
          .update({"$USER_SOCIAL_FIELD.$USER_INSTAGRAM_FIELD": instagramURL})
          .then((value) => print('Updated Instagram Account $instagramURL.'))
          .catchError((error) => print('Failed to create user: $error'));
    } else {
      print('User was null, so could not complete updateInstagramProfile()');
    }
  }

  Future updateUsername(String uid, String newUsername) async {
    _firestoreInstance
        .collection(USERS_COLLECTION)
        .doc(uid)
        .update({USER_USERNAME_FIELD: newUsername})
        .then((value) => print('Updated username to $newUsername.'))
        .catchError((error) => print('Failed to create user: $error'));
  }

  Stream<List<MessageCard>> get businessMessages => _firestoreInstance
      .collection(ROOM_COLLECTION)
      .doc(BUSINESS_ROOM)
      .collection(MSG_COLLECTION)
      .orderBy("date", descending: true)
      // .limit(20)
      .snapshots()
      .map(convertToMessageList);

  Stream<List<MessageCard>> get studyMessages => _firestoreInstance
      .collection(ROOM_COLLECTION)
      .doc(STUDY_ROOM)
      .collection(MSG_COLLECTION)
      .orderBy("date", descending: true)
      // .limit(20)
      .snapshots()
      .map(convertToMessageList);

  Stream<Member?> getMember(User? currUser) {
    return _firestoreInstance
        .collection(USERS_COLLECTION)
        .doc(currUser?.uid)
        .snapshots()
        .map((event) => Member.fromMap(event.data()));
  }

  Stream<Member?> currFirestoreMember(User? currUser) {
    return _firestoreInstance
        .collection(USERS_COLLECTION)
        .doc(currUser?.uid)
        .snapshots()
        .map((event) => Member.fromMap(event.data()));
  }
}
