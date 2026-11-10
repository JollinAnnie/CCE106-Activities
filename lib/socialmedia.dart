import 'package:flutter/material.dart';
import 'package:joanneflutter1/model/userdata.dart';
import 'package:joanneflutter1/views/friendlist.dart';
import 'package:joanneflutter1/views/infoheader.dart';
import 'package:joanneflutter1/views/mainheader.dart';
import 'package:joanneflutter1/views/postlist.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  final UserData userdata = UserData();
  late final Future<void> _commentsReady;

  @override
  void initState() {
    super.initState();
    _commentsReady = userdata.loadComments();
  }

  var followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<void>(
        future: _commentsReady,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Could not load comments.'));
          }
          return ListView(
            children: [
              Mainheader(userdata: userdata),
              Infoheader(userdata: userdata),
              Friendlist(userdata: userdata),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(children: [Text('Posts', style: followTxtStyle)]),
              ),
              const SizedBox(height: 20),
              Postlist(userdata: userdata),
            ],
          );
        },
      ),
    );
  }
}
