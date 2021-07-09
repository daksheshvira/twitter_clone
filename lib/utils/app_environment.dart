import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppEnvironment {
  AppEnvironment._();

  static final routeObserver = RouteObserver<ModalRoute>();
  static final rootNavigationKey = GlobalKey<NavigatorState>();
  static final isDarkMode = ValueNotifier(false);
  static bool isTestMode = false;
  static FirebaseAnalytics analytics = FirebaseAnalytics();
}
