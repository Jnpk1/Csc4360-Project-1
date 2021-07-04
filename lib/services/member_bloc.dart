import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memoclub/models/Member.dart';

class MemberBloc {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final profileInfoController = StreamController<Member>();
  CurrentStreamHandler currentStreamHandler = CurrentStreamHandler('', null);
  User? prevUser;

  void dispose() {
    profileInfoController.close();
  }

  MemberBloc() {
    _auth.authStateChanges().listen((currUser) {
      if (currUser != null) {
        currentStreamHandler =
            new CurrentStreamHandler(currUser.uid, profileInfoController);
      }
    });
  }

  Stream<Member> get memberStream => profileInfoController.stream;
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

  void addMember(Map<String, dynamic>? data) {
    if (streamController != null) {
      if (!streamController!.isClosed) {
        streamController?.sink.add(Member.fromMap(data));
      }
    }
  }
}
