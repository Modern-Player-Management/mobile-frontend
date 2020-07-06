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
	final _teamEventDao = locator<AppDatabase>().teamEventDao;

	final _storage = locator<SecureStorage>();

	bool Function(Response) validResponse;

	EventManager({
		@required @factoryParam Function validResponse
	}) : this.validResponse = validResponse;

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
	}

	void _saveUnsavedEvents(Team team) async
	{
		for(var teamEvent in await _teamEventDao.getUnsaved(team.id))
		{
			Event event = await _eventDao.get(teamEvent.eventId);

			try
			{
				if(event.create)
				{
					var res = await _teamApi.addEvent(team.id, event);
					if(validResponse(res))
					{
						teamEvent.saved = true;
						await _teamEventDao.updateModel(teamEvent);
						
						var id = res.body.id;
						_eventDao.updateId(team.id, id);
						event.id = id;
						event.create = false;
						await _eventDao.updateModel(event);
					}
				}
				else
				{
					var res = await _eventApi.updateEvent(team.id, event);
					if(validResponse(res))
					{
						teamEvent.saved = true;
						await _teamEventDao.updateModel(teamEvent);
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
		for(var teamEvent in await _teamEventDao.getUndeleted(team.id))
		{
			Event event = await _eventDao.get(teamEvent.eventId);

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