import 'package:cloud_firestore/cloud_firestore.dart';

class MessageCard {
  String author;
  DateTime? date;
  String content;
  String room;

  MessageCard({
    this.author = '',
    this.content = '',
    this.room = '',
    this.date,
  });

  factory MessageCard.fromMap(Map<String, dynamic> userInfo) {
    MessageCard res = new MessageCard(
      author: userInfo["author"],
      date: (userInfo["date"] as Timestamp).toDate(),
      content: userInfo["content"],
      room: userInfo["room"],
    );

    return res;
  }

  @override
  String toString() {
    return "MessageCard($author, $content, $date)";
  }
}
