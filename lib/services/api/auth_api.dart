import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/io_client.dart' as io;
import 'package:injectable/injectable.dart';

import 'package:mpm/utils/utils.dart';

part 'auth_api.chopper.dart';

@ChopperApi()
@lazySingleton
abstract class AuthApi extends ChopperService 
{
	@factoryMethod
	static AuthApi create() => _$AuthApi(ChopperClient(
		baseUrl: serverUrl,
		client: io.IOClient(
			HttpClient()..connectionTimeout = const Duration(seconds: 4),
		),
		converter: JsonConverter(),
	));

	@Post(path: "/register")
	Future<Response<Map<String, dynamic>>> register(@Field() String username, @Field() String email, @Field() password);

	@Post(path: "/authenticate")
	Future<Response<Map<String, dynamic>>> authenticate(@Field() String username, @Field() password);
}