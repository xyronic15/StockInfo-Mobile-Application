// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:stocks_r_us/screens/home_screen/home_page.dart';
import 'package:stocks_r_us/screens/signup_screen/signup_page.dart';
import 'login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController =
        // ignore: unnecessary_new
        new TextEditingController();
    final TextEditingController passwordController =
        // ignore: unnecessary_new
        new TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            // ignore: avoid_unnecessary_containers
            Container(
              child: Stack(
                children: [
                  Container(
                    // ignore: prefer_const_constructors
                    padding: EdgeInsets.fromLTRB(15, 150, 0, 1),
                    child: Text(
                      'Welcome to',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 195, 10, 10),
                    child: Text(
                      'Stocks R Us',
                      style: TextStyle(
                          fontSize: 50, color: Colors.greenAccent[400]),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(30, 350, 50, 0),
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                TextField(
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    )),
                                TextField(
                                    obscureText: true,
                                    controller: passwordController,
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
                                        onTap: () {
                                          userLogin(
                                                  usernameController.text
                                                      .toString(),
                                                  passwordController.text
                                                      .toString())
                                              .then((result) {
                                            if (result.statusCode != 400) {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) => HomePage(
                                                          username:
                                                              usernameController
                                                                  .text
                                                                  .toString())));
                                            } else {
                                              print(result.message);
                                              // TODO handle error
                                            }
                                          });
                                        },
                                        child: Center(
                                            child: Text(
                                          'Login',
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
                                    Text('New to our service? ',
                                        style: TextStyle(fontSize: 15)),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignupPage()));
                                      },
                                      child: Text('Sign Up',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
