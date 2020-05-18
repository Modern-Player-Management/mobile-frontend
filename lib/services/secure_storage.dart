import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class SecureStorage
{
	final _storageToken = "token";
	final _storageUser = "user";

	final _storage = new FlutterSecureStorage();

	String _token, _user;

	String get user => _user;
	set user(String user){
		_user = user;
		if(user == null){
			_storage.delete(key: _storageUser);
		}
		else {
			_storage.write(key: _storageUser, value: _user);
		}
	}

	String get token => _token;
	set token(String token){
		_token = token;
		if(token == null){
			_storage.delete(key: _storageToken);
		}
		else {
			_storage.write(key: _storageToken, value: _token);
		}
	}
}