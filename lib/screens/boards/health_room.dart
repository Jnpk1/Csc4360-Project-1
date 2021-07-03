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
import 'package:provider/provider.dart';

class HealthRoom extends StatefulWidget {
  static final String routeName = '/health_room';
  @override
  _HealthRoomState createState() => _HealthRoomState();
}

class _HealthRoomState extends State<HealthRoom> {
  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('users').snapshots();

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Member currMember = Provider.of<AuthService>(context).currentMember;
    return Scaffold(
      appBar: memoAppBar(context, "Health Room"),
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
    stream: db.healthMessages,
    builder: (BuildContext context, AsyncSnapshot<List<MessageCard>> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }
      List<MessageCard>? _healthMessageList = snapshot.data;
      print("posted by: ${_healthMessageList?[0].author ?? ''}");
      print("list of msseages = ${_healthMessageList}");
      return new ListView.builder(
        reverse: true,
        shrinkWrap: true,
        padding: EdgeInsets.all(10.0),
        itemCount: snapshot.data?.length,
        itemBuilder: (context, index) => buildItem(context,
            _healthMessageList?[index] ?? MessageCard(date: DateTime.now())),
      );
    },
  );
}

Widget buildItem(context, MessageCard currCard) {
  String timePosted = DateFormat.yMd()
      .add_jm()
      .format(currCard.date?.toLocal() ?? DateTime.now());
  if (currCard.author == '') {
    // Right (my message)
    return Row(
      children: <Widget>[
        // Text
        Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Text("posted by: "),
                Bubble(
                    color: Colors.blueGrey,
                    elevation: 0,
                    padding: const BubbleEdges.all(10.0),
                    nip: BubbleNip.rightTop,
                    child: Text(currCard.content,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: kMessageContentColor))),
                Text("posted on: date"),
              ],
            ),
            width: 200)
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  } else {
    // Left (peer message)
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: <Widget>[
          Container(
            child: Bubble(
                color: kMessageTileColor,
                elevation: 0,
                // borderColor: kMessageBorderColor,
                // padding: const BubbleEdges.fromLTRB(10, 2, 10, 2),
                alignment: Alignment.topLeft,
                // margin: BubbleEdges.only(top: 10),
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
                    Text(
                      currCard.content,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: kMessageContentColor),
                      maxLines: 5,
                      // textAlign: TextAlign.left,
                    ),
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
            width: 300.0,
            margin: const EdgeInsets.only(left: 10.0),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
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
                  myController.clear();

                  User? currUser =
                      await Provider.of<AuthService>(context, listen: false)
                          .getUser();
                  MessageCard mc = MessageCard(
                      author: 'current no username',
                      content: msgContent,
                      date: DateTime.now(),
                      room: "healthRoom");
                  DatabaseService db = DatabaseService();
                  await db.createMessageInDatabase(mc);
                  print("Added $mc to Firestore.");

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
