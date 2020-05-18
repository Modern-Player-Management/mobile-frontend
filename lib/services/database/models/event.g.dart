// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    id: json['id'] as String,
    team: json['team'] as String,
    start: json['start'] as String,
    end: json['end'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    save: json['save'] as bool,
    update: json['update'] as bool,
    delete: json['delete'] as bool,
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'team': instance.team,
      'start': instance.start,
      'end': instance.end,
      'title': instance.title,
      'description': instance.description,
      'save': instance.save,
      'update': instance.update,
      'delete': instance.delete,
    };
