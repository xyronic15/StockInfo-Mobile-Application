// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stocks_r_us/screens/welcome_screen/welcome.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

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
            Container(
              padding: EdgeInsets.fromLTRB(15, 140, 10, 10),
              child: Text(
                'Enter Info Below',
                style: TextStyle(fontSize: 45, color: Colors.greenAccent[400]),
              ),
            ),
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(30, 215, 50, 0),
                        child: Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              TextField(
                                  decoration: InputDecoration(
                                labelText: 'First Name',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              )),
                              TextField(
                                  decoration: InputDecoration(
                                labelText: 'Last Name',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              )),
                              TextField(
                                  decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              )),
                              TextField(
                                  decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              )),
                              TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: (TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)),
                                  )),
                              Container(
                                height: 80,
                                padding: EdgeInsets.only(top: 30),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  shadowColor: Colors.greenAccent,
                                  color: Colors.green,
                                  elevation: 5.0,
                                  child: GestureDetector(
                                      onTap: () {},
                                      child: Center(
                                          child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ))),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(top: 80)),
                                  Text('Have an account already? ',
                                      style: TextStyle(fontSize: 15)),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WelcomePage()));
                                    },
                                    child: Text('Login',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                  )
                                ],
                              )
                            ]))
                  ]),
            )
          ]))
        ]));
  }
}
