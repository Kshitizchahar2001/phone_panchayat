// ignore_for_file: file_names, annotate_overrides

/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'Comment.dart';
import 'FollowRelationships.dart';
import 'Reactions.dart';
import 'User.dart';
import 'View.dart';

export 'Comment.dart';
export 'FollowRelationships.dart';
export 'Gender.dart';
export 'PostContentType.dart';
export 'PostType.dart';
export 'ReactionTypes.dart';
export 'Reactions.dart';
export 'Status.dart';
export 'User.dart';
export 'View.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "beb11cea3528f8078630c7ca8efc037d";
  @override
  List<ModelSchema> modelSchemas = [
    Comment.schema,
    FollowRelationships.schema,
    Reactions.schema,
    User.schema,
    View.schema
  ];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;

  ModelType getModelTypeByModelName(String modelName) {
    switch (modelName) {
      case "Comment":
        {
          return Comment.classType;
        }
        break;
      case "FollowRelationships":
        {
          return FollowRelationships.classType;
        }
        break;
      case "Reactions":
        {
          return Reactions.classType;
        }
        break;
      case "User":
        {
          return User.classType;
        }
        break;
      case "View":
        {
          return View.classType;
        }
        break;
      default:
        {
          throw Exception(
              "Failed to find model in model provider for model name: " +
                  modelName);
        }
    }
  }
  
  @override
  List<ModelSchema> customTypeSchemas;
}
