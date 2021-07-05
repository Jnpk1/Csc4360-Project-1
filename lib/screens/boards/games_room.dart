import 'package:bubble/bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memoclub/models/Member.dart';
import 'package:memoclub/models/MessageCard.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/services/auth.dart';
import 'package:memoclub/services/database.dart';
import 'package:memoclub/shared/appbar.dart';
import 'package:memoclub/shared/drawer.dart';
import 'package:memoclub/shared/loading.dart';
import 'package:provider/provider.dart';

class GamesRoom extends StatefulWidget {
  static final String routeName = '/games_room';
  @override
  _GamesRoomState createState() => _GamesRoomState();
}

class _GamesRoomState extends State<GamesRoom> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: memoAppBar(context, "Games Room"),
      drawer: memoDrawer(context),
      body: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            Flexible(
              child: buildMessageList(context),
            ),
            buildInput(context, myController),
          ],
        )
      ]),
    );
  }
}

Widget buildMessageList(BuildContext context) {
  DatabaseService db = DatabaseService();
  return StreamBuilder<List<MessageCard>>(
    stream: db.gamesMessages,
    builder: (BuildContext context, AsyncSnapshot<List<MessageCard>> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return LoadingCircle();
      }
      List<MessageCard>? _messageList = snapshot.data;
      // print("posted by: ${_messageList?[0].author ?? ''}");
      // print("list of messages = $_messageList");
      return new ListView.builder(
        reverse: true,
        shrinkWrap: true,
        padding: EdgeInsets.all(10.0),
        itemCount: snapshot.data?.length,
        itemBuilder: (context, index) => buildItem(
            context, _messageList?[index] ?? MessageCard(date: DateTime.now())),
      );
    },
  );
}

Widget buildItem(context, MessageCard currCard) {
  User? currUser = FirebaseAuth.instance.currentUser;
  // print()
  String timePosted = DateFormat.yMd()
      .add_jm()
      .format(currCard.date?.toLocal() ?? DateTime.now());
  if (currCard.author == currUser?.displayName) {
    // Right (my message)
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Container(
            // width: 300.0,
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Bubble(
                color: kSelfMessageTileColor,
                elevation: 0,
                // borderColor: kMessageBorderColor,
                // padding: const BubbleEdges.all(10.0),
                padding: const BubbleEdges.fromLTRB(10, 4, 10, 4),
                nip: BubbleNip.rightTop,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "posted by: ${currCard.author}",
                          style: Theme.of(context)
                              .textTheme
                              .overline
                              ?.copyWith(color: kMessageUsernameAndDateColor),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                    Text(currCard.content,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: kMessageContentColor)),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Text(
                          "posted on: $timePosted",
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .overline
                              ?.copyWith(color: kMessageUsernameAndDateColor),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        )
      ],
    );
  } else {
    // Left (peer message)
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            width: 300.0,
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Bubble(
                color: kMessageTileColor,
                elevation: 0,
                // borderColor: kMessageBorderColor,
                // padding: const BubbleEdges.all(10.0),
                padding: const BubbleEdges.fromLTRB(10, 4, 10, 4),
                nip: BubbleNip.leftTop,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "posted by: ${currCard.author}",
                          style: Theme.of(context)
                              .textTheme
                              .overline
                              ?.copyWith(color: kMessageUsernameAndDateColor),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                    Text(currCard.content,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: kMessageContentColor)),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Text(
                          "posted on: $timePosted",
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .overline
                              ?.copyWith(color: kMessageUsernameAndDateColor),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        )
      ],
    );
  }
}

Widget buildInput(BuildContext context, TextEditingController myController) {
  return Container(
      child: Padding(
        // padding: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            // Edit text
            Flexible(
              child: Container(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.black),
                      // autofocus: true,
                      maxLines: 5,
                      controller: myController,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Type your message...',
                      ),
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send, size: 25),
                onPressed: () async {
                  String msgContent = myController.text;
                  myController.clear(); // currently doesn't clear

                  User? currUser =
                      await Provider.of<AuthService>(context, listen: false)
                          .getUser();
                  MessageCard mc = MessageCard(
                      author: currUser?.displayName ?? '',
                      content: msgContent,
                      date: DateTime.now(),
                      room: "gamesRoom");
                  DatabaseService db = DatabaseService();
                  await db.createMessageInDatabase(mc);
                  print("Added $mc to Firestore.");
                  myController.clear();
                  // myController.clear();
                  // myController.clearComposing();
                },
              ),
            ),
          ],
        ),
      ),
      width: double.infinity,
      height: 100.0);
}
