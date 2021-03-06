import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/utils.dart';

part 'file_api.chopper.dart';

@ChopperApi()
@lazySingleton
abstract class FileApi extends ChopperService
{
	@factoryMethod
	static FileApi create() => createWith();

	@factoryMethod
	static FileApi createWith([http.BaseClient client])
	{
		return _$FileApi(ChopperClient(
			client: IOClient(
				HttpClient()..connectionTimeout = Duration(seconds: 2),
			),
			baseUrl: '$serverUrl/Files',
			interceptors: [
				(Request request) {
					final headers = Map<String, String>.from(request.headers);
					var token = GetIt.instance<SecureStorage>().token;
					headers['Authorization'] = 'Bearer $token';
					return request.copyWith(headers: headers);
				}
			]
		));
	}

	// Files requests

	@Post(path: "/")
	@multipart
	Future<Response<Map<String , dynamic>>> uploadFile(@PartFile() MultipartFile file);

	@Get(path: "/{fileId}")
	Future<Response<String>> getFile(@Path() String fileId);
}