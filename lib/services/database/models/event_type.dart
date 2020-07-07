import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_type.g.dart';

@Entity(
	tableName: 'event_types',
)
@JsonSerializable()
class EventType
{
	@primaryKey
	int index;

	final String name;

	EventType({
		this.index,
		this.name
	});

	static const fromJson = _$EventTypeFromJson;

	@override
	String toString() 
	{
		return name;
	}
}