import 'dart:convert';

import 'package:joanneflutter1/model/account.dart';
import 'package:joanneflutter1/model/friend.dart';
import 'package:joanneflutter1/model/usercomment.dart';
import 'package:joanneflutter1/model/userpost.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  List<Userpost> userList = [
    Userpost(
      id: 'beach-day',
      userImg: 'assets/person1.jpg',
      username: 'John Doe',
      time: '2 hours ago',
      postcontent: 'Had a great day at the beach!',
      postimg: 'assets/pavlova.jpg',
      numshare: '5',
      isLiked: true,
      comments: [
        Usercomment(
          commenterImg: 'assets/person2.jpg',
          commenterName: 'Jane Smith',
          commenterTime: '6 hrs',
          commenterContent: 'Wow Beautiful!',
        ),
        Usercomment(
          commenterImg: 'assets/person3.jpg',
          commenterName: 'Kenneth Vladimir',
          commenterTime: '2 hrs',
          commenterContent: 'Wow Beautiful!',
        ),
        Usercomment(
          commenterImg: 'assets/person4.jpg',
          commenterName: 'Miko Rojo',
          commenterTime: '8 hrs',
          commenterContent: 'Wow Beautiful!',
        ),
      ],
    ),
    Userpost(
      id: 'new-cafe',
      userImg: 'assets/person2.jpg',
      username: 'Jane Smith',
      time: '3 hours ago',
      postcontent: 'Lovin the new cafe in town',
      numshare: '3',
      isLiked: true,
    ),
    Userpost(
      id: 'morning-run',
      userImg: 'assets/person3.jpg',
      username: 'Mike Johnson',
      time: '5 hours ago',
      postcontent: 'Just finish 10km in 5 mins!',
      numshare: '20',
      isLiked: true,
    ),
    Userpost(
      id: 'sunset',
      userImg: 'assets/person4.jpg',
      username: 'Emily Davis',
      time: '1 day ago',
      postcontent: 'Enjoying the sunset at the beach',
      numshare: '8',
      isLiked: true,
    ),
  ];
  List<Friend> friendList = [
    Friend(img: 'assets/person2.jpg', name: 'Alice'),
    Friend(img: 'assets/person1.jpg', name: 'Bob'),
    Friend(img: 'assets/person3.jpg', name: 'Charlie'),
    Friend(img: 'assets/person4.jpg', name: 'Diana'),
    Friend(img: 'assets/person5.jpg', name: 'Ethan'),
    Friend(img: 'assets/person6.jpg', name: 'Michael'),
  ];

  static const _commentsKey = 'post_comments_v1';

  Future<void> loadComments() async {
    final preferences = await SharedPreferences.getInstance();
    final stored = preferences.getString(_commentsKey);
    if (stored == null) return;

    final saved = jsonDecode(stored) as Map<String, dynamic>;
    for (final post in userList) {
      final comments = saved[post.id];
      if (comments is List) {
        post.comments = comments
            .map((item) => Usercomment.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    }
  }

  Future<void> addComment(Userpost post, Usercomment comment) async {
    post.comments.add(comment);
    try {
      final preferences = await SharedPreferences.getInstance();
      final commentsByPost = {
        for (final item in userList)
          item.id: item.comments.map((comment) => comment.toJson()).toList(),
      };
      final saved = await preferences.setString(
        _commentsKey,
        jsonEncode(commentsByPost),
      );
      if (!saved) throw StateError('Could not save the comment.');
    } catch (_) {
      post.comments.remove(comment);
      rethrow;
    }
  }

  Account myUserAccount = Account(
    name: 'Joanne Faith Cabarde',
    email: 'joannefaithcabarde@gmail.com',
    img: 'assets/person2.jpg',
    numFollowers: '15',
    numPosts: '350',
    numFollowing: '150',
    numFriends: '50',
  );
}
