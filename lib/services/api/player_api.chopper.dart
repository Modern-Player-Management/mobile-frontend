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
    final $url = '/api/users?search=$username';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<Player>, Player>($request);
  }

  @override
  Future<Response<dynamic>> updatePlayer(Player player) {
    final $url = '/api/users';
    final $body = player;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
