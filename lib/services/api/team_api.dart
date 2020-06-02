import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/api/converters/json_serializable_converter.dart';
import 'package:mpm/services/api/models/participation.dart';
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
				HttpClient()..connectionTimeout = const Duration(seconds: 4),
			),
			baseUrl: serverUrl,
			converter: JsonSerializableConverter({
				Team: Team.fromJson,
				Player: Player.fromJson,
				Event: Event.fromJson,
				Participation: Participation.fromJson
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

	@Post(path: "/api/teams")
	Future<Response<Team>> createTeam(@Body() Team team);

	@Get(path: "/api/teams")
	Future<Response<List<Team>>> getTeams();

	@Post(path: "/api/teams/{teamId}/player/{playerId}")
	Future<Response<Team>> addTeamPlayer(@Path() String teamId, @Path() String playerId);

	@Delete(path: "/api/teams/{teamId}/player/{playerId}")
	Future<Response> deleteTeamPlayer(@Path() String teamId, @Path() String playerId);

	@Put(path: "/api/teams/{teamId}")
	Future<Response> updateTeam(@Path() String teamId, @Body() Team team);

	@Delete(path: "/api/teams/{teamId}")
	Future<Response> deleteTeam(@Path() String teamId);

	@Post(path: "/api/teams/{teamId}/events")
	Future<Response<Team>> addEvent(@Path() String teamId, @Body() Event event);
}