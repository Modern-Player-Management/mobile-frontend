// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$PlayerApi extends PlayerApi {
  _$PlayerApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PlayerApi;

  @override
  Future<Response<List<Player>>> searchPlayers(String username) {
    final $url = '/search/';
    final $params = <String, dynamic>{'search': username};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Player>, Player>($request);
  }

  @override
  Future<Response<Player>> getPlayer(String username) {
    final $url = '/$username';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Player, Player>($request);
  }

  @override
  Future<Response<dynamic>> updatePlayer(String playerId, Player player) {
    final $url = '/$playerId';
    final $body = player;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Player>> getProfile() {
    final $url = '/profile';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<Player, Player>($request);
  }
}
