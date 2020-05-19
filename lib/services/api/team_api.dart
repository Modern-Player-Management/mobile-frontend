import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
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
	static TeamApi createWith([http.BaseClient client])
	{
		return _$TeamApi(ChopperClient(
			client: IOClient(
				HttpClient()..connectionTimeout = const Duration(seconds: 4),
			),
			baseUrl: serverUrl,
			converter: JsonSerializableConverter({
				Team: Team.fromJson,
				User: User.fromJson,
				Event: Event.fromJson
			}),
			interceptors: [
				(Request request) {
					final headers = Map<String, String>.from(request.headers);
					var token = GetIt.instance<SecureStorage>().token;
					headers['Authorization'] = 'Bearer $token';
					return request.copyWith(headers: headers);
				}
			]
		));
	}

	// Teams requests

	@Get(path: "/api/teams")
	Future<Response<List<Team>>> getTeams();

	@Post(path: "/api/teams")
	Future<Response<Team>> createTeam(@Body() Team team);

	@Put(path: "/api/teams/{teamId}")
	Future<Response<Team>> updateTeam(@Path() String teamId, @Body() Team team);

	@Delete(path: "/api/teams/{teamId}")
	Future<Response> deleteTeam(@Path() String teamId);
}