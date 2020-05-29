// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discrepancy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Discrepancy _$DiscrepancyFromJson(Map<String, dynamic> json) {
  return Discrepancy(
    id: json['id'] as String,
  )
    ..type = json['type'] as int
    ..reason = json['reason'] as String
    ..delayLength = json['delayLength'] as int;
}

Map<String, dynamic> _$DiscrepancyToJson(Discrepancy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'reason': instance.reason,
      'delayLength': instance.delayLength,
    };
