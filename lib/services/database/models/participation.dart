import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'participation.g.dart';

@Entity(
	tableName: 'participations',
)
@JsonSerializable()
class Participation
{
	@primaryKey
	final int id;

	final bool confirmed;
	final String userId, username;

  	Participation({
		  this.id,
		  this.confirmed,
		  this.userId,
		  this.username
	  });
	
	static const fromJson = _$ParticipationFromJson;

	Map<String, dynamic> toJson() => _$ParticipationToJson(this);
}