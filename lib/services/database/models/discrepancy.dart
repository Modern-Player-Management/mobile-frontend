import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discrepancy.g.dart';

@Entity(
	tableName: 'discrepancies',
	foreignKeys: [
		
	]
)
@JsonSerializable()
class Discrepancy
{
	@primaryKey
	String id;

	int type;
	String reason;
	int delayLength;

	@JsonKey(ignore: true)
	String event;

	Discrepancy({
		this.id, 
		this.type,
		this.reason,
		this.delayLength,
		this.event
	});

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