// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefData extends StatelessWidget {
  Future<List<Widget>> getAllPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .getKeys()
        .map<Widget>((key) => ListTile(
              title: Text(key),
              subtitle: Text(
                prefs.get(key).toString(),
                style: TextStyle(color: Colors.grey),
              ),
            ))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Widget>>(
          future: getAllPrefs(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            return ListView(
              children: snapshot.data,
            );
          }),
    );
  }
}
