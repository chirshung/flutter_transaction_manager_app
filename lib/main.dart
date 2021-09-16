import 'package:flutter/material.dart';
import 'MyApp.dart';

// void main() {
//   runApp(MyApp());
// }

void main() {
  runApp(new MaterialApp(
    title: 'Transaction Manager',
    theme: ThemeData(
      primaryColor: Colors.deepOrangeAccent,
      accentColor: Colors.lightGreenAccent,
    ),
    home: MyApp(),
  ));
}


