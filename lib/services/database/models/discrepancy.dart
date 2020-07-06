import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mpm/services/database/models/event.dart';

part 'discrepancy.g.dart';

@Entity(
	tableName: 'discrepancies',
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
class Discrepancy
{
	@primaryKey
	String id;

	int type;
	String reason, userId, username;
	int delayLength;

	@JsonKey(ignore: true)
	String eventId;

	@JsonKey(ignore: true)
	bool saved;
	@JsonKey(ignore: true)
	bool create;
	@JsonKey(ignore: true)
	bool deleted;

	Discrepancy({
		this.id, 
		this.type,
		this.reason,
		this.delayLength,
		bool saved = false,
		bool create = false,
		bool deleted = false,
	}) :
		this.saved = saved ?? false,
		this.create = create ?? false,
		this.deleted = deleted ?? false;

	static const fromJson = _$DiscrepancyFromJson;

	Map<String, dynamic> toJson() 
	{
		return {
			"type": type,
			"reason": reason,
			"delayLength": delayLength
		};
	}
}