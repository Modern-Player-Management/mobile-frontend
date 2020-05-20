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

	String username, email;

	@ignore
	@JsonKey(ignore: true)
	String password;

	@ignore
	@JsonKey(ignore: true)
	String confirmPassword;

	bool save, update, delete;

	Player({
		this.id,
		this.username,
		this.email,
		bool save = false,
		bool update = false,
		bool delete = false,
	}) : 
		this.save = save ?? false,
		this.update = update ?? false,
		this.delete = delete ?? false;

	static const fromJson = _$PlayerFromJson;

	Map<String, dynamic> toJson() 
	{
		return {
			"id": id,
			"username": username,
			"email": email
		};
	}
}