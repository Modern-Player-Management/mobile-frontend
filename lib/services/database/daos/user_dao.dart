import 'package:floor/floor.dart';

import 'package:mpm/services/database/models/user.dart';

@dao
abstract class UserDao
{
	@Query('select * from users `delete` = 0')
	Stream<List<User>> getUsers();

	@Query('select * from users save = 1 and `delete` = 0')
	Future<List<User>> getSavedUsers();

	@Query('select * from users save = 0 and `delete` = 0')
	Future<List<User>> getUnsavedUsers();

	@Query('select * from users `delete` = 1')
	Future<List<User>> getUndeletedUsers();

	@insert
	Future<int> insertUser(User team);

	@update
	Future<int> updateUser(User team);

	@delete
	Future<int> deleteUser(User team);
}