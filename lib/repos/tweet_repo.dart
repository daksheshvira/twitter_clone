import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/data/models/models.dart';
import 'package:twitter_clone/utils/error_handler.dart';

class TweetRepo {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference tweets = FirebaseFirestore.instance.collection('tweets');

  Stream<QuerySnapshot> streamTweet() {
    return tweets.orderBy('updatedTime', descending: true).snapshots();
  }

  Future<Responser> addTweet(Tweet tweet) async {
    try {
      if (auth.currentUser != null) {
        tweet.usedId = auth.currentUser!.uid;
        var documentReference = await tweets.add(tweet.toJson());
        if (documentReference.id.isNotEmpty) {
          await tweets
              .doc(documentReference.id)
              .update({'id': documentReference.id});

          return Responser(
              message: 'Tweet added successfully', isSuccess: true);
        } else {
          return Responser(
              message: 'Error occurred while adding tweet', isSuccess: false);
        }
      } else {
        return Responser(
          message: 'User not logged in',
          isSuccess: false,
        );
      }
    } catch (e) {
      return ErrorHandler.error(e);
    }
  }

  Future<Responser> updateTweet(Tweet tweet) async {
    try {
      if (auth.currentUser != null) {
        await tweets.doc(tweet.id).update(tweet.toJson());
        return Responser(
            message: 'Tweet updated successfully', isSuccess: true);
      } else {
        return Responser(
          message: 'User not logged in',
          isSuccess: false,
        );
      }
    } catch (e) {
      return ErrorHandler.error(e);
    }
  }
}
