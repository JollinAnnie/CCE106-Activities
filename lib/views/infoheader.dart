import 'package:flutter/material.dart';
import 'package:joanneflutter1/model/userdata.dart';

class Infoheader extends StatelessWidget {
  const Infoheader({super.key, required this.userdata});

  final UserData userdata;

  static const followTxtStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  Widget stat(String label, String value) => Expanded(
    child: Column(
      children: [
        Text(label, textAlign: TextAlign.center),
        const SizedBox(height: 4),
        Text(value, style: followTxtStyle, textAlign: TextAlign.center),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              stat('Followers', userdata.myUserAccount.numFollowers),
              stat('Following', userdata.myUserAccount.numFollowing),
              stat('Posts', userdata.myUserAccount.numPosts),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Divider(color: Colors.grey),
      ],
    );
  }
}
