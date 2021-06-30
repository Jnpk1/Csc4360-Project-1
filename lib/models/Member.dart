import 'package:cloud_firestore/cloud_firestore.dart';

class Member {
  String firstName;
  String lastName;
  String id;
  String email;
  Map<String, bool>? connectedSocials = Map<String, bool>();
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
    Map<String, bool> _connectedSocials = Map<String, bool>();
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
