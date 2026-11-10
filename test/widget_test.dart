// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:joanneflutter1/auth/login.dart';
import 'package:joanneflutter1/model/userdata.dart';
import 'package:joanneflutter1/socialmedia.dart';
import 'package:joanneflutter1/views/infoheader.dart';
import 'package:joanneflutter1/views/postlist.dart';
import 'package:joanneflutter1/views/profile.view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('post text starts left and detail header stays in one row', (
    tester,
  ) async {
    final data = UserData();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(children: [Postlist(userdata: data)]),
        ),
      ),
    );

    final content = find.text('Had a great day at the beach!');
    expect(tester.getTopLeft(content).dx, lessThan(20));

    await tester.tap(find.text('John Doe'));
    await tester.pumpAndSettle();

    final avatar = tester.getRect(find.byType(CircleAvatar).first);
    final name = tester.getRect(find.text('John Doe'));
    final time = tester.getRect(find.text('2 hours ago'));
    expect(name.left, greaterThan(avatar.right));
    expect((time.left - name.left).abs(), lessThan(1));
    expect(tester.getTopLeft(content).dx, lessThan(20));
    expect(tester.takeException(), isNull);
  });

  testWidgets('login shows errors for empty username and password', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(home: LoginForm()));

    await tester.tap(find.text('LOGIN'));
    await tester.pump();
    expect(find.text('Please input your username!'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'Joanne');
    await tester.tap(find.text('LOGIN'));
    await tester.pump();
    expect(find.text('Please input your password!'), findsOneWidget);

    await tester.enterText(find.byType(TextField).last, '   ');
    await tester.tap(find.text('LOGIN'));
    await tester.pump();
    expect(find.text('Please input your password!'), findsOneWidget);

    await tester.enterText(find.byType(TextField).last, 'password');
    await tester.tap(find.text('LOGIN'));
    await tester.pumpAndSettle();
    expect(find.text('Please input your password!'), findsNothing);
    expect(find.text('Followers'), findsOneWidget);
  });

  testWidgets('info header labels align with their numbers', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: Infoheader(userdata: UserData())),
      ),
    );

    for (final pair in [
      ('Followers', '15'),
      ('Following', '150'),
      ('Posts', '350'),
    ]) {
      final labelCenter = tester.getCenter(find.text(pair.$1)).dx;
      final valueCenter = tester.getCenter(find.text(pair.$2)).dx;
      expect((labelCenter - valueCenter).abs(), lessThan(1));
    }
  });

  testWidgets('feed scrolls through friends into posts without layout errors', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(home: SocialMedia()));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Posts'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Posts'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('comment is shown and saved only on its post', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final data = UserData();
    final post = data.userList[1];

    await tester.pumpWidget(
      MaterialApp(
        home: ProfileView(userPost: post, userData: data),
      ),
    );
    await tester.enterText(find.byType(TextField), 'A new comment');
    await tester.tap(find.byTooltip('Post comment'));
    await tester.pumpAndSettle();

    expect(post.numcomments, 1);
    expect(find.text('A new comment'), findsOneWidget);
    final bubble = tester.widget<Container>(
      find
          .ancestor(
            of: find.text('A new comment'),
            matching: find.byType(Container),
          )
          .first,
    );
    expect((bubble.decoration! as BoxDecoration).color, Colors.grey.shade200);
    expect(
      tester.getTopLeft(find.text('Reply')).dy,
      greaterThan(tester.getBottomLeft(find.text('A new comment')).dy),
    );
    expect(data.userList[2].numcomments, 0);

    final reloaded = UserData();
    await reloaded.loadComments();
    expect(
      reloaded.userList[1].comments.single.commenterContent,
      'A new comment',
    );
    expect(reloaded.userList[2].comments, isEmpty);
  });
}
