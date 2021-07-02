import 'package:flutter/material.dart';
import 'package:memoclub/models/MessageCard.dart';
import 'package:memoclub/services/database.dart';

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
    return StreamBuilder<List<MessageCard>>(
      stream: db.healthMessages,
      builder:
          (BuildContext context, AsyncSnapshot<List<MessageCard>> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data?[index].author ?? ''),
              );
            });

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
    );
  }
}
