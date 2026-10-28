import 'package:flutter/material.dart';

class Edgeinsets extends StatelessWidget {
  const Edgeinsets({super.key});

  Widget edgeBox(String text, Color color, EdgeInsets margin, double height) {
    return Container(
      height: height,
      margin: margin,
      color: color,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: color == Colors.blue || color == Colors.green
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title:Text('Cabarde_Activity 4'
        ),
      ),
      backgroundColor: Colors.purple.shade50,
      body: SafeArea(
        child: Column(
          children: [
            edgeBox(
              'EdgeInsets.all(30)',
              Colors.red,
              const EdgeInsets.all(30),
              60,
            ),
            edgeBox(
              'EdgeInsets.symmetric(horizontal: 40, vertical: 10)',
              Colors.yellow,
              const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              30,
            ),
            edgeBox(
              'EdgeInsets.only(left: 30, top: 10, right: 5, bottom: 20)',
              Colors.blue,
              const EdgeInsets.only(
                left: 30,
                top: 10,
                right: 5,
                bottom: 20,
              ),
              35,
            ),
            edgeBox(
              'EdgeInsets.fromLTRB(10, 20, 30, 40)',
              Colors.green,
              const EdgeInsets.fromLTRB(10, 20, 30, 40),
              60,
            ),
          ],
        ),
      ),
    );
  }
}