import 'package:flutter/material.dart';

import 'pages/LoginPage/loginPage.dart';

void main() => runApp(ShowOfHands());

class ShowOfHands extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
