import 'package:flutter/material.dart';
import 'package:memoclub/models/Member.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/shared/appbar.dart';
import 'package:memoclub/shared/drawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static final String routeName = '/profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Member currentMember = Provider.of<Member>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: memoAppBar(context, "Profile"),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                "Connected Social Acocunts",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: kOnBackgroundColor),
              ),
              SizedBox(
                height: 40,
              ),
              Icon(Icons.facebook),
              facebookLink(
                  context, currentMember.connectedSocials?['facebook'] ?? ''),
              SizedBox(
                height: 40,
              ),
              Icon(Icons.camera_alt),
              instagramLink(
                  context, currentMember.connectedSocials?['instagram'] ?? ''),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: Container(),
              ),
              roomButtons(context),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      drawer: memoDrawer(context),
    );
  }
}

Widget facebookLink(context, String possibleUrl) {
  return possibleUrl.isEmpty
      ? Container(child: Text("Facebook is not connected."))
      : StyledButton(
          text: possibleUrl,
          onPressed: () async => await canLaunch(possibleUrl)
              ? await launch(possibleUrl)
              : throw 'Could not launch $possibleUrl');
}

Widget instagramLink(context, String possibleUrl) {
  return possibleUrl.isEmpty
      ? Container(child: Text("Instagram is not connected."))
      : StyledButton(
          text: possibleUrl,
          onPressed: () async => await canLaunch(possibleUrl)
              ? await launch(possibleUrl)
              : throw 'Could not launch $possibleUrl');
}
// https://firebase.flutter.dev/docs/firestore/usage#realtime-changes
// use ^^ to track connected social media accounts.

// class UserInformation extends StatefulWidget {
//   @override
//   _UserInformationState createState() => _UserInformationState();
// }

// class _UserInformationState extends State<UserInformation> {
//   final Stream<QuerySnapshot> _usersStream =
//       FirebaseFirestore.instance.collection('users').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("Loading");
//         }

//         return new ListView(
//           children: snapshot.data.docs.map((DocumentSnapshot document) {
//             Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//             return new ListTile(
//               title: new Text(data['full_name']),
//               subtitle: new Text(data['company']),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }
