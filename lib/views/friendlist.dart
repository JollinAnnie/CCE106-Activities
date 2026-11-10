import 'package:flutter/material.dart';
import 'package:joanneflutter1/model/friend.dart';
import 'package:joanneflutter1/model/userdata.dart';

class Friendlist extends StatelessWidget {
  const Friendlist({super.key, required this.userdata});

  final UserData userdata;

  static const titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  Widget friend(Friend friend) => Card(
    child: Column(
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
              child: Image.asset(
                friend.img,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            friend.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );

  Widget friendListGrid() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisExtent: 160,
    ),
    itemCount: userdata.friendList.length,
    itemBuilder: (BuildContext ctx, index) {
      return friend(userdata.friendList[index]);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Friends', style: titleStyle),
                const SizedBox(height: 2),
                Text('${userdata.friendList.length} Friends'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        friendListGrid(),
        SizedBox(height: 10, child: Container(color: Colors.grey)),
      ],
    );
  }
}
