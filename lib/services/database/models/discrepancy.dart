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

	@JsonKey(ignore: true)
	bool save;
	@JsonKey(ignore: true)
	bool update;
	@JsonKey(ignore: true)
	bool delete;

	Discrepancy({
		this.id, 
		bool save = false,
		bool update = false,
		bool delete = false
	}) : 
		this.save = save ?? false,
		this.update = update ?? false,
		this.delete = delete ?? false;

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