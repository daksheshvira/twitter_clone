import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/controllers.dart';
import 'package:twitter_clone/routes/routes.dart';
import 'package:twitter_clone/utils/utils.dart';

class TwitterApp extends StatefulWidget {
  @override
  _TwitterAppState createState() => _TwitterAppState();
}

class _TwitterAppState extends State<TwitterApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>(
          create: (_) => UserController(),
        ),
        ChangeNotifierProvider<TweetController>(
          create: (_) => TweetController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.onGenerateRoute,
        navigatorKey: AppEnvironment.rootNavigationKey,
        initialRoute: Routes.splash,
        navigatorObservers: [
          AppEnvironment.routeObserver,
          FirebaseAnalyticsObserver(analytics: AppEnvironment.analytics),
        ],
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          primaryColorLight: Colors.lightBlue,
          textTheme: TextTheme(),
        ),
      ),
    );
  }
}
