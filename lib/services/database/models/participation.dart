import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mpm/services/database/models/event.dart';

part 'participation.g.dart';

@Entity(
	tableName: 'participations',
	foreignKeys: [
		ForeignKey(
			childColumns: ['eventId'],
			parentColumns: ['id'],
			entity: Event,
			onDelete: ForeignKeyAction.cascade,
			onUpdate: ForeignKeyAction.cascade
		)
	]
)
@JsonSerializable()
class Participation
{
	@primaryKey
	String id;

	bool confirmed;
	final String userId, username;

	@JsonKey(ignore: true)
	String eventId;

	@JsonKey(ignore: true)
	bool saved;
	@JsonKey(ignore: true)
	bool create;
	@JsonKey(ignore: true)
	bool deleted;

  	Participation({
		this.id,
		this.confirmed,
		this.userId,
		this.username,
		bool saved = false,
		bool create = false,
		bool deleted = false,
	}) :
		this.saved = saved ?? false,
		this.create = create ?? false,
		this.deleted = deleted ?? false;
	
	static const fromJson = _$ParticipationFromJson;

	Map<String, dynamic> toJson() {
		return {
			"presence": confirmed
		};
	}
}