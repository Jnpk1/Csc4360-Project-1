import 'package:flutter/material.dart';
import 'package:memoclub/screens/styles/colors.dart';

const textInputDecoration = InputDecoration(
    fillColor: kFormColor,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kBackgroundColor, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
    ));
