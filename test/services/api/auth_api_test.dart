
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mpm/services/api/auth_api.dart';

void main()
{
	group('simple auth tests', (){
		test('register request', register);
		test('authenticate request', authenticate);
	});
}

void register() async
{
	final client = MockClient((req) async {
		expect(req.url.path, equals("/register"));
		return http.Response("", 200);
	});

	AuthApi api = AuthApi.createWith(client);

	final res = await api.register("test", "test@test.com", "test");

	expect(res.isSuccessful, equals(true));
}

void authenticate() async
{
	final client = MockClient((req) async {
		expect(req.url.path, equals("/authenticate"));
		return http.Response(json.encode({}), 200);
	});

	AuthApi api = AuthApi.createWith(client);

	final res = await api.authenticate("test@test.com", "test");

	expect(res.isSuccessful, equals(true));
}