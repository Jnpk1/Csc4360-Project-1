import 'package:cloud_firestore/cloud_firestore.dart';

class MessageCard {
  String author;
  DateTime? date;
  String content;
  String room;

  MessageCard(
      {this.author = '',
      this.content = '',
      this.room = '',
      this.date,
      });

  // factory MessageCard.fromMap(Map<String, dynamic> userInfo) {
  //   Map<String, String> _connectedSocials = Map<String, String>();
  //   _connectedSocials["facebook"] = userInfo["connectedSocials"]["facebook"];
  //   _connectedSocials["google"] = userInfo["connectedSocials"]["google"];
  //   MessageCard res = new MessageCard(
  //     firstName: userInfo["firstName"],
  //     lastName: userInfo["lastName"],
  //     id: userInfo["id"],
  //     email: userInfo["email"],
  //     connectedSocials: _connectedSocials,
  //     role: userInfo["role"],
  //     dateRegistered: userInfo["dateRegistered"],
  //   );
  //   print("resulting member is $res");
  //   return res;
  // }

  @override
  String toString() {
    return "MessageCard($author, $content, $date)";
  }
}
