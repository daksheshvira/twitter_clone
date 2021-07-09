import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/controllers.dart';
import 'package:twitter_clone/data/images.dart';
import 'package:twitter_clone/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      checkAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: AssetImage(Images.instance.logo),
              width: 100,
            ),
          ],
        ),
      ),
    );
  }

  void checkAuth() {
    var userLoggedIn = context.read<UserController>().isUserLoggedIn();
    if (userLoggedIn) {
      Navigator.pushReplacementNamed(
        context,
        Routes.home,
      );
    } else {
      Navigator.pushReplacementNamed(
        context,
        Routes.auth,
      );
    }
  }
}
