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
  DatabaseService db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    // Member currMember = Provider.of<AuthService>(context).currentMember;
    return Scaffold(
      appBar: memoAppBar(context, "Health Room"),
      drawer: memoDrawer(context),
      body: StreamBuilder<List<MessageCard>>(
        stream: db.healthMessages,
        builder:
            (BuildContext context, AsyncSnapshot<List<MessageCard>> snapshot) {
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
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) => buildItem(
                context,
                _healthMessageList?[index] ??
                    MessageCard(date: DateTime.now())),
          );

          // )
          //   children: snapshot.data.docs.map((DocumentSnapshot document) {
          //     Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          //     return new ListTile(
          //       title: new Text(data['full_name']),
          //       subtitle: new Text(data['company']),
          //     );
          //   }).toList(),
          // );
        },
      ),
    );
  }
}

Widget buildItem(context, MessageCard currCard) {
  DateFormat f = new DateFormat('yyyy/MM/dd hh:mm');
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
          Row(children: <Widget>[
            Container(
              child: Bubble(
                  color: kMessageTileColor,
                  elevation: 0,
                  // borderColor: kMessageBorderColor,
                  padding: const BubbleEdges.all(10.0),
                  nip: BubbleNip.leftTop,
                  child: Column(
                    children: [
                      Text(
                        "posted by: ${currCard.author}",
                        style: Theme.of(context)
                            .textTheme
                            .overline
                            ?.copyWith(color: kMessageUsernameAndDateColor),
                      ),
                      Text(currCard.content,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: kMessageContentColor)),
                      Text(
                        "posted on: ${f.format(currCard.date?.toLocal() ?? DateTime.now())}",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .overline
                            ?.copyWith(color: kMessageUsernameAndDateColor),
                      ),
                    ],
                  )),
              width: 300.0,
              margin: const EdgeInsets.only(left: 10.0),
            )
          ]),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
