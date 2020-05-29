// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) {
  return Team(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    player: json['player'] as String,
    managerId: json['managerId'] as String,
    isCurrentUserManager: json['isCurrentUserManager'] as bool,
    manager: json['manager'] == null
        ? null
        : Player.fromJson(json['manager'] as Map<String, dynamic>),
    players: (json['memberships'] as List)
        ?.map((e) =>
            e == null ? null : Player.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..image = json['image'] as String
    ..created = json['created'] as String;
}

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'player': instance.player,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'managerId': instance.managerId,
      'isCurrentUserManager': instance.isCurrentUserManager,
      'manager': instance.manager,
      'memberships': instance.players,
      'created': instance.created,
    };
