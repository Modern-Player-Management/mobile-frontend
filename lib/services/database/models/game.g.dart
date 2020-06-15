// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
    id: json['id'] as String,
    name: json['name'] as String,
    date: json['date'] as String,
    win: json['win'] as int,
    playerStats: (json['playerStats'] as List)
        ?.map((e) =>
            e == null ? null : PlayerStats.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date,
      'win': instance.win,
      'playerStats': instance.playerStats,
    };
