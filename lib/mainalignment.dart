import 'package:flutter/material.dart';

class MainAlignment extends StatelessWidget {
  const MainAlignment({super.key});

  @override
  Widget build(BuildContext context) {

    // Start
    // const alignment = MainAxisAlignment.start;

    // Center
    // const alignment = MainAxisAlignment.center;

    // Space Around
    // const alignment = MainAxisAlignment.spaceAround;

    // Space Between
    // const alignment = MainAxisAlignment.spaceBetween;

    // Space Evenly
    // const alignment = MainAxisAlignment.spaceEvenly;

    // End
    const alignment = MainAxisAlignment.end;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Joanne Cabarde - Activity 5'),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.purple.shade50,

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'MainAxisAlignment.${alignment.name}',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: alignment,
              children: [
                Container(width: 70, height: 70, color: Colors.red),
                Container(width: 70, height: 70, color: Colors.yellow),
                Container(width: 70, height: 70, color: Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}