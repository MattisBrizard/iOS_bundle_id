import 'package:firebase/firebase.dart';

/// This is a wrapper for firebase analytics.
/// It logs event to the firebase console only in production mode.
class AppAnalytics {
  /// Creates a [AppAnalytics].
  const AppAnalytics({this.analytics});

  /// The firebase analytics.
  final Analytics analytics;

  /// Logs app open to the firebase console.
  void logAppOpen() {
    return _logEvent('app_open', {});
  }

  /// Logs app open to the firebase console.
  void logSearchApp(String search) {
    return _logEvent('search_app', {'search': search});
  }

  void _logEvent(String eventName, Map<String, dynamic> eventParameters) {
    bool debug = false;
    assert(debug = true);
    if (debug) {
      print('Analytics log: $eventName, $eventParameters');
    } else {
      analytics.logEvent(eventName, eventParameters);
    }
  }
}
