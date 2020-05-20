import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class SecureStorage {
	final _storageToken = "token";
	final _storagePlayer = "player";

	final _storage = new FlutterSecureStorage();

	String _token, _player;

	String get player => _player;
	set player(String player) 
	{
		_player = player;
		if(player == null) 
		{
			_storage.delete(key: _storagePlayer);
		}
		else 
		{
			_storage.write(key: _storagePlayer, value: _player);
		}
	}

	String get token => _token;
	set token(String token) 
	{
		_token = token;
		if(token == null) 
		{
			_storage.delete(key: _storageToken);
		}
		else 
		{
			_storage.write(key: _storageToken, value: _token);
		}
	}
}