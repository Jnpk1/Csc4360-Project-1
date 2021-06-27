import 'package:flutter/material.dart';

// Generic Loading Symbol. Subject to change.
class LoadingCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(
          backgroundColor: Colors.blue,
        ),
        alignment: Alignment(0.0, 0.0),
      ),
    );
  }
}
