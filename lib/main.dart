import 'dart:async';

import 'package:dashboard_functionality_tester/screens/homeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  // runZonedGuarded(() {
  //
  // }, (error, stack) {
  //   print("error from runZonedGuarded:  $error");
  //   print(stack);
  // });

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
      home: const HomeScreen(),
    );
  }
}
