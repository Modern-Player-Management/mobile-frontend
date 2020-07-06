import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import 'package:mpm/app/locator.dart';

@injectable
class EventManager
{
	final _teamApi = locator<TeamApi>();
	final _eventApi = locator<EventApi>();

	final _eventDao = locator<AppDatabase>().eventDao;

	final _storage = locator<SecureStorage>();

	DiscrepancyManager _discrepancyManager;
	ParticipationManager _participationManager;

	bool Function(Response) validResponse;

	EventManager({
		@required @factoryParam Function validResponse
	}) : this.validResponse = validResponse
	{
		_discrepancyManager = locator<DiscrepancyManager>(param1: validResponse);
		_participationManager = locator<ParticipationManager>(param1: validResponse);
	}

	void _checkValidResponse()
	{
		if(validResponse == null)
		{
			validResponse = locator<Session>().validResponse;
		}
	}

	Future<void> syncEvents(Team team) async
	{
		if(_storage.token == null)
		{
			return;
		}

		_checkValidResponse();
		_saveUnsavedEvents(team);
		_deleteUndeletedEvents(team);

		var models = await _eventDao.getSaved(team.id);
		var keys = [
			for(var el in models)
				el.id
		];

		for(var event in team.events)
		{
			await _eventDao.insertModel(event);
			int index = keys.indexOf(event.id);
			if(index != -1)
			{
				models.removeAt(index);
				keys.removeAt(index);
			}

			await _discrepancyManager.syncDiscrepancies(event);
			await _participationManager.syncParticipations(event);
		}

		for(var model in models)
		{
			await _eventDao.deleteModel(model);
		}
	}

	void _saveUnsavedEvents(Team team) async
	{
		for(var event in await _eventDao.getUnsaved(team.id))
		{
			try
			{
				if(event.create)
				{
					var res = await _teamApi.addEvent(team.id, event);
					if(validResponse(res))
					{
						var id = res.body.id;
						_eventDao.updateId(team.id, id);
						event.id = id;
						event.create = false;
						event.saved = true;
						await _eventDao.updateModel(event);
					}
				}
				else
				{
					var res = await _eventApi.updateEvent(team.id, event);
					if(validResponse(res))
					{
						event.saved = true;
						await _eventDao.updateModel(event);
					}
				}
			}
			catch(e)
			{
				print("saveUnsavedEvents: $e");
				return;
			}
		}
	}

	void _deleteUndeletedEvents(Team team) async
	{
		for(var event in await _eventDao.getUndeleted(team.id))
		{
			try
			{
				var res = await _eventApi.deleteEvent(event.id);
				if(validResponse(res))
				{
					await _eventDao.deleteModel(event);
				}
			}
			catch(e)
			{
				print("deleteUndeletedEvents: $e");
				return;
			}
		}
	}
}