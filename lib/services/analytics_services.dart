import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  appOpen() => _analytics.logAppOpen();

  logevent({required String eventName, required List<String> parems}) =>
      _analytics.logEvent(name: eventName);

  logSearchEvent({required String search}) =>
      _analytics..logSearch(searchTerm: search);

  gneraType({required String gnera}) =>
      _analytics.setUserProperty(name: "gners_liked", value: gnera);
}
