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
  User? prevUser;

  void dispose() {
    _controller.close();
    _profileInfoController.close();
  }

  MemberBloc() {
    _auth.authStateChanges().listen((event) {
      createMember(event);
    });
  }
  final _controller = StreamController<Member?>();

  Stream<Member?> get memberStream => _controller.stream;

  // Stream<DocumentSnapshot<Map<String, dynamic>>> get userSnapshot =>
  //     _profileInfoController.stream;
  // Stream<Map<String, dynamic>?> get userSnapshot =>
  //     _profileInfoController.stream;
  Stream<Member> get userSnapshot =>
      _profileInfoController.stream;

  // final _profileInfoController =
  //     StreamController<DocumentSnapshot<Map<String, dynamic>>>();
  // final _profileInfoController = StreamController<Map<String, dynamic>?>();
  final _profileInfoController = StreamController<Member>();

  Future<void> createMember(User? currUser) async {
    // if (curr)
    if (currUser != null) {
      if (prevUser == null || (prevUser!.uid != currUser.uid)) {
        print("CREATING NEW MEMBER TO ADD TO MEMBER STREAM");
        print("prevUser is $prevUser");
        print("currUser is $currUser");
        print("currUser PULLED FROM AUTHSTATECHANGES $currUser");
        Map<String, dynamic>? data =
            await _db.getUserInfoFromFirestore(currUser);
        print("FIRESTORE DATA IS $data");
        Member newMember = Member.fromMap(data);
        print("MEMBER IS $newMember");
        _controller.sink.add(newMember);
        grabProfileSnapshot(currUser);
        prevUser = currUser;
      }
    }
    prevUser = currUser;
  }

  // Future<void> grabProfileSnapshot(User? currUser) async {
  //   FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //   _profileInfoController.addStream(
  //       _firebaseFirestore.collection('users').doc(currUser!.uid).snapshots().map((event) => event.data()));
  // }
  Future<void> grabProfileSnapshot(User? currUser) async {
    FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
    _profileInfoController.addStream(_firebaseFirestore
        .collection('users')
        .doc(currUser!.uid)
        .snapshots()
        .map((event) {
      return Member.fromMap(event.data());
    }));
  }
}
