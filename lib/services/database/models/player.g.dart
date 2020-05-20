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
    save: json['save'] as bool,
    update: json['update'] as bool,
    delete: json['delete'] as bool,
  );
}

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'save': instance.save,
      'update': instance.update,
      'delete': instance.delete,
    };
