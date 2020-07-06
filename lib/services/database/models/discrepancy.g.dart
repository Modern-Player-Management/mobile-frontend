// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discrepancy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Discrepancy _$DiscrepancyFromJson(Map<String, dynamic> json) {
  return Discrepancy(
    id: json['id'] as String,
    type: json['type'] as int,
    reason: json['reason'] as String,
    delayLength: json['delayLength'] as int,
  )
    ..userId = json['userId'] as String
    ..username = json['username'] as String;
}

Map<String, dynamic> _$DiscrepancyToJson(Discrepancy instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'reason': instance.reason,
      'userId': instance.userId,
      'username': instance.username,
      'delayLength': instance.delayLength,
    };
