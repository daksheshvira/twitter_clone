import 'package:flutter/material.dart';
import 'package:twitter_clone/routes/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(),
        // child: Selector<TweetController, bool>(
        //     builder: (builder), selector: selector),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTweet,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTweet() {
    Navigator.pushNamed(
      context,
      Routes.tweetAddUpdate,
    );
  }
}
