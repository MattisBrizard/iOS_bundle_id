import 'package:iOS_bundle_id/core/app_consts.dart';
import 'package:iOS_bundle_id/data/entities/application.dart';
import 'package:iOS_bundle_id/data/entities/search.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

/// The search api client.
class SearchApiClient {
  /// Creates a [SearchApiClient].
  const SearchApiClient({
    @required this.client,
  });

  /// The http client.
  final http.Client client;

  /// Search applications with a given search input.
  Future<List<Application>> searchApplications(
    String search, {
    int limit = 10,
  }) async {
    final http.Response response = await client
        .get(
          '${AppConsts.appSearchUrl}?limit=$limit&media=software&term=$search',
        )
        .timeout(
          const Duration(seconds: 5),
        );
    return Search.fromJson(response.body).applications;
  }
}
