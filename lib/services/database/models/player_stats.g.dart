// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerStats _$PlayerStatsFromJson(Map<String, dynamic> json) {
  return PlayerStats(
    id: json['id'] as String,
    player: json['player'] as String,
    goals: json['goals'] as int,
    saves: json['saves'] as int,
    shots: json['shots'] as int,
    assists: json['assists'] as int,
    score: json['score'] as int,
    goalShots: json['goalShots'] as int,
    created: json['created'] as String,
  );
}

Map<String, dynamic> _$PlayerStatsToJson(PlayerStats instance) =>
    <String, dynamic>{
      'id': instance.id,
      'player': instance.player,
      'goals': instance.goals,
      'saves': instance.saves,
      'shots': instance.shots,
      'assists': instance.assists,
      'score': instance.score,
      'goalShots': instance.goalShots,
      'created': instance.created,
    };
