import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@Entity(
	tableName: 'users'
)
@JsonSerializable()
class User
{
	@primaryKey
	String id;

	String username, email;

	bool save, update, delete;

	@ignore
	String password;

	@ignore
	String confirmPassword;

	User({
		this.username,
		this.email,
		bool save = false,
		bool update = false,
		bool delete = false,
	}) : 
		this.save = save ?? false,
		this.update = update ?? false,
		this.delete = delete ?? false;

	static const fromJson = _$UserFromJson;

	Map<String, dynamic> toJson() 
	{
		return {
			"id": id,
			"username": username,
			"email": email
		};
	}
}