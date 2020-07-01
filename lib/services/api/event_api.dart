import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/api/converters/json_serializable_converter.dart';
import 'package:mpm/services/database/models/participation.dart';
import 'package:mpm/utils/utils.dart';

part 'event_api.chopper.dart';

@ChopperApi()
@lazySingleton
abstract class EventApi extends ChopperService
{
	@factoryMethod
	static EventApi create() => createWith();

	@factoryMethod
	static EventApi createWith([http.BaseClient client])
	{
		return _$EventApi(ChopperClient(
			client: IOClient(
				HttpClient()..connectionTimeout = const Duration(seconds: 4),
			),
			baseUrl: '$serverUrl/Events',
			converter: JsonSerializableConverter({
				Team: Team.fromJson,
				Player: Player.fromJson,
				Event: Event.fromJson,
				Participation: Participation.fromJson
			}),
			interceptors: [
				(Request request) {
					final headers = Map<String, String>.from(request.headers);
					var token = locator<SecureStorage>().token;
					headers['Authorization'] = 'Bearer $token';
					return request.copyWith(headers: headers);
				}
			]
		));
	}

	// events requests

	@Post(path: "/{eventId}/confirm")
	Future<Response> confirm(@Path() String eventId);

	@Post(path: "/{eventId}/discrepancies")
	Future<Response> addEventDiscrepancy(@Path() String eventId, @Body() Discrepancy discrepancy);

	@Put(path: "/{eventId}")
	Future<Response> updateEvent(@Path() String eventId, @Body() Event event);

	@Delete(path: "/{eventId}")
	Future<Response> deleteEvent(@Path() String eventId);

	@Get(path: "/ical/{icalSecret}")
	Future<Response> getIcal(@Path() String icalSecret);
}