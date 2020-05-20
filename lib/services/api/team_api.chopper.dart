// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$TeamApi extends TeamApi {
  _$TeamApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TeamApi;

  @override
  Future<Response<List<Team>>> getTeams() {
    final $url = '/api/teams';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<Team>, Team>($request);
  }

  @override
  Future<Response<Team>> createTeam(Team team) {
    final $url = '/api/teams';
    final $body = team;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Team, Team>($request);
  }

  @override
  Future<Response<Team>> updateTeam(String teamId, Team team) {
    final $url = '/api/teams/$teamId';
    final $body = team;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<Team, Team>($request);
  }

  @override
  Future<Response<dynamic>> deleteTeam(String teamId) {
    final $url = '/api/teams/$teamId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Team>> addUser(String teamId, Player playerId) {
    final $url = '/api/teams/{teamId}/player';
    final $body = teamId;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Team, Team>($request);
  }

  @override
  Future<Response<dynamic>> deleteUser(String teamId, String playerId) {
    final $url = '/api/teams/$teamId/player/$playerId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
