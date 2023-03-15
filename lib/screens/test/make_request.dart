// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/Identifiers.dart';
import 'package:online_panchayat_flutter/screens/test/getPostWithTags.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authenticationService.dart';
import 'package:provider/provider.dart';

class MakeRequest extends StatefulWidget {
  const MakeRequest({Key key}) : super(key: key);

  @override
  State<MakeRequest> createState() => _MakeRequestState();
}

class _MakeRequestState extends State<MakeRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            child: Text("init auth"),
            onPressed: () async {
              await Provider.of<AuthenticationService>(context, listen: false)
                  .initialiseAuthenticationService();
              print("cognito initialised");
            },
          ),
          TextButton(
            child: Text("MakeRequest"),
            onPressed: () async {
              // GetIdentifiers().createIdentifiers();
              Identifiers data = await GetIdentifiers().getIdentifiers(
                id: "3c59435d-fee6-462c-abe1-7a5b54ec544b",
              );
              // postId: "cf48a3d4-09ed-44d8-9c57-6a3df7f05f8f",
              // PostWithTags post = data.list[0] as PostWithTags;
              print(data.name);
            },
          ),
          // TextButton(
          //   child: Text("init auth"),
          //   onPressed: () {},
          // ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      // ),
    );
  }
}
