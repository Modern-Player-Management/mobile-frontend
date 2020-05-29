// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$AuthApi extends AuthApi {
  _$AuthApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = AuthApi;

  @override
  Future<Response<String>> register(
      String username, String email, String password) {
    final $url = '/register';
    final $body = <String, dynamic>{
      'username': username,
      'email': email,
      'password': password
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<String, String>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> authenticate(
      String username, String password) {
    final $url = '/authenticate';
    final $body = <String, dynamic>{'username': username, 'password': password};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> available(String username) {
    final $url = '/available';
    final $body = <String, dynamic>{'username': username};
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
