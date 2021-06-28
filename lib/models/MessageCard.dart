class MessageCard {
  DateTime date;
  String content;
  String author;

  MessageCard(
      {required this.date, required this.content, required this.author});

  @override
  String toString() {
    // TODO: implement toString
    return "MessageCard($date, $content, $author)";
  }
}
