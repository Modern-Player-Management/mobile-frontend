import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discrepancy.g.dart';

@Entity(
	tableName: 'discrepancies',
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
	bool create;

	Discrepancy({
		this.id, 
		this.type,
		this.reason,
		this.delayLength,
		bool create
	}) :
		this.create = create ?? false;

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