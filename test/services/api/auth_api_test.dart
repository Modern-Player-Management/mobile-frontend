
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
		test('available request', available);
	});
}

void register() async
{
	final client = MockClient((req) async {
		expect(req.method, "POST");
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
		expect(req.method, "POST");
		expect(req.url.path, equals("/authenticate"));
		return http.Response(json.encode({
			"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
			"username": "string",
			"email": "string",
			"token": "string",
			"image": "string"
		}), 200);
	});

	AuthApi api = AuthApi.createWith(client);

	final res = await api.authenticate("test@test.com", "test");

	expect(res.isSuccessful, equals(true));
}

void available() async
{
	final client = MockClient((req) async {
		expect(req.method, "POST");
		expect(req.url.path, equals("/available"));
		return http.Response(json.encode({
			"username": "test",
			"isAvailable": true
		}), 200);
	});

	AuthApi api = AuthApi.createWith(client);

	final res = await api.available("test");

	expect(res.isSuccessful, equals(true));
	expect(res.body["username"], "test");
	expect(res.body["isAvailable"], true);
}