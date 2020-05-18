import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity/connectivity.dart';

// check the permissions in the list
Future<bool> checkPermissions(List<Permission> perms) async {
	for(var perm in perms) {
		if(!await perm.isGranted) {
			return false;
		}
	}

	return true;
}

// request the permissions in the list
Future<bool> requestPermissions(List<Permission> perms) async {
	var permissions = await perms.request();
	return permissions.values.every((permission) => permission == PermissionStatus.granted);
}

// check if we got internet access
Future<bool> checkInternet() async {
	var connectivityResult = await (Connectivity().checkConnectivity());
	return connectivityResult == ConnectivityResult.mobile || 
		connectivityResult == ConnectivityResult.wifi;
}