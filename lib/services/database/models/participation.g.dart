// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participation _$ParticipationFromJson(Map<String, dynamic> json) {
  return Participation(
    id: json['id'] as String,
    confirmed: json['confirmed'] as bool,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$ParticipationToJson(Participation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'confirmed': instance.confirmed,
      'username': instance.username,
    };
