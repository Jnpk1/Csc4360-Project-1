import 'package:flutter/material.dart';
import 'package:memoclub/screens/home.dart';
import 'package:memoclub/screens/profile.dart';
import 'package:memoclub/screens/settings.dart';
import 'package:memoclub/screens/styles/colors.dart';

Widget memoDrawer(BuildContext context) {
  return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      
      child: ListView(

          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Text(
            'Quick Actions',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: kOnPrimaryColor),
          ),
        ),
        ListTile(
          title: Text('Settings'),
          leading: Icon(Icons.settings),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
            Navigator.pushNamed(context, SettingsPage.routeName);
          },
        ),
        ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.face),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.pushNamed(context, Profile.routeName);
            }),
        ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.pushNamed(context, Home.routeName);
            })
      ]));
}
