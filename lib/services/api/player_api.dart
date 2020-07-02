import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/api/converters/json_serializable_converter.dart';
import 'package:mpm/utils/utils.dart';

part 'player_api.chopper.dart';

@ChopperApi()
@lazySingleton
abstract class PlayerApi extends ChopperService
{
	@factoryMethod
	static PlayerApi create() => createWith();

	@factoryMethod
	static PlayerApi createWith([http.BaseClient client])
	{
		return _$PlayerApi(ChopperClient(
			client: IOClient(
				HttpClient()..connectionTimeout = Duration(seconds: 2),
			),
			baseUrl: '$serverUrl/Users',
			converter: JsonSerializableConverter({
				Player: Player.fromJson,
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

	// Players requests

	@Get(path: "/search/")
	Future<Response<List<Player>>> searchPlayers(@Query('search') String username);

	@Get(path: "/{username}")
	Future<Response<Player>> getPlayer(@Path() String username);

	@Put(path: "/{playerId}")
	Future<Response<Player>> updatePlayer(@Path() String playerId, @Body() Player player);

	@Get(path: "/profile")
	Future<Response<Player>> getProfile();
}