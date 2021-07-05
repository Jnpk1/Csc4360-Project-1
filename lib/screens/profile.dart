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
    String _facebookLink = currentMember.connectedSocials?["facebook"] ?? '';
    String _instagramLink = currentMember.connectedSocials?["instagram"] ?? '';
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: memoAppBar(context, "Profile"),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
          child: ListView(children: <Widget>[
            Card(
                child: ListTile(
              leading: Icon(
                Icons.facebook,
                size: 56.0,
                color: Colors.white,
              ),
              tileColor: kPrimaryColor,
              title: Text(
                'Facebook Account',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.white),
              ),
              onTap: () async {
                if (_facebookLink.isNotEmpty) {
                  await canLaunch(_facebookLink)
                      ? await launch(_facebookLink)
                      : throw 'Could not launch $_facebookLink';
                }
              },
              subtitle: _facebookLink.isEmpty
                  ? Text(
                      "No Facebook link available.",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Colors.white),
                    )
                  : (Text(
                      "$_facebookLink",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Colors.white),
                    )),
            )),
            Card(
                child: ListTile(
              leading: Icon(
                Icons.camera_alt_outlined,
                size: 56.0,
                color: Colors.white,
              ),
              tileColor: kPrimaryColor,
              title: Text(
                'Instagram Account',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.white),
              ),
              onTap: () async {
                if (_instagramLink.isNotEmpty) {
                  await canLaunch(_instagramLink)
                      ? await launch(_instagramLink)
                      : throw 'Could not launch $_instagramLink';
                }
              },
              subtitle: _instagramLink.isEmpty
                  ? Text(
                      "No Instagram link available.",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Colors.white),
                    )
                  : (Text(
                      "$_instagramLink",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Colors.white),
                    )),
            )),
            roomButtons(context),
          ]),
        ),
      ),
      drawer: memoDrawer(context),
    );
  }
}

// Widget facebookLink(context, String possibleUrl) {
//   return possibleUrl.isEmpty
//       ? Container(child: Text("Facebook is not connected."))
//       : StyledButton(
//           text: possibleUrl,
//           onPressed: () async => await canLaunch(possibleUrl)
//               ? await launch(possibleUrl)
//               : throw 'Could not launch $possibleUrl');
// }

// Widget instagramLink(context, String possibleUrl) {
//   return possibleUrl.isEmpty
//       ? Container(child: Text("Instagram is not connected."))
//       : StyledButton(
//           text: possibleUrl,
//           onPressed: () async => await canLaunch(possibleUrl)
//               ? await launch(possibleUrl)
//               : throw 'Could not launch $possibleUrl');
// }
