import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/controllers.dart';
import 'package:twitter_clone/data/models/tweet.dart';
import 'package:twitter_clone/routes/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dateFormat = DateFormat('dd MMM yyyy hh:mm a');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Consumer<TweetController>(
            builder: (_, model, child) => model.isLoading
                ? Center(child: CircularProgressIndicator())
                : _tweetList(model),
          ),
        ),
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

  Widget _tweetList(TweetController model) {
    return StreamBuilder<QuerySnapshot>(
      stream: model.streamTweet(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        return ListView.separated(
          itemBuilder: (_, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            var tweet = Tweet.fromJson(document.data() as Map<String, dynamic>);
            return _tweetCard(tweet);
          },
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        );
      },
    );
  }

  Widget _tweetCard(Tweet tweet) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.tweetAddUpdate,
          arguments: tweet,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color(0xfff4f5ff),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tweet.tweet,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Text(
                dateFormat.format(tweet.updatedTime),
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
