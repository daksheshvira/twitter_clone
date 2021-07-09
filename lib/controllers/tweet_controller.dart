import 'package:flutter/material.dart';
import 'package:twitter_clone/data/models/models.dart';
import 'package:twitter_clone/repos/repos.dart';

class TweetController extends ChangeNotifier {
  final tweetRepo = TweetRepo();

  List<Tweet>? _tweetList;

  List<Tweet>? get tweetList => _tweetList;

  bool isLoading = false;

  Future<Responser> addTweet(Tweet tweet) async {
    isLoading = true;
    notifyListeners();
    if (tweet.isValid()) {
      var responser = await tweetRepo.addTweet(tweet);
      isLoading = false;
      notifyListeners();
      return responser;
    } else {
      isLoading = false;
      notifyListeners();
      return Responser(
        message: 'Tweet cannot include more than 280 characters',
        isSuccess: false,
      );
    }
  }

  Future<Responser> editTweet(Tweet tweet) async {
    isLoading = true;
    notifyListeners();
    if (tweet.isValid()) {
      tweet.updatedTime = DateTime.now();
      var responser = await tweetRepo.updateTweet(tweet);
      isLoading = false;
      notifyListeners();
      return responser;
    } else {
      isLoading = false;
      notifyListeners();
      return Responser(
        message: 'Tweet cannot include more than 280 characters',
        isSuccess: false,
      );
    }
  }

  Future<Responser> getTweetList() async {
    return Responser(message: 'message', isSuccess: false);
  }
}
