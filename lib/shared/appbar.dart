import 'package:flutter/material.dart';
import 'package:memoclub/screens/styles/colors.dart';

PreferredSizeWidget memoAppBar(BuildContext context, String appBarTitle) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    // leading: logo(context),
    title: Text(
      appBarTitle,
      style: Theme.of(context)
          .textTheme
          .headline3
          ?.copyWith(color: kOnPrimaryColor),
    ),
  );
}

Widget logo(BuildContext context) {
  return Container(
      margin: EdgeInsets.fromLTRB(2, 3, 2, 3),
      child: Text(
        'mc',
        style: Theme.of(context)
            .textTheme
            .headline3
            ?.copyWith(color: kOnPrimaryColor),
      ));
}
