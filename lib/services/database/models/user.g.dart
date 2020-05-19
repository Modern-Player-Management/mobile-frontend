// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    username: json['username'] as String,
    email: json['email'] as String,
    save: json['save'] as bool,
    update: json['update'] as bool,
    delete: json['delete'] as bool,
  )
    ..id = json['id'] as String
    ..password = json['password'] as String
    ..confirmPassword = json['confirmPassword'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'save': instance.save,
      'update': instance.update,
      'delete': instance.delete,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
