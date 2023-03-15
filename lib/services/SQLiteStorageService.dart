// ignore_for_file: file_names
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:online_panchayat_flutter/models/notificationModel.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

// final String notificationTableName = 'notifications';
// final String columnId = 'id';
// final String columnEventType = 'eventType';
// final String columnUserName = 'userName';
// final String columnUserImage = 'userImage';
// final String columnUserId = 'userId';
// final String columnPostId = 'postId';
// final String columnpostContent = 'postContent';
// final String columnCommentText = 'commentText';
// final String columnReactionType = 'reactionType';
// final String columnReadStatus = 'readStatus';

// class SQLiteStorageService {
//   static Database _database;
//   static SQLiteStorageService _sqLiteStorageService;

//   SQLiteStorageService._createInstance();
//   factory SQLiteStorageService() {
//     if (_sqLiteStorageService == null) {
//       _sqLiteStorageService = SQLiteStorageService._createInstance();
//     }
//     return _sqLiteStorageService;
//   }

//   Future<Database> get database async {
//     if (_database == null) {
//       _database = await initializeDatabase();
//     }
//     return _database;
//   }

//   Future<Database> initializeDatabase() async {
//     var dir = await getDatabasesPath();
//     var path = dir + "panchayat.db";

//     var database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
//           create table $notificationTableName ( 
//           $columnId integer primary key autoincrement, 
//           $columnPostId text not null,
//           $columnUserId text not null,
//           $columnEventType text,
//           $columnUserName text,
//           $columnUserImage text,
//           $columnpostContent text,
//           $columnCommentText text,
//           $columnReadStatus integer,
//           $columnReactionType text)
//         ''');
//       },
//     );
//     return database;
//   }

//   Future<void> insertNotification({Map<String, dynamic> data}) async {
//     try {
//       var db = await this.database;
//       var result = await db.insert(notificationTableName, data);
//       print('result : $result');
//     } catch (e, s) {
//       FirebaseCrashlytics.instance.recordError(e, s);

//       print(e);
//     }
//   }

//   Future<List<NotificationModel>> getNotifications() async {
//     List<NotificationModel> _notificationList = [];

//     var db = await this.database;
//     var result = await db.query(notificationTableName, orderBy: columnId);
//     result = List.from(result.reversed);
//     result.forEach((element) {
//       if (_notificationList.length != 30) {
//         var notificationModel = NotificationModel.fromMap(element);
//         _notificationList.add(notificationModel);
//       } else {
//         deleteNotificationForTheRespectiveId(id: element['id']);
//       }
//     });
//     // _notificationList.reversed;
//     return _notificationList;
//   }

//   Future<dynamic> markNotificationsasRead({String postId}) async {
//     var db = await this.database;

//     await db.update(notificationTableName, {columnReadStatus: 1},
//         where: '$columnPostId = ?', whereArgs: [postId]);
//   }

//   Future<void> deleteOldNotificationsForTheRespectivePost(
//       {String postId}) async {
//     var db = await this.database;
//     await db.delete(notificationTableName,
//         where: '$columnPostId = ?', whereArgs: [postId]);
//     return;
//   }

//   Future<void> deleteNotificationForTheRespectiveId({int id}) async {
//     var db = await this.database;
//     await db
//         .delete(notificationTableName, where: '$columnId = ?', whereArgs: [id]);
//     return;
//   }
// }
