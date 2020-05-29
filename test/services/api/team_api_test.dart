
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/services/api/team_api.dart';

void main() async
{
	group('simple team api tests', (){
		test('get teams', getTeams);
		test('create team', createTeam);
		test('update team', updateTeam);
		test('delete team', deleteTeam);
		test('add team player', addTeamPlayer);
		test('delete team player', deleteTeamPlayer);
		test('add event', addEvent);
	});
}

void getTeams() async
{
	final client = MockClient((req) async {
		expect(req.method, "GET");
		expect(req.url.path, equals("/api/teams"));
		return http.Response(json.encode([
			{
				"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
				"name": "string",
				"description": "string",
				"image": "string",
				"manager": {
					"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
					"username": "string",
					"image": "string"
				},
				"isCurrentUserManager": true,
				"players": [
					{
						"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
						"username": "string",
						"image": "string"
					}
				],
				"created": "2020-05-29T08:39:56.698Z",
				"events": [
					{
						"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
						"name": "string",
						"description": "string",
						"start": "2020-05-29T08:39:56.698Z",
						"end": "2020-05-29T08:39:56.698Z",
						"type": 0,
						"participations": [
							{
								"confirmed": true,
								"userId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
								"username": "string"
							}
						],
						"discrepancies": [
							{
								"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
								"userId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
								"username": "string",
								"type": 0,
								"reason": "string",
								"delayLength": 0
							}
						]
					}
				]
			}
		]), 200);
	});

	TeamApi api = TeamApi.createWith(client, true);

	var res = await api.getTeams();

	expect(res.isSuccessful, true);
	expect(res.body.length, 1);
}

void createTeam() async
{
	final client = MockClient((req) async {
		expect(req.method, "POST");
		expect(req.url.path, equals("/api/teams"));
		return http.Response(json.encode({
			"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
			"name": "string",
			"description": "string",
			"image": "string",
			"manager": {
				"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
				"username": "string",
				"image": "string"
			},
			"isCurrentUserManager": true,
			"players": [
				{
					"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
					"username": "string",
					"image": "string"
				}
			],
			"created": "2020-05-29T08:39:56.698Z",
			"events": [
				{
					"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
					"name": "string",
					"description": "string",
					"start": "2020-05-29T08:39:56.698Z",
					"end": "2020-05-29T08:39:56.698Z",
					"type": 0,
					"participations": [
						{
							"confirmed": true,
							"userId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
							"username": "string"
						}
					],
					"discrepancies": [
						{
							"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
							"userId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
							"username": "string",
							"type": 0,
							"reason": "string",
							"delayLength": 0
						}
					]
				}
			]
		}), 200);
	});

	TeamApi api = TeamApi.createWith(client, true);

	var res = await api.createTeam(Team(
		name: "test",
		description: "description",
		image: "image",
	));

	expect(res.isSuccessful, true);
	expect(res.body.id, "3fa85f64-5717-4562-b3fc-2c963f66afa6");
}

void updateTeam() async
{
	final client = MockClient((req) async {
		expect(req.method, "PUT");
		expect(req.url.path, equals("/api/teams/teamId"));
		return http.Response(json.encode({}), 200);
	});

	TeamApi api = TeamApi.createWith(client, true);

	var res = await api.updateTeam("teamId", Team(
		name: "test",
		description: "description",
		image: "image",
	));

	expect(res.isSuccessful, true);
}

void deleteTeam() async
{
	final client = MockClient((req) async {
		expect(req.method, "DELETE");
		expect(req.url.path, equals("/api/teams/teamId"));
		return http.Response(json.encode({}), 200);
	});

	TeamApi api = TeamApi.createWith(client, true);

	var res = await  api.deleteTeam("teamId");

	expect(res.isSuccessful, true);
}

void addTeamPlayer() async
{
	final client = MockClient((req) async {
		expect(req.method, "POST");
		expect(req.url.path, equals("/api/teams/teamId/player/playerId"));
		return http.Response(json.encode({}), 200);
	});

	TeamApi api = TeamApi.createWith(client, true);

	var res = await  api.addTeamPlayer("teamId", "playerId");

	expect(res.isSuccessful, true);
}

void deleteTeamPlayer() async
{
	final client = MockClient((req) async {
		expect(req.method, "DELETE");
		expect(req.url.path, equals("/api/teams/teamId/player/playerId"));
		return http.Response(json.encode({}), 200);
	});

	TeamApi api = TeamApi.createWith(client, true);

	var res = await  api.deleteTeamPlayer("teamId", "playerId");

	expect(res.isSuccessful, true);
}

void addEvent() async
{
	final client = MockClient((req) async {
		expect(req.method, "POST");
		expect(req.url.path, equals("/api/teams/teamId/events"));
		return http.Response(json.encode({
			"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
			"name": "string",
			"description": "string",
			"start": "2020-05-29T08:20:24.531Z",
			"end": "2020-05-29T08:20:24.531Z",
			"type": 0,
			"participations": [
				{
					"confirmed": true,
					"userId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
					"username": "string"
				}
			],
			"discrepancies": [
				{
					"id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
					"userId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
					"username": "string",
					"type": 0,
					"reason": "string",
					"delayLength": 0
				}
			]
		}), 200);
	});

	TeamApi api = TeamApi.createWith(client, true);

	var res = await  api.addEvent("teamId", Event(
		name: "string",
		description: "string",
		start: "2020-05-29T09:10:38.899Z",
		end: "2020-05-29T09:10:38.899Z",
		type: 0
	));

	expect(res.isSuccessful, true);
	expect(res.body.id, "3fa85f64-5717-4562-b3fc-2c963f66afa6");
}