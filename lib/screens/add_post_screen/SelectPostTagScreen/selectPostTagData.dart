// ignore_for_file: file_names, duplicate_ignore, avoid_function_literals_in_foreach_calls

// ignore_for_file: file_names

import 'package:online_panchayat_flutter/firestoreModels/postTag.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectPostTagData {
  //   List<String> newsTags = [
  //   "क्राइम",
  //   "सियासत",
  //   "प्रशासन",
  //   "दुर्घटना",
  //   "कोरोना",
  //   "etc",
  //   "etc",
  //   "etc",
  //   "etc",
  // ];

  static List<PostTag> availablePostTags;

  Future<List<PostTag>> getPostTags() async =>
      availablePostTags ?? await fetchPostTags();

  Future<List<PostTag>> fetchPostTags() async {
    await FirebaseFirestore.instance
        .collection('postTags')
        .get()
        .then((postTags) {
      availablePostTags = [];
      postTags.docs.forEach((postTag) {
        PostTag postTagObject = PostTag.fromJson(postTag.data());
        if (postTagObject.en != null) availablePostTags.add(postTagObject);
      });
    });
    return availablePostTags;
  }

  get getAvailablePostTags => availablePostTags;
}
