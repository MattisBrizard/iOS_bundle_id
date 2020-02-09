import 'dart:html';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iOS_bundle_id/data/entities/application.dart';
import 'package:iOS_bundle_id/data/sources/search_api_client.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// The search view.
class SearchView extends StatelessWidget {
  /// Creates a [SearchView].
  SearchView({
    Key key,
  }) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Provider.value(
        value: _scaffoldKey,
        child: const _View(),
      ),
    );
  }
}

/// A widget.
class _View extends StatelessWidget {
  /// Creates a [_View].
  const _View({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold =
        Provider.of<GlobalKey<ScaffoldState>>(context, listen: false);

    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SearchBar<Application>(
                searchBarPadding:
                    EdgeInsets.symmetric(horizontal: size.width / 8),
                listPadding: EdgeInsets.symmetric(horizontal: size.width / 8),
                onSearch: Provider.of<SearchApiClient>(
                  context,
                  listen: false,
                ).searchApplications,
                debounceDuration: const Duration(seconds: 1),
                placeHolder: Center(
                  child: Container(
                    width: size.width / 2,
                    child: const Text(
                      'Find easily an iOS app bundle id.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                cancellationWidget: const Text('Clear'),
                emptyWidget: const Center(
                  child: Text('No applications found.'),
                ),
                onError: (e) {
                  return const Center(
                    child: Text('An error occured.'),
                  );
                },
                crossAxisCount: 1,
                onItemFound: (Application app, int index) {
                  return _AppItem(
                    app: app,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1DA1F2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 50,
                  height: 50,
                  child: FlatButton(
                    child: Image.asset('assets/images/twitter.png'),
                    onPressed: () => _launchURL(
                      'https://twitter.com/Tisboul',
                      scaffold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF813F),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 50,
                  height: 50,
                  child: FlatButton(
                    child: Image.asset('assets/images/bmc.png'),
                    onPressed: () => _launchURL(
                      'https://www.buymeacoffee.com/qNemCBRVY',
                      scaffold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget.
class _AppItem extends StatelessWidget {
  /// Creates a [_AppItem].
  const _AppItem({
    @required this.app,
    Key key,
  }) : super(key: key);
  final Application app;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          app.artworkUrl,
        ),
      ),
      title: Text(app.trackName),
      subtitle: Text(app.bundleId),
      trailing: app.averageUserRating != null
          ? Text('${app.averageUserRating} / 5')
          : null,
      onTap: () {
        Clipboard.setData(ClipboardData(text: app.bundleId)).then((_) {
          Provider.of<GlobalKey<ScaffoldState>>(context, listen: false)
              .currentState
              .showSnackBar(
                SnackBar(
                  content: const SizedBox(
                    height: 50,
                    child: Text('Bundle ID copied to clipboard !'),
                  ),
                  duration: const Duration(milliseconds: 1500),
                  backgroundColor: Colors.green,
                ),
              );
        }, onError: (e) {
          Provider.of<GlobalKey<ScaffoldState>>(context, listen: false)
              .currentState
              .showSnackBar(
                SnackBar(
                  content: const SizedBox(
                    height: 50,
                    child: Text('Error copying bundle ID to clipboard !'),
                  ),
                  duration: const Duration(milliseconds: 1500),
                  backgroundColor: Colors.red,
                ),
              );
        });
      },
    );
  }
}

Future _launchURL(String url, GlobalKey<ScaffoldState> scaffold) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    scaffold.currentState.showSnackBar(
      SnackBar(
        content: const SizedBox(
          height: 50,
          child: Text('An error occured while opening link.'),
        ),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: Colors.red,
      ),
    );
  }
}
