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
    type: json['type'] as int,
    participations: (json['participations'] as List)
        ?.map((e) => e == null
            ? null
            : Participation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    discrepancies: (json['discrepancies'] as List)
        ?.map((e) =>
            e == null ? null : Discrepancy.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'team': instance.team,
      'start': instance.start,
      'end': instance.end,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'participations': instance.participations,
      'discrepancies': instance.discrepancies,
    };
