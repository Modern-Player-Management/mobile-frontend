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
	String id;

	bool confirmed;
	final String username;

  	Participation({
		  this.id,
		  this.confirmed,
		  this.username,
	  });
	
	static const fromJson = _$ParticipationFromJson;

	Map<String, dynamic> toJson() {
		return {
			"presence": confirmed
		};
	}
}