// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Review {
  Review({
    @required this.comment,
    @required this.rating,
    @required this.userName,
    @required this.id,
  });

  final String comment;
  final int rating;
  final String userName;
  final String id;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        comment: json["comment"],
        rating: json["rating"],
        userName: json["userName"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "rating": rating,
        "userName": userName,
        "id": id,
      };
}
