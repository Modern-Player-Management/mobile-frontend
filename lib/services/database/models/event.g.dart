// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    id: json['id'] as String,
    start: json['start'] as String,
    end: json['end'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    type: json['type'] as int,
    currentHasConfirmed: json['currentHasConfirmed'] as bool,
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
      'start': instance.start,
      'end': instance.end,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'currentHasConfirmed': instance.currentHasConfirmed,
      'participations': instance.participations,
      'discrepancies': instance.discrepancies,
    };
