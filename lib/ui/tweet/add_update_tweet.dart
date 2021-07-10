import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/controllers.dart';
import 'package:twitter_clone/data/models/models.dart';
import 'package:twitter_clone/ui/common/common.dart';
import 'package:twitter_clone/utils/utils.dart';

class AddUpdateTweet extends StatefulWidget {
  final Tweet? tweet;

  AddUpdateTweet({this.tweet});

  @override
  _AddUpdateTweetState createState() => _AddUpdateTweetState();
}

class _AddUpdateTweetState extends State<AddUpdateTweet> {
  final _tweetController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<String> _tempValue = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _tweetController.text = widget.tweet!.tweet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.tweet != null ? 'Update your thoughts' : 'Add your thoughts',
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: _tweetController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  hintText: 'What\'s happening',
                ),
                maxLength: 280,
                maxLines: 10,
                validator: (value) {
                  if (value!.length <= 280) {
                    return null;
                  } else {
                    return 'Tweet cannot include more than 280 characters';
                  }
                },
                autovalidateMode: AutovalidateMode.disabled,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  _tempValue.value = value;
                },
                autofocus: true,
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 64),
                child: Consumer<TweetController>(
                  builder: (_, model, child) => model.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ValueListenableBuilder<String>(
                          valueListenable: _tempValue,
                          builder: (_, value, __) {
                            return AppButton(
                              onPressed: value.isEmpty
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();
                                        if (widget.tweet == null) {
                                          addTweet(model, context);
                                        } else {
                                          editTweet(model, context);
                                        }
                                      }
                                    },
                              label: widget.tweet != null ? 'Update' : 'Tweet',
                            );
                          }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTweet(TweetController model, BuildContext context) async {
    var tweet = Tweet(
      tweet: _tweetController.text.trim(),
      createdTime: DateTime.now(),
      updatedTime: DateTime.now(),
    );
    var addTweet = await model.addTweet(tweet);
    if (addTweet.isSuccess) {
      context.showSnackBar(addTweet.message);
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      context.showSnackBar(addTweet.message);
    }
  }

  Future<void> editTweet(TweetController model, BuildContext context) async {
    if (_tweetController.text.trim() != widget.tweet!.tweet) {
      widget.tweet!.tweet = _tweetController.text.trim();
      var editTweet = await model.editTweet(widget.tweet!);
      if (editTweet.isSuccess) {
        context.showSnackBar(editTweet.message);
        Navigator.of(context, rootNavigator: true).pop();
      } else {
        context.showSnackBar(editTweet.message);
      }
    }
  }
}
