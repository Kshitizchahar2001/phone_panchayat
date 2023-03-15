// ignore_for_file: file_names

import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  SnackBar snackBar = SnackBar(
    content: Text(text.toString()),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
