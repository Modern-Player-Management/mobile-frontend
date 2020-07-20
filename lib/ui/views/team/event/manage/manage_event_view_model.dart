import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/utils.dart';
import 'package:mpm/utils/toast_factory.dart';
import 'package:mpm/utils/dialogs.dart';

class ManageEventViewModel extends FutureViewModel<List<EventType>>
{
	final BuildContext context;
	final Team team;
	final Event event;
	final bool isEdit;

	DateTime start;
	DateTime end;

	final _eventTypeDao = locator<AppDatabase>().eventTypeDao;
	final _eventManager = locator<EventManager>();
	final _navigation = locator<NavigationService>();

	final formKey = GlobalKey<FormState>();

	String get type {
		if(event?.type != null && data != null && data.isNotEmpty)
		{
			return data[event.type].name;
		}

		return "Select a type";
	} 


	ManageEventViewModel({
		@required this.context,
		@required this.team,
		Event event
	}) :
		this.isEdit = event != null,
		this.event = event ?? Event(currentHasConfirmed: false),
		this.start = event?.startDate,
		this.end = event?.endDate;

	@override
	Future<List<EventType>> futureToRun() => _eventTypeDao.get();

	String nameValidator(String str)
	{
		if(str.isEmpty || str.length < minCharacters)
		{
			return "You must enter a name with at least 3 characters";
		}

		return null;
	}

	String descriptionValidator(String str)
	{
		if(str.isEmpty || str.length < minCharacters)
		{
			return "You must enter a description with at least 3 characters";
		}

		return null;
	}

	bool onSelectStartDate(DateTime date)
	{
		if(end != null)
		{
			if(end.isBefore(date))
			{
				ToastFactory.show(
					context: context, 
					msg: "You can't select a start date after your end date",
					style: ToastStyle.error,
					duration: Duration(seconds: 4)
				);
				return false;
			}
		}

		start = date;
		event.start = start.toIso8601String();

		return true;
	}

	bool onSelectEndDate(DateTime date)
	{
		if(start != null)
		{
			if(start.isAfter(date))
			{
				ToastFactory.show(
					context: context, 
					msg: "You can't select an end date before your start date",
					style: ToastStyle.error,
					duration: Duration(seconds: 4)
				);
				return false;
			}
		}

		end = date;
		event.end = end.toIso8601String();

		return true;
	}

	void selectEventType()
	{
		Picker(
			itemExtent: 48,
			adapter: PickerDataAdapter<EventType>(
				pickerdata: data
			),
			onConfirm: (picker, selected) {
				event.type = selected[0];
				notifyListeners();
			}
		).showModal(context);
	}

	void manageEvent() async
	{
		if(formKey.currentState.validate())
		{
			if(event.type == null)
			{
				ToastFactory.show(
					context: context, 
					msg: "You must select an event type",
					style: ToastStyle.error
				);
				return;
			}

			showLoadingDialog(context);
			formKey.currentState.save();

			bool res = false;
			dynamic result;

			if(isEdit)
			{
				res = await _eventManager.update(event);
				if(res)
				{
					result = event;
				}
			}
			else
			{
				res = await _eventManager.insert(team, event);
			}

			_navigation.back();
			_navigation.back(result: result);
		}
	}
}