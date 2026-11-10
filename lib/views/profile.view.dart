import 'package:flutter/material.dart';
import 'package:joanneflutter1/model/usercomment.dart';
import 'package:joanneflutter1/model/userdata.dart';
import 'package:joanneflutter1/model/userpost.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
    required this.userPost,
    required this.userData,
  });

  final Userpost userPost;
  final UserData userData;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _commentController = TextEditingController();
  final _commentFocus = FocusNode();
  final _scrollController = ScrollController();
  bool _saving = false;

  Userpost get userPost => widget.userPost;
  UserData get userData => widget.userData;

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocus.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _submitComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty || _saving) return;
    setState(() => _saving = true);
    try {
      await userData.addComment(
        userPost,
        Usercomment(
          commenterImg: userData.myUserAccount.img,
          commenterName: userData.myUserAccount.name,
          commenterTime: 'Just now',
          commenterContent: content,
        ),
      );
      if (!mounted) return;
      _commentController.clear();
      _commentFocus.unfocus();
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not save comment. Please try again.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  var nametxtStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  var boldtxtStyle1 = const TextStyle(fontWeight: FontWeight.bold);
  static const commentActionStyle = TextStyle(
    fontSize: 12,
    color: Colors.black87,
  );

  var boldtxtStyle2 = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  Widget commenterline(Usercomment comment) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(comment.commenterImg),
          radius: 17,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.commenterName, style: boldtxtStyle1),
                      const SizedBox(height: 3),
                      Text(comment.commenterContent),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(comment.commenterTime, style: commentActionStyle),
                    const SizedBox(width: 12),
                    const Text('Like', style: commentActionStyle),
                    const SizedBox(width: 12),
                    const Text('Reply', style: commentActionStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget commenters(Userpost userPost) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Divider(color: Colors.grey),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Text('${userPost.numcomments} Comments', style: boldtxtStyle1),
          ],
        ),
      ),
      const SizedBox(height: 15),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Text('All Comments', style: boldtxtStyle1),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    ],
  );

  Widget buttons(Userpost userPost) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Divider(color: Colors.grey),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: userPost.isLiked ? Colors.blue : Colors.grey,
              ),
              onPressed: () =>
                  setState(() => userPost.isLiked = !userPost.isLiked),
              icon: const Icon(Icons.thumb_up, size: 20),
              label: const Text('Like'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () => _commentFocus.requestFocus(),
              icon: const Icon(Icons.chat_bubble, size: 20),
              label: const Text('Comment'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () {},
              icon: const Icon(Icons.share, size: 20),
              label: const Text('Share'),
            ),
          ],
        ),
      ),
    ],
  );

  Widget userline(Userpost userPost) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(width: 10),
      CircleAvatar(backgroundImage: AssetImage(userPost.userImg), radius: 20),
      const SizedBox(width: 8),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userPost.username, style: nametxtStyle),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(userPost.time),
                const SizedBox(width: 4),
                const Icon(Icons.group, size: 15, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  Widget postimage(Userpost userPost) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userPost.postcontent),
        const SizedBox(height: 15),
        if (userPost.postimg != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              userPost.postimg!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
      ],
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
        ),
      ),
      body: ListView(
        controller: _scrollController,
        padding: EdgeInsets.zero,
        children: [
          userline(userPost),
          postimage(userPost),
          buttons(userPost),
          commenters(userPost),
          ...userPost.comments.map(commenterline),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  focusNode: _commentFocus,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _submitComment(),
                  decoration: const InputDecoration(
                    hintText: 'Write a comment',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                onPressed: _saving ? null : _submitComment,
                icon: const Icon(Icons.send),
                tooltip: 'Post comment',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
