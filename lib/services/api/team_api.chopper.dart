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
  Future<Response<Team>> createTeam(Team team) {
    final $url = '/';
    final $body = team;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Team, Team>($request);
  }

  @override
  Future<Response<List<Team>>> getTeams() {
    final $url = '/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<Team>, Team>($request);
  }

  @override
  Future<Response<Team>> getTeam() {
    final $url = '/{teamId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Team, Team>($request);
  }

  @override
  Future<Response<dynamic>> updateTeam(String teamId, Team team) {
    final $url = '/$teamId';
    final $body = team;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteTeam(String teamId) {
    final $url = '/$teamId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> addTeamPlayer(String teamId, String playerId) {
    final $url = '/$teamId/player/$playerId';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteTeamPlayer(String teamId, String playerId) {
    final $url = '/$teamId/player/$playerId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Event>> addEvent(String teamId, Event event) {
    final $url = '/$teamId/events';
    final $body = event;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Event, Event>($request);
  }

  @override
  Future<Response<Event>> addGame(String teamId, MultipartFile file) {
    final $url = '/$teamId/games';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<Event, Event>($request);
  }

  @override
  Future<Response<PlayerStats>> getPlayerStats() {
    final $url = '/{teamId}/stats';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<PlayerStats, PlayerStats>($request);
  }
}
