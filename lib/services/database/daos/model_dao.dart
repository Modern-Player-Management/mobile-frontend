import 'package:floor/floor.dart';

abstract class ModelDao<T>
{
	@Insert(
		onConflict: OnConflictStrategy.replace
	)
	Future<int> insertModel(T model);

	@update
	Future<int> updateModel(T model);

	@delete
	Future<int> deleteModel(T model);
}