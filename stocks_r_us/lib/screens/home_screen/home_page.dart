import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: <Widget>[
          // ignore: avoid_unnecessary_containers
          Container(
              child: Stack(children: [
            Container(
              padding: EdgeInsets.fromLTRB(15, 90, 0, 1),
              child: Text(
                'Get Started',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ]))
        ]));
  }
}
