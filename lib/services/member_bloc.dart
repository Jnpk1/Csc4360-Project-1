import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memoclub/models/Member.dart';
import 'package:memoclub/models/MessageCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memoclub/models/Member.dart';
import 'package:memoclub/services/database.dart';
import 'package:provider/provider.dart';

class MemberBloc {
  DatabaseService _db = DatabaseService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _profileInfoController = StreamController<Member>();
  CurrentStreamHandler currentStreamHandler = CurrentStreamHandler('', null);
  User? prevUser;

  // void dispose() async {
  //   // _profileInfoController.
  //   // await _profileInfoController.close();
  //   // _profileInfoController.close();
  //   _profileInfoController = StreamController<Member>();
  // }

  MemberBloc() {
    _auth.authStateChanges().listen((currUser) {
      if (currUser != null) {
        currentStreamHandler =
            new CurrentStreamHandler(currUser.uid, _profileInfoController);
        // _grabProfileSnapshot(currUser, );
      }

      // _grabProfileSnapshot(currUser);
    });

    // _authStateController.stream.listen((event) {
  }

  Stream<Member> get memberStream => _profileInfoController.stream;

  // takes stream from auth state changes and converts to snapshots
  // final _authStateController = StreamController<User?>();

  // Future<void> createMember(User? currUser) {

  //   _firebaseFirestore
  //       .collection('users')
  //       .doc(currUser.uid)
  //       .snapshots()
  //       .map((event) {
  //     return Member.fromMap(event.data());
  //   }
  //   prevUser = currUser;
  // }

  // void addToStream() {

  // }

  // Future<void> _grabProfileSnapshot(User? currUser) async {
  //   if (_profileInfoController.isClosed) {
  //     return;
  //   }
  //   if (currUser != null) {
  //     if (prevUser == null || (prevUser!.uid != currUser.uid)) {
  //       FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //       _profileInfoController.addStream(
  //         _firebaseFirestore
  //             .collection('users')
  //             .doc(currUser.uid)
  //             .snapshots()
  //             .map((event) {
  //           return Member.fromMap(event.data());
  //         }),
  //       );
  //     }
  //   }
  //   prevUser = currUser;
  // }

  // Future<void> _grabProfileSnapshot(User? currUser) async {
  //   if (_profileInfoController.isClosed) {
  //     return;
  //   }
  //   if (currUser != null) {
  //     if (prevUser == null || (prevUser!.uid != currUser.uid)) {
  //       FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //       _profileInfoController.addStream(
  //         _firebaseFirestore
  //             .collection('users')
  //             .doc(currUser.uid)
  //             .snapshots()
  //             .map((event) {
  //           return Member.fromMap(event.data());
  //         }),
  //       );
  //     }
  //   }
  //   prevUser = currUser;
  // }

  // Future<dynamic> closeStream() {

  // }
}

class CurrentStreamHandler {
  String uid;
  StreamController<Member>? streamController;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CurrentStreamHandler(this.uid, this.streamController) {
    if (uid.isNotEmpty) {
      _firebaseFirestore
          .collection("users")
          .doc(uid)
          .snapshots()
          .listen((event) {
        addMember(event.data());
      });
    }
  }

  // void dispose() {

  // }

  void addMember(Map<String, dynamic>? data) {
    streamController?.sink.add(Member.fromMap(data));
  }

  // Stream<Member> get memberStream => _profileInfoController.stream;

  // final _profileInfoController = StreamController<Member>();

  // Future<void> _grabProfileSnapshot(String uid) async {
  //   if (uid.isNotEmpty) {

  //       _firebaseFirestore
  //           .collection('users')
  //           .doc(currUser.uid)
  //           .snapshots()
  //           .map((event) {
  //         return Member.fromMap(event.data());
  //       }),
  //     );

  //   }
  //   prevUser = currUser;
  // }
}
