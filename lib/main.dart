import 'package:dashboard_functionality_tester/screens/homeScreen.dart';
import 'package:dashboard_functionality_tester/screens/test_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        "/testScreen" : (context) => const TestScreen(),

      },
    );
  }
}
