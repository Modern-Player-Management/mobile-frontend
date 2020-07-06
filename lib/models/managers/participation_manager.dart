import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';

@injectable
class ParticipationManager
{
	final _eventApi = locator<EventApi>();

	final _participationDao = locator<AppDatabase>().participationDao;
	final _eventParticipationDao = locator<AppDatabase>().eventParticipationDao;

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
	}

	void _saveUnsavedParticipations(Event event) async
	{
		for(var eventParticipation in await _eventParticipationDao.getUnsaved(event.id))
		{
			Participation participation = await _participationDao.get(eventParticipation.participationId);

			try
			{
				var res = await _eventApi.presence(event.id, participation);
				if(validResponse(res))
				{
					eventParticipation.saved = true;
					await _eventParticipationDao.updateModel(eventParticipation);

					var id = res.body.id;
					_participationDao.updateId(participation.id, id);
					participation.id = id;
					await _participationDao.updateModel(participation);
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
		for(var eventDiscrepancy in await _eventParticipationDao.getUndeleted(event.id))
		{
			Participation participation = await _participationDao.get(eventDiscrepancy.participationId);

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