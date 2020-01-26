import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:iOS_bundle_id/data/entities/application.dart';
import 'package:iOS_bundle_id/data/sources/search_api_client.dart';
import 'package:provider/provider.dart';

/// The search view.
class SearchView extends StatelessWidget {
  /// Creates a [SearchView].
  const SearchView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _View(),
    );
  }
}

/// A widget.
class _View extends StatefulWidget {
  /// Creates a [_View].
  const _View({
    Key key,
  }) : super(key: key);

  @override
  __ViewState createState() => __ViewState();
}

class __ViewState extends State<_View> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SearchBar<Application>(
        searchBarPadding: EdgeInsets.symmetric(horizontal: size.width / 8),
        listPadding: EdgeInsets.symmetric(horizontal: size.width / 8),
        onSearch: Provider.of<SearchApiClient>(
          context,
          listen: false,
        ).searchApplications,
        debounceDuration: const Duration(seconds: 1),
        placeHolder: const Center(
          child: Text('placeholder'),
        ),
        cancellationWidget: const Text('Clear'),
        emptyWidget: const Text("empty"),
        onCancelled: () {
          print("Cancelled triggered");
        },
        onError: (e) {
          return Text('error triggerrd');
        },
        crossAxisCount: 2,
        onItemFound: (Application app, int index) {
          return ListTile(
            leading: Image.network(app.artworkUrl),
            title: Text(app.trackName),
            subtitle: Text(app.bundleId),
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => Detail()));
            },
          );
        },
      ),
    );
  }
}
