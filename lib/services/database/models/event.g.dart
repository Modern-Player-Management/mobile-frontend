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
  )..type = json['type'] as int;
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'team': instance.team,
      'start': instance.start,
      'end': instance.end,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
    };
