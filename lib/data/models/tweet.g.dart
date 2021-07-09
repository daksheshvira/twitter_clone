// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tweet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tweet _$TweetFromJson(Map<String, dynamic> json) {
  return Tweet(
    id: json['id'] as String?,
    tweet: json['tweet'] as String,
    usedId: json['usedId'] as String?,
    createdTime: DateTime.parse(json['createdTime'] as String),
    updatedTime: DateTime.parse(json['updatedTime'] as String),
  );
}

Map<String, dynamic> _$TweetToJson(Tweet instance) => <String, dynamic>{
      'id': instance.id,
      'tweet': instance.tweet,
      'usedId': instance.usedId,
      'createdTime': instance.createdTime.toIso8601String(),
      'updatedTime': instance.updatedTime.toIso8601String(),
    };
