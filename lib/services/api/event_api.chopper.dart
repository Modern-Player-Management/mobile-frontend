// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$EventApi extends EventApi {
  _$EventApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = EventApi;

  @override
  Future<Response<dynamic>> confirm(String eventId) {
    final $url = '/$eventId/presence';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Discrepancy>> addDiscrepancy(
      String eventId, Discrepancy discrepancy) {
    final $url = '/$eventId/discrepancies';
    final $body = discrepancy;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Discrepancy, Discrepancy>($request);
  }

  @override
  Future<Response<Event>> updateEvent(String eventId, Event event) {
    final $url = '/$eventId';
    final $body = event;
    final $request = Request('PUT', $url, client.baseUrl, body: $body);
    return client.send<Event, Event>($request);
  }

  @override
  Future<Response<dynamic>> deleteEvent(String eventId) {
    final $url = '/$eventId';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getIcal(String icalSecret) {
    final $url = '/ical/$icalSecret';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> getEventTypes() {
    final $url = '/ical/{icalSecret}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<String>, String>($request);
  }
}
