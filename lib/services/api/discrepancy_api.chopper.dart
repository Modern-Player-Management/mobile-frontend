// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discrepancy_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$DiscrepancyApi extends DiscrepancyApi {
  _$DiscrepancyApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = DiscrepancyApi;

  @override
  Future<Response<Discrepancy>> updateDiscrepancy(
      String discrepancyId, Discrepancy discrepancy) {
    final $url = '/$discrepancyId';
    final $body = discrepancy;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<Discrepancy, Discrepancy>($request);
  }

  @override
  Future<Response<dynamic>> deleteDiscrepancy(String discrepancyId) {
    final $url = '/$discrepancyId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
