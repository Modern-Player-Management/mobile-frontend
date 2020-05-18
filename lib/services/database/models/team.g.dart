// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) {
  return Team(
    id: json['id'] as String,
    user: json['user'] as String,
    name: json['name'] as String,
    save: json['save'] as bool,
    update: json['update'] as bool,
    delete: json['delete'] as bool,
    events: (json['events'] as List)
        ?.map(
            (e) => e == null ? null : Event.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'name': instance.name,
      'save': instance.save,
      'update': instance.update,
      'delete': instance.delete,
      'events': instance.events,
    };
