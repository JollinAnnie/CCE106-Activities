import 'package:flutter/material.dart';
import 'package:joanneflutter1/model/userdata.dart';
import 'package:joanneflutter1/model/userpost.dart';
import 'package:joanneflutter1/views/profile.view.dart';

class Postlist extends StatefulWidget {
  const Postlist({super.key, required this.userdata});

  final UserData userdata;
  @override
  State<Postlist> createState() => _PostlistState();
}

class _PostlistState extends State<Postlist> {
  var nametxtStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  Future<void> openPost(Userpost post) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) =>
            ProfileView(userPost: post, userData: widget.userdata),
      ),
    );
    if (mounted) setState(() {});
  }

  Widget buttons(Userpost userPost) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: (userPost.isLiked) ? Colors.blue : Colors.grey,
        ),
        onPressed: () {
          setState(() {
            userPost.isLiked = (userPost.isLiked) ? false : true;
          });
        },
        icon: const Icon(Icons.thumb_up),
        label: const Text('Like'),
      ),
      TextButton.icon(
        style: TextButton.styleFrom(foregroundColor: Colors.grey),
        onPressed: () => openPost(userPost),
        icon: const Icon(Icons.message),
        label: const Text('Comment'),
      ),
      TextButton.icon(
        style: TextButton.styleFrom(foregroundColor: Colors.grey),
        onPressed: () {},
        icon: const Icon(Icons.share),
        label: const Text('Share'),
      ),
    ],
  );

  Widget postCount(Userpost userPost) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text('${userPost.numcomments} Comments'),
      const Text(''),
      const SizedBox(width: 20),
      Text('${userPost.numshare} Shares'),
    ],
  );

  Widget postImage(Userpost userPost) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      width: double.infinity,
      height: 350,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(userPost.postimg!),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );

  Widget postHeader(Userpost userPost) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(userPost.userImg),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(userPost.username, style: nametxtStyle),
          Row(
            children: [
              Text('${userPost.time} . '),
              const Icon(Icons.people, size: 18),
            ],
          ),
        ],
      ),
    ],
  );

  Widget commenterline(Userpost userPost) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      postHeader(userPost),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(userPost.postcontent, style: nametxtStyle),
      ),
      if (userPost.postimg != null) postImage(userPost),
      postCount(userPost),
      const Divider(),
      buttons(userPost),
      SizedBox(height: 10, child: Container(color: Colors.grey)),
      const SizedBox(height: 15),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: widget.userdata.userList.map((userPost) {
        return InkWell(
          onTap: () {
            openPost(userPost);
          },
          child: commenterline(userPost),
        );
      }).toList(),
    );
  }
}
