import 'package:flutter/material.dart';

class CrossAlignment extends StatelessWidget {
  const CrossAlignment({super.key});

  @override
  Widget build(BuildContext context) {
    //start
    // const alignment = CrossAxisAlignment.start;

    //center
    // const alignment = CrossAxisAlignment.center;

    //end
    const alignment = CrossAxisAlignment.end;

    //stretch
    // const alignment = CrossAxisAlignment.stretch;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Joanne Cabarde - Activity 5'),
      ),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'CrossAxisAlignment.${alignment.name}',
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: alignment,
                children: [
                  Container(width: 70, height: 70, color: Colors.red),
                  Container(width: 70, height: 70, color: Colors.yellow),
                  Container(width: 70, height: 70, color: Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}