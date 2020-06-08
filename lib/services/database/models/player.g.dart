// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return Player(
    id: json['id'] as String,
    username: json['username'] as String,
    email: json['email'] as String,
    image: json['image'] as String,
    created: json['created'] as String,
    calendarSecret: json['calendarSecret'] as String,
  );
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'image': instance.image,
      'created': instance.created,
      'calendarSecret': instance.calendarSecret,
    };
