// ignore_for_file: file_names

// class RunMutation {
//   static AuthenticationService authenticationService;
//   SigV4Request signedRequest;

//   Future<http.Response> runMutation(
//       {@required String operationName,
//       @required String mutationDocument,
//       @required Map<String, dynamic> variables}) async {
//     final signedRequest = new SigV4Request(
//       authenticationService.awsSigV4Client,
//       method: 'POST',
//       path: '/graphql',
//       headers: new Map<String, String>.from(
//           {'Content-Type': 'application/graphql; charset=utf-8'}),
//       body: {
//         'operationName': operationName,
//         'query': mutationDocument,
//         'variables': jsonEncode(variables)
//       },
//     );

//     http.Response response;
//     try {
//       response = await http.post(Uri.parse(signedRequest.url),
//           headers: signedRequest.headers, body: signedRequest.body);
//     } catch (e, s) {
//       FirebaseCrashlytics.instance.recordError(e, s);
//     }

//     return response;
//   }
// }
