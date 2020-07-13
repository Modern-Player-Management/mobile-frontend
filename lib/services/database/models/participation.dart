import 'package:json_annotation/json_annotation.dart';


part 'participation.g.dart';

@JsonSerializable()
class Participation
{
	bool confirmed;
	String userId, username;

  	Participation({
		this.confirmed,
		this.userId,
		this.username,
	});
	
	static const fromJson = _$ParticipationFromJson;

	Map<String, dynamic> toJson() {
		return {
			"present": confirmed
		};
	}
}