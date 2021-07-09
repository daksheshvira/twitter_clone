import 'package:json_annotation/json_annotation.dart';

part 'tweet.g.dart';

@JsonSerializable()
class Tweet {
  String? id;
  String tweet;
  String? usedId;
  DateTime createdTime;
  DateTime updatedTime;

  Tweet({
    this.id,
    required this.tweet,
    this.usedId,
    required this.createdTime,
    required this.updatedTime,
  });

  factory Tweet.fromJson(Map<String, dynamic> json) => _$TweetFromJson(json);

  Map<String, dynamic> toJson() => _$TweetToJson(this);

  bool isValid() {
    return tweet.isNotEmpty && tweet.length <= 280;
  }
}
