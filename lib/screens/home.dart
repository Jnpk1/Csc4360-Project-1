import 'package:flutter/material.dart';
import 'package:memoclub/screens/register.dart';
import 'package:memoclub/screens/sign_in.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  static final String routeName = '/home';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  int _counter = 0;

  void _sendToRegisterPage() {
    Navigator.pushNamed(context, Register.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendToRegisterPage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
