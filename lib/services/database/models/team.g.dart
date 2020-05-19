// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) {
  return Team(
    id: json['id'] as String,
    name: json['name'] as String,
    user: json['user'] as String,
    managerId: json['managerId'] as String,
    isCurrentUserManager: json['isCurrentUserManager'] as bool,
    manager: json['manager'] == null
        ? null
        : User.fromJson(json['manager'] as Map<String, dynamic>),
    members: (json['members'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    save: json['save'] as bool,
    update: json['update'] as bool,
    delete: json['delete'] as bool,
  );
}

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'name': instance.name,
      'managerId': instance.managerId,
      'isCurrentUserManager': instance.isCurrentUserManager,
      'manager': instance.manager,
      'members': instance.members,
      'save': instance.save,
      'update': instance.update,
      'delete': instance.delete,
    };
