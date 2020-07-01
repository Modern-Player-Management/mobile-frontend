// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participation _$ParticipationFromJson(Map<String, dynamic> json) {
  return Participation(
    confirmed: json['confirmed'] as bool,
    userId: json['userId'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$ParticipationToJson(Participation instance) =>
    <String, dynamic>{
      'confirmed': instance.confirmed,
      'userId': instance.userId,
      'username': instance.username,
    };
