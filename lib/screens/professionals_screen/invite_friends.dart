// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({Key key}) : super(key: key);

  @override
  _InviteFriendsState createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(
        "Invite a friend",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
