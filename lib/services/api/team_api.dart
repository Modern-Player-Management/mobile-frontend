import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/api/converters/json_serializable_converter.dart';
import 'package:mpm/utils/utils.dart';

part 'team_api.chopper.dart';

@ChopperApi()
@lazySingleton
abstract class TeamApi extends ChopperService
{
	@factoryMethod
	static TeamApi create() => createWith();

	@factoryMethod
	static TeamApi createWith([http.BaseClient client, bool test = false])
	{
		return _$TeamApi(ChopperClient(
			client: client ?? IOClient(
				HttpClient()..connectionTimeout = Duration(seconds: 2),
			),
			baseUrl: '$serverUrl/Teams',
			converter: JsonSerializableConverter({
				Team: Team.fromJson,
				Player: Player.fromJson,
				Event: Event.fromJson,
				Participation: Participation.fromJson,
				Discrepancy: Discrepancy.fromJson,
				PlayerStats: PlayerStats.fromJson
			}),
			interceptors: [
				(Request request) 
				{
					if(test)
					{
						return request;
					}
					else
					{
						final headers = Map<String, String>.from(request.headers);
						var token = GetIt.instance<SecureStorage>().token;
						headers['Authorization'] = 'Bearer $token';
						return request.copyWith(headers: headers);
					}
				}
			]
		));
	}

	// Teams requests

	@Post(path: "/")
	Future<Response<Team>> createTeam(@Body() Team team);

	@Get(path: "/")
	Future<Response<List<Team>>> getTeams();

	@Get(path: "/{teamId}")
	Future<Response<Team>> getTeam(@Path() String teamId);

	@Put(path: "/{teamId}")
	Future<Response> updateTeam(@Path() String teamId, @Body() Team team);

	@Delete(path: "/{teamId}")
	Future<Response> deleteTeam(@Path() String teamId);

	@Post(path: "/{teamId}/player/{playerId}")
	Future<Response> addTeamPlayer(@Path() String teamId, @Path() String playerId);

	@Delete(path: "/{teamId}/player/{playerId}")
	Future<Response> deleteTeamPlayer(@Path() String teamId, @Path() String playerId);

	@Post(path: "/{teamId}/events")
	Future<Response<Event>> addEvent(@Path() String teamId, @Body() Event event);

	@Post(path: "/{teamId}/games")
	Future<Response<Event>> addGame(@Path() String teamId, @PartFile() MultipartFile file);

	@Get(path: "/{teamId}/stats")
	Future<Response<PlayerStats>> getPlayerStats();
}