import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Member {
  String firstName;
  String lastName;
  String id;
  String email;
  String username;
  Map<String, String>? connectedSocials = Map<String, String>();
  String role;
  Timestamp? dateRegistered;

  Member(
      {this.firstName = '',
      this.lastName = '',
      this.id = '',
      this.email = '',
      this.connectedSocials,
      this.role = '',
      this.username = '',
      this.dateRegistered});
  String get() {
    return id;
  }

  factory Member.fromMap(Map<String, dynamic>? userInfo) {
    if (userInfo == null) {
      return Member();
    }
    try {
      Map<String, String> _connectedSocials = Map<String, String>();
      // var facebookInfo = userInfo["connectedSocials"]["facebook"];
      // var googleInfo = userInfo["connectedSocials"]["google"];
      // assert(facebookInfo is String);
      // assert(googleInfo is String);

      _connectedSocials["facebook"] = userInfo["connectedSocials"]["facebook"];
      _connectedSocials["instagram"] =
          userInfo["connectedSocials"]["instagram"];
      Member res = new Member(
        firstName: userInfo["firstName"],
        lastName: userInfo["lastName"],
        id: userInfo["id"],
        email: userInfo["email"],
        connectedSocials: _connectedSocials,
        role: userInfo["role"],
        dateRegistered: userInfo["dateRegistered"],
        username: userInfo["username"],
      );
      print("resulting member is $res");
      return res;
    } catch (e) {
      print(e);
      print("ERROR: Error occurred during Member.fromMap");
      return Member(
          firstName: "ERROR",
          lastName: "ERROR",
          dateRegistered: Timestamp.now());
    }
  }

  @override
  String toString() {
    return "Member($username, $firstName, $lastName, $id, $email, $connectedSocials, $role)";
  }
}
