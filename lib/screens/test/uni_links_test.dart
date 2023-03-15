// ignore_for_file: unnecessary_import, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, unnecessary_overrides, avoid_print, unnecessary_string_interpolations

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

bool _initialUriIsHandled = false;

class MyUniLinkApp extends StatefulWidget {
  MyUniLinkApp({Key key}) : super(key: key);
  @override
  _MyUniLinkAppState createState() => _MyUniLinkAppState();
}

class _MyUniLinkAppState extends State<MyUniLinkApp>
    with SingleTickerProviderStateMixin {
  Uri _initialUri;
  Uri _latestUri;
  Object _err;
  var queryParams;

  @override
  void initState() {
    super.initState();
    _handleInitialUri();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Handle incoming links - the ones that the app will recieve from the OS
  /// while already started.

  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  ///
  /// We handle all exceptions, since it is called from initState.
  Future<void> _handleInitialUri() async {
    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      _showSnackBar('_handleInitialUri called');
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
        }
        if (!mounted) return;
        setState(
          () {
            _initialUri = uri;
            queryParams = _initialUri?.queryParametersAll?.entries?.toList();
          },
        );
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri');
        setState(() => _err = err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('uni_links example app'),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        children: [
          if (_err != null)
            ListTile(
              title: const Text('Error', style: TextStyle(color: Colors.red)),
              subtitle: Text('$_err'),
            ),
          ListTile(
            title: const Text('Initial Uri'),
            subtitle: Text('$_initialUri'),
          ),
          ListTile(
            title: const Text('Latest Uri'),
            subtitle: Text('$_latestUri'),
          ),
          ListTile(
            title: const Text('Initial Uri (path)'),
            subtitle: Text('${_initialUri?.path}'),
          ),
          ExpansionTile(
            initiallyExpanded: true,
            title: const Text('Initial Uri (query parameters)'),
            children: queryParams == null
                ? const [ListTile(dense: true, title: Text('null'))]
                : [
                    for (final item in queryParams)
                      ListTile(
                        title: Text(item.key),
                        trailing: Text(item.value.join(', ')),
                      )
                  ],
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String msg) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final context = _scaffoldKey.currentContext;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
        ));
      }
    });
  }
}
