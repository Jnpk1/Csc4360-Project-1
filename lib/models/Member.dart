import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Member {
  String firstName;
  String lastName;
  String id;
  String email;
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
      this.dateRegistered});

  factory Member.fromMap(Map<String, dynamic> userInfo) {
    Map<String, String> _connectedSocials = Map<String, String>();
    _connectedSocials["facebook"] = userInfo["connectedSocials"]["facebook"];
    _connectedSocials["google"] = userInfo["connectedSocials"]["google"];
    Member res = new Member(
      firstName: userInfo["firstName"],
      lastName: userInfo["lastName"],
      id: userInfo["id"],
      email: userInfo["email"],
      connectedSocials: _connectedSocials,
      role: userInfo["role"],
      dateRegistered: userInfo["dateRegistered"],
    );
    print("resulting member is $res");
    return res;
  }

  @override
  String toString() {
    return "Member($firstName, $lastName, $id, $email, $connectedSocials, $role)";
  }
}
