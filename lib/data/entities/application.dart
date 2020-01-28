import 'dart:convert';

/// An iOS AppStore app.
class Application {
  /// Creates an [Application].
  const Application({
    this.artworkUrl,
    this.trackViewUrl,
    this.trackName,
    this.artistName,
    this.bundleId,
    this.averageUserRating,
  });

  /// Creates an [Application] from json `String`.
  factory Application.fromJson(String str) =>
      Application.fromMap(json.decode(str));

  /// Creates an [Application] from `Map`.
  factory Application.fromMap(Map<String, dynamic> json) => Application(
        artworkUrl: json['artworkUrl512'],
        trackViewUrl: json['trackViewUrl'],
        trackName: json['trackName'],
        artistName: json['artistName'],
        bundleId: json['bundleId'],
        averageUserRating: json['averageUserRating']?.toDouble(),
      );

  /// The app icon url.
  final String artworkUrl;

  /// The link to the AppStore page.
  final String trackViewUrl;

  /// The app name.
  final String trackName;

  /// The app artist name.
  final String artistName;

  /// The app bundle id.
  final String bundleId;

  /// The app average rating.
  final double averageUserRating;

  /// Transform into json `String`.
  String toJson() => json.encode(toMap());

  /// Transform into `Map`.
  Map<String, dynamic> toMap() => {
        'artworkUrl512': artworkUrl,
        'trackViewUrl': trackViewUrl,
        'trackName': trackName,
        'artistName': artistName,
        'bundleId': bundleId,
        'averageUserRating': averageUserRating,
      };
}
