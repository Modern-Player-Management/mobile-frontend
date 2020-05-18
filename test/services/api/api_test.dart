import 'package:flutter_test/flutter_test.dart';

import 'auth_api_test.dart';

void api_tests()
{
	group('simple auth tests', (){
		test('register request', register);
		test('authenticate request', authenticate);
	});
}