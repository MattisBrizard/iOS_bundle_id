import 'dart:convert';

import 'package:iOS_bundle_id/data/entities/application.dart';

/// The search response model.
class Search {
  /// Creates a [Search].
  const Search({
    this.resultCount,
    this.applications,
  });

  /// Creates a [Search] from json `String`.
  factory Search.fromJson(String str) => Search.fromMap(json.decode(str));

  /// Creates a [Search] from `Map`.
  factory Search.fromMap(Map<String, dynamic> json) => Search(
        resultCount: json['resultCount'],
        applications: List<Application>.from(
            json['results'].map((x) => Application.fromMap(x))),
      );

  /// The number of results
  final int resultCount;

  /// The applications list.
  final List<Application> applications;

  /// Transform into json `String`.
  String toJson() => json.encode(toMap());

  /// Transform into `Map`.
  Map<String, dynamic> toMap() => {
        'resultCount': resultCount,
        'applications': List<dynamic>.from(applications.map((x) => x.toMap())),
      };
}
