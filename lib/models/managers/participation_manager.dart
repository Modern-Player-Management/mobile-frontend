import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';

@injectable
class ParticipationManager
{
	final _eventApi = locator<EventApi>();

	final _participationDao = locator<AppDatabase>().participationDao;

	final _storage = locator<SecureStorage>();

	bool Function(Response) validResponse;

	ParticipationManager({
		@required @factoryParam Function validResponse
	}) : this.validResponse = validResponse;

	void _checkValidResponse()
	{
		if(validResponse == null)
		{
			validResponse = locator<Session>().validResponse;
		}
	}

	Future<void> syncParticipations(Event event) async
	{
		if(_storage.token == null)
		{
			return;
		}

		_checkValidResponse();
		_saveUnsavedParticipations(event);
		_deleteUndeletedParticipations(event);

		var models = await _participationDao.getSaved(event.id);
		var keys = [
			for(var el in models)
				el.id
		];

		for(var participation in event.participations)
		{
			await _participationDao.insertModel(participation);

			int index = keys.indexOf(event.id);
			if(index != -1)
			{
				models.removeAt(index);
				keys.removeAt(index);
			}
		}

		for(var model in models)
		{
			await _participationDao.deleteModel(model);
		}
	}

	void _saveUnsavedParticipations(Event event) async
	{
		for(var participation in await _participationDao.getUnsaved(event.id))
		{
			try
			{
				if(participation.create)
				{
					var res = await _eventApi.presence(event.id, participation);
					if(validResponse(res))
					{
						var id = res.body.id;
						_participationDao.updateId(participation.id, id);
						participation.id = id;
						participation.saved = true;
						participation.create = false;
						await _participationDao.updateModel(participation);
					}
				}
				else
				{
					var res = await _eventApi.presence(event.id, participation);
					if(validResponse(res))
					{
						participation.saved = true;
						await _participationDao.updateModel(participation);
					}
				}
			}
			catch(e)
			{
				print("saveUnsavedParticipations: $e");
				return;
			}
		}
	}

	void _deleteUndeletedParticipations(Event event) async
	{
		for(var participation in await _participationDao.getUndeleted(event.id))
		{
			try
			{
				var res = await _eventApi.presence(event.id, participation);
				if(validResponse(res))
				{
					await _participationDao.deleteModel(participation);
				}
			}
			catch(e)
			{
				print("deleteUndeletedParticipations: $e");
				return;
			}
		}
	}
}