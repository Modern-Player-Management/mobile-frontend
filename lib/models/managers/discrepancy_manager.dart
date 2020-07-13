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

		await _saveUnsavedDiscrepancies(event);
		await _deleteUndeletedDiscrepancies(event);

		var models = await _discrepancyDao.getSaved(event.id);
		var keys = [
			for(var el in models)
				el.id
		];

		for(var discrepancy in event.discrepancies)
		{
			discrepancy.eventId = event.id;
			await _discrepancyDao.insertModel(discrepancy);

			int index = keys.indexOf(event.id);
			if(index != -1)
			{
				models.removeAt(index);
				keys.removeAt(index);
			}
		}

		for(var model in models)
		{
			await _discrepancyDao.deleteModel(model);
		}
	}

	Future<void> _saveUnsavedDiscrepancies(Event event) async
	{
		for(var discrepancy in await _discrepancyDao.getUnsaved(event.id))
		{
			try
			{
				if(discrepancy.create)
				{
					var res = await _eventApi.addDiscrepancy(event.id, discrepancy);
					if(validResponse(res))
					{
						var id = res.body.id;
						_discrepancyDao.updateId(discrepancy.id, id);
						discrepancy.id = id;
						discrepancy.saved = true;
						discrepancy.create = false;
						await _discrepancyDao.updateModel(discrepancy);
					}
				}
				else
				{
					var res = await _discrepancyApi.updateDiscrepancy(discrepancy.id, discrepancy);
					if(validResponse(res))
					{
						discrepancy.saved = true;
						await _discrepancyDao.updateModel(discrepancy);
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

	Future<void> _deleteUndeletedDiscrepancies(Event event) async
	{
		for(var discrepancy in await _discrepancyDao.getUndeleted(event.id))
		{
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