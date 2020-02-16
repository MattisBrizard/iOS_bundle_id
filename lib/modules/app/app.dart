import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:iOS_bundle_id/core/app_analytics.dart';
import 'package:iOS_bundle_id/data/sources/search_api_client.dart';
import 'package:iOS_bundle_id/modules/search/view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase/firebase.dart';

/// The root widget.
class App extends StatelessWidget {
  /// Creates a [App].
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bundle ID finder',
      home: MultiProvider(
        providers: [
          Provider(
            create: (BuildContext context) => SearchApiClient(
              client: http.Client(),
            ),
          ),
          Provider(
            create: (_) => AppAnalytics(analytics: analytics())..logAppOpen(),
          ),
        ],
        child: SearchView(),
      ),
    );
  }
}
