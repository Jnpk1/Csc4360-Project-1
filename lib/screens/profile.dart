import 'package:flutter/material.dart';
import 'package:memoclub/models/Member.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/screens/reset_username.dart';
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
    String _currentUsername = currentMember.username;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: memoAppBar(context, "Profile"),
      body: SafeArea(
        left: true,
        right: true,
        bottom: true,
        top: true,
        minimum: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(children: <Widget>[
          Card(
              margin: EdgeInsets.all(10.0),
              borderOnForeground: false,
              elevation: 0,
              child: ListTile(
                leading: Icon(
                  Icons.face,
                  size: 56.0,
                  color: kPrimaryColor,
                ),
                tileColor: kBackgroundColor,
                title: Text(
                  "username: $_currentUsername",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: kPrimaryColor),
                ),
              )),
          Flexible(
            child: SizedBox(
              height: 40,
            ),
          ),
          Flexible(
            child: Text(
              "Connected Socials",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: kPrimaryColor),
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Card(
              margin: EdgeInsets.all(5.0),
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
              margin: EdgeInsets.all(5.0),
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
          Flexible(
            child: SizedBox(
              height: 80,
            ),
          ),
          StyledButton(
              text: "Update username",
              onPressed: () =>
                  Navigator.pushNamed(context, ResetUsernameScreen.routeName)),
          // Expanded(child: Container(),),
          roomButtons(context),
          SizedBox(
            height: 20,
          ),
        ]),
        // ),
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
