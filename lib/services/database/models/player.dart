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

	String username, email, image, created, calendarSecret;

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
		this.image,
		this.created,
		this.calendarSecret
	});

	static const fromJson = _$PlayerFromJson;

	Map<String, dynamic> toJson() 
	{
		return {
			"username": username,
			"email": email,
			"image": image,
		};
	}

	DateTime get date => DateTime.parse(created);
}