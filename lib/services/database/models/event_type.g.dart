// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventType _$EventTypeFromJson(Map<String, dynamic> json) {
  return EventType(
    index: json['index'] as int,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$EventTypeToJson(EventType instance) => <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
    };
