import 'package:flutter/material.dart';
import 'package:joanneflutter1/pavlova.dart';
import 'package:joanneflutter1/edgeinsets.dart';
import 'package:joanneflutter1/mainalignment.dart';
import 'package:joanneflutter1/crossalignment.dart';
import 'package:joanneflutter1/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
}

