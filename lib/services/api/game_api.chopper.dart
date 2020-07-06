// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$GameApi extends GameApi {
  _$GameApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = GameApi;

  @override
  Future<Response<dynamic>> deleteGame(String gameId) {
    final $url = '/$gameId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
