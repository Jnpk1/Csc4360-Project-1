import 'package:flutter/material.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/screens/styles/colors.dart';
import 'package:memoclub/shared/appbar.dart';
import 'package:memoclub/shared/drawer.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  static final String routeName = 'settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: memoAppBar(context, "Settings"),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: roomButtons(context),
      ),
      drawer: memoDrawer(context),
    );
  }
}
