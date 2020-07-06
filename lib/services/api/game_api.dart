import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/utils.dart';

part 'game_api.chopper.dart';

@ChopperApi()
@lazySingleton
abstract class GameApi extends ChopperService
{
	@factoryMethod
	static GameApi create() => createWith();

	@factoryMethod
	static GameApi createWith([http.BaseClient client])
	{
		return _$GameApi(ChopperClient(
			client: IOClient(
				HttpClient()..connectionTimeout = Duration(seconds: 2),
			),
			baseUrl: '$serverUrl/Games',
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

	// Games requests

	@Delete(path: "/{gameId}")
	Future<Response> deleteGame(@Path() String gameId);
}