import 'package:joanneflutter1/model/usercomment.dart';

class Userpost {
  final String id;
  final String userImg;
  final String username;
  final String time;
  final String postcontent;
  final String? postimg;
  final String numshare;
  bool isLiked;
  List<Usercomment> comments;

  int get numcomments => comments.length;

  Userpost({
    required this.id,
    required this.userImg,
    required this.username,
    required this.time,
    required this.postcontent,
    this.postimg,
    required this.numshare,
    required this.isLiked,
    List<Usercomment>? comments,
  }) : comments = comments ?? [];
}
