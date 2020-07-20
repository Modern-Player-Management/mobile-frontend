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
	final _eventTypeDao = locator<AppDatabase>().eventTypeDao;

	final _storage = locator<SecureStorage>();
	final _uuid = locator<Uuid>();

	DiscrepancyManager _discrepancyManager;

	bool Function(Response) validResponse;

	EventManager({
		@required @factoryParam Function validResponse
	}) : this.validResponse = validResponse
	{
		_discrepancyManager = locator<DiscrepancyManager>(param1: validResponse);
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
		
		await _saveUnsavedEvents(team);
		await _deleteUndeletedEvents(team);

		await _syncTypes();

		var models = await _eventDao.getSaved(team.id);
		var keys = [
			for(var el in models)
				el.id
		];

		for(var event in team.events)
		{
			event.teamId = team.id;
			await _eventDao.insertModel(event);
			int index = keys.indexOf(event.id);
			if(index != -1)
			{
				models.removeAt(index);
				keys.removeAt(index);
			}

			await _discrepancyManager.syncDiscrepancies(event);
		}

		for(var model in models)
		{
			await _eventDao.deleteModel(model);
		}
	}

	Future<void> _saveUnsavedEvents(Team team) async
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
						await _eventDao.deleteModel(event);

						event.id = res.body.id;
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

	Future<void> _deleteUndeletedEvents(Team team) async
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

	Future<void> _syncTypes() async
	{
		try
		{
			var res = await _eventApi.getEventTypes();
			if(validResponse(res))
			{
				var types = res.body;

				for(int i = 0; i < types.length; i++)
				{
					_eventTypeDao.insertModel(EventType(
						index: i,
						name: types[i]
					));
				}
			}
		}
		catch(e)
		{
			print("syncTypes: $e");
		}
	}

	Future<bool> insert(Team team, Event event) async
	{
		_checkValidResponse();

		event.id = _uuid.v1();
		event.teamId = team.id;
		event.create = true;

		await _eventDao.insertModel(event);

		try
		{
			var response = await _teamApi.addEvent(team.id, event);
			if(validResponse(response))
			{
				await _eventDao.deleteModel(event);

				event.id = response.body.id;
				event.saved = true;
				event.create = false;
				await _eventDao.insertModel(event);
				return true;
			}
		}
		catch(e)
		{
			print("insertEvent: $e");
		}

		return false;
	}

	Future<bool> update(Event event) async
	{
		_checkValidResponse();

		event.saved = false;
		await _eventDao.updateModel(event);

		try
		{
			var response = await _eventApi.updateEvent(event.id, event);
			if(validResponse(response))
			{
				event.saved = true;
				await _eventDao.updateModel(event);
				return true;
			}
		}
		catch(e) 
		{
			print("updateEvent: $e");
		}

		return false;
	}

	Future<bool> delete(Event event) async
	{
		_checkValidResponse();

		event.deleted = true;
		await _eventDao.updateModel(event);

		try
		{
			var response = await _eventApi.deleteEvent(event.id);
			if(validResponse(response))
			{
				await _eventDao.deleteModel(event);
				return true;
			}
		}
		catch(e) 
		{
			print("deleteEvent: $e");
		}

		return false;
	}

	Future<bool> presence(Event event, bool confirmed) async
	{
		_checkValidResponse();

		try
		{
			var response = await _eventApi.presence(event.id, Participation(
				confirmed: confirmed
			));
			if(validResponse(response))
			{
				event.currentHasConfirmed = confirmed;
				await _eventDao.updateModel(event);
				return true;
			}
		}
		catch(e) 
		{
			print("presence: $e");
		}

		return false;
	}
}