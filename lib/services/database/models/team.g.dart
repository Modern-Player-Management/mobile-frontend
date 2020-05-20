// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) {
  return Team(
    id: json['id'] as String,
    name: json['name'] as String,
    player: json['player'] as String,
    managerId: json['managerId'] as String,
    isCurrentUserManager: json['isCurrentUserManager'] as bool,
    manager: json['manager'] == null
        ? null
        : Player.fromJson(json['manager'] as Map<String, dynamic>),
    members: (json['members'] as List)
        ?.map((e) =>
            e == null ? null : Player.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    save: json['save'] as bool,
    update: json['update'] as bool,
    delete: json['delete'] as bool,
  );
}

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'player': instance.player,
      'name': instance.name,
      'managerId': instance.managerId,
      'isCurrentUserManager': instance.isCurrentUserManager,
      'manager': instance.manager,
      'members': instance.members,
      'save': instance.save,
      'update': instance.update,
      'delete': instance.delete,
    };
