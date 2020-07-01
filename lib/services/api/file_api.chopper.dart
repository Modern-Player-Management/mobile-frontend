// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$FileApi extends FileApi {
  _$FileApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = FileApi;

  @override
  Future<Response<Map<String, dynamic>>> uploadFile(MultipartFile file) {
    final $url = '/';
    final $parts = <PartValue>[PartValueFile<MultipartFile>('file', file)];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<String>> getFile(String fileId) {
    final $url = '/$fileId';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<String, String>($request);
  }
}
