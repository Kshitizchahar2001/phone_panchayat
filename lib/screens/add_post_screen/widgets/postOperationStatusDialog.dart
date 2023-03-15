// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/widgets/OperationCompletionStatusDialog.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class PostCreationStatusDialog extends StatelessWidget {
  final String postId;
  const PostCreationStatusDialog({
    Key key,
    @required this.wasOperationSuccessful,
    @required this.postId,
  }) : super(key: key);

  final bool wasOperationSuccessful;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
            padding: getPostWidgetSymmetricPadding(context, horizontal: 8),
            child: (postId == null)
                ? OperationCompletionStatusDialog(
                    heading: wasOperationSuccessful
                        ? POST_CREATION_SUCCESSFUL_HEADING
                        : POST_CREATION_FAILED_HEADING,
                    subheading: wasOperationSuccessful
                        ? POST_CREATION_SUCCESSFUL_SUBHEADING
                        : POST_CREATION_FAILED_SUBHEADING,
                  )
                : OperationCompletionStatusDialog(
                    heading: wasOperationSuccessful
                        ? POST_EDIT_SUCCESSFUL_HEADING
                        : POST_EDIT_FAILED_HEADING,
                    subheading: wasOperationSuccessful
                        ? POST_EDIT_SUCCESSFUL_SUBHEADING
                        : POST_EDIT_FAILED_SUBHEADING,
                  )),
      ),
    );
  }
}
