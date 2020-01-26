import 'package:flutter/material.dart';
import 'package:iOS_bundle_id/data/sources/search_api_client.dart';
import 'package:iOS_bundle_id/modules/search/view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

/// The root widget.
class App extends StatelessWidget {
  /// Creates a [App].
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iOS bundle id',
      home: Provider(
        create: (BuildContext context) => SearchApiClient(
          client: http.Client(),
        ),
        child: const SearchView(),
      ),
    );
  }
}
