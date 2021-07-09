import 'package:flutter/material.dart';
import 'package:twitter_clone/data/models/models.dart';
import 'package:twitter_clone/ui/auth/auth.dart';
import 'package:twitter_clone/ui/home/home.dart';
import 'package:twitter_clone/ui/splash_screen.dart';
import 'package:twitter_clone/ui/tweet/add_update_tweet.dart';

part 'route_arguments.dart';

class Routes {
  static const splash = '/';
  static const auth = '/auth-screen';
  static const home = '/home-screen';

  static const tweetAddUpdate = '/tweet-add-update';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: settings,
        );
      case Routes.auth:
        return MaterialPageRoute(
          builder: (_) => AuthHomeScreen(),
          settings: settings,
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: settings,
        );

      case Routes.tweetAddUpdate:
        return MaterialPageRoute(
          builder: (_) => args != null
              ? AddUpdateTweet(
                  tweet: args as Tweet,
                )
              : AddUpdateTweet(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
          settings: settings,
        );
    }
  }

  static PageRoute misTypedArgsRoute<T>(Object args) {
    return MaterialPageRoute(builder: (ctx) => Container());
  }
}
