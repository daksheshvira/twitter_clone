import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/controllers/controllers.dart';
import 'package:twitter_clone/data/models/models.dart';
import 'package:twitter_clone/ui/common/common.dart';
import 'package:twitter_clone/utils/utils.dart';

class AddUpdateTweet extends StatelessWidget {
  final Tweet? tweet;
  final _tweetController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AddUpdateTweet({this.tweet});

  ValueNotifier<String> _tempValue = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add your thoughts'),
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
                maxLines: 5,
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
                            print(value);
                            return AppButton(
                              onPressed: value.isEmpty
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        FocusScope.of(context).unfocus();
                                        if (tweet == null) {
                                          addTweet(model, context);
                                        } else {
                                          editTweet(model, context);
                                        }
                                      }
                                    },
                              label: tweet != null ? 'Update' : 'Tweet',
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
    print(_tweetController.text);
    var tweet = Tweet(
      tweet: _tweetController.text.trim(),
      createdTime: DateTime.now(),
      updatedTime: DateTime.now(),
    );
    var addTweet = await model.addTweet(tweet);
    if (addTweet.isSuccess) {
      context.showSnackBar(addTweet.message);
      Navigator.pop(context);
    } else {
      context.showSnackBar(addTweet.message);
    }
  }

  void editTweet(TweetController model, BuildContext context) {
    if (_tweetController.text.trim() != tweet!.tweet) {
      tweet!.tweet = _tweetController.text.trim();
      model.editTweet(tweet!);
    }
  }
}
