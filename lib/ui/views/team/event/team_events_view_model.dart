import 'package:flutter/material.dart';
import 'package:mpm/utils/toast_factory.dart';

import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/ui/views/team/team_view_model.dart';
import 'package:mpm/utils/dialogs.dart';

class TeamCalendarViewModel extends StreamViewModel<Map<DateTime, List<Event>>>
{
	final _eventManager = locator<EventManager>();
	final _eventDao = locator<AppDatabase>().eventDao;
	final _eventTypeDao = locator<AppDatabase>().eventTypeDao;

	final _navigation = locator<NavigationService>();

	DateTime _selectedDate;
	final BuildContext context;
	TeamViewModel _teamViewModel;

	List<Event> selectedEvents = [];

	final calendarController = CalendarController();

	bool get isManager => _teamViewModel.isManager;

	TeamCalendarViewModel({
		@required this.context
	})
	{
		_teamViewModel = getParentViewModel<TeamViewModel>(context);
	}

	@override
	get stream async * {
		var eventTypes = await _eventTypeDao.get();
		List<String> types = eventTypes.map((e) => e.name).toList();

		await for(var events in _eventDao.getStream(_teamViewModel.team.id))
		{
			Map<DateTime, List<Event>> map = {};

			for(var event in events)
			{
				event.typeName = types[event.type];

				var date = event.startDate;
				date = DateTime(date.year, date.month, date.day);

				if(map.containsKey(date))
				{
					map[date].add(event);
				}
				else
				{
					map[date] = [event];
				}
			}

			if(_selectedDate == null)
			{
				_selectedDate = DateTime.now();
				_selectedDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
			}

			selectedEvents = map[_selectedDate] ?? [];

			yield map;
		}
	}

	void onDaySelected(DateTime date, List<dynamic> events)
	{
		_selectedDate = DateTime(date.year, date.month, date.day);
		selectedEvents = List.from(events);
		notifyListeners();
	}

	void presence(Event event) async
	{
		showLoadingDialog(context);

		var res = await _eventManager.presence(event, !event.currentHasConfirmed);

		_navigation.back();

		if(!res)
		{
			ToastFactory.show(
				context: context, 
				msg: "Failed to confirm presence to the event",
				style: ToastStyle.error
			);
		}
	}

	void delay(Event event)
	{
		_navigation.navigateTo(
			Routes.discrepancyView,
			arguments: DiscrepancyViewArguments(
				event: event
			)
		);
	}

	void delete(Event event, int index) async
	{
		showLoadingDialog(context);

		var res = await _eventManager.delete(event);

		if(!res)
		{
			ToastFactory.show(
				context: context, 
				msg: "Failed to delete the event",
				style: ToastStyle.error
			);
		}

		_navigation.back();
	}

	void updateEvent(Event event)
	{
		_navigation.navigateTo(
			Routes.manageEventView,
			arguments: ManageEventViewArguments(
				team: _teamViewModel.team,
				event: event
			)
		);
	}
}