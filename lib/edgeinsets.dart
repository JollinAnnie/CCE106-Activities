import 'package:flutter/material.dart';

class Edgeinsets extends StatelessWidget {
  const Edgeinsets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joanne Cabarde - Activity 4'),
      ),
      body: Center(
        child: Column(
          children: [

            // EdgeInsets.all()
            Container(
              color: Colors.grey[300],
              child: Container(
                padding: EdgeInsets.all(30),
                color: Colors.red,
                child: Text('EdgeInSets.all(30)'),
              ),
            ),

            const SizedBox(height: 30),
            // EdgeInsets.symmetric()
            Container(
              color: Colors.grey[300],
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                color: Colors.yellow,
                child: Text('EdgeInSets.symmetric(horizontal: 40, vertical: 10)'),
              ),
            ),

            const SizedBox(height: 30),
            // EdgeInsets.only()
            Container(
              color: Colors.grey[300],
              child: Container(
                padding: EdgeInsets.only(left: 10, top: 10, right: 5, bottom: 20),
                color: Colors.blue,
                child: Text('EdgeInSets.only(left: 10, top: 10, right: 5, bottom: 20)',
                    style: TextStyle(color: Colors.white)),
              ),
            ),

            const SizedBox(height: 30),
            // EdgeInsets.LTRB()
            Container(
              color: Colors.grey[300],
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 20, 30, 40),
                color: Colors.green,
                child: Text('EdgeInSets.fromLTRB(10, 20, 30, 40)',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}