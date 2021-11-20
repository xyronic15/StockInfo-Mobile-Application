import 'package:flutter/material.dart';
import 'package:stocks_r_us/screens/welcome_screen/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stocks R Us',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const WelcomePage(),
    );
  }
}
