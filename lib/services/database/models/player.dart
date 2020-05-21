import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

@Entity(
	tableName: 'players'
)
@JsonSerializable()
class Player
{
	@primaryKey
	String id;

	String username, email, created;

	@ignore
	@JsonKey(ignore: true)
	String password;

	@ignore
	@JsonKey(ignore: true)
	String confirmPassword;

	Player({
		this.id,
		this.username,
		this.email,
	});

	static const fromJson = _$PlayerFromJson;

	Map<String, dynamic> toJson() 
	{
		return {
			"id": id,
			"username": username,
			"email": email
		};
	}

	DateTime get date => DateTime.parse(created);
}