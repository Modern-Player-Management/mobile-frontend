import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';

@injectable
class DiscrepancyManager
{
	final _eventApi = locator<EventApi>();
	final _discrepancyApi = locator<DiscrepancyApi>();

	final _discrepancyDao = locator<AppDatabase>().discrepancyDao;
	final _eventDiscrepancyDao = locator<AppDatabase>().eventDiscrepancyDao;

	final _storage = locator<SecureStorage>();

	bool Function(Response) validResponse;

	DiscrepancyManager({
		@required @factoryParam Function validResponse
	}) : this.validResponse = validResponse;

	void _checkValidResponse()
	{
		if(validResponse == null)
		{
			validResponse = locator<Session>().validResponse;
		}
	}

	Future<void> syncDiscrepancies(Event event) async
	{
		if(_storage.token == null)
		{
			return;
		}

		_checkValidResponse();
		_saveUnsavedDiscrepancies(event);
		_deleteUndeletedDiscrepancies(event);
	}

	void _saveUnsavedDiscrepancies(Event event) async
	{
		for(var eventDiscrepancy in await _eventDiscrepancyDao.getUnsaved(event.id))
		{
			Discrepancy discrepancy = await _discrepancyDao.get(eventDiscrepancy.discrepancyId);

			try
			{
				if(discrepancy.create)
				{
					var res = await _eventApi.addDiscrepancy(event.id, discrepancy);
					if(validResponse(res))
					{
						eventDiscrepancy.saved = true;
						await _eventDiscrepancyDao.updateModel(eventDiscrepancy);

						var id = res.body.id;
						_discrepancyDao.updateId(discrepancy.id, id);
						discrepancy.id = id;
						discrepancy.create = false;
						await _discrepancyDao.updateModel(discrepancy);
					}
				}
				else
				{
					var res = await _discrepancyApi.updateDiscrepancy(discrepancy.id, discrepancy);
					if(validResponse(res))
					{
						eventDiscrepancy.saved = true;
						await _eventDiscrepancyDao.updateModel(eventDiscrepancy);
					}
				}
			}
			catch(e)
			{
				print("saveUnsavedDiscrepancies: $e");
				return;
			}
		}
	}

	void _deleteUndeletedDiscrepancies(Event event) async
	{
		for(var eventDiscrepancy in await _eventDiscrepancyDao.getUndeleted(event.id))
		{
			Discrepancy discrepancy = await _discrepancyDao.get(eventDiscrepancy.discrepancyId);

			try
			{
				var res = await _discrepancyApi.deleteDiscrepancy(discrepancy.id);
				if(validResponse(res))
				{
					await _discrepancyDao.deleteModel(discrepancy);
				}
			}
			catch(e)
			{
				print("deleteUndeletedDiscrepancies: $e");
				return;
			}
		}
	}
}