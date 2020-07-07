import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:flutter_picker/flutter_picker.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/utils.dart';
import 'package:mpm/utils/toast_factory.dart';

class ManageEventViewModel extends FutureViewModel<List<EventType>>
{
	final BuildContext context;
	final Team team;
	final Event event;
	final bool isEdit;

	DateTime start;
	DateTime end;

	final _eventTypeDao = locator<AppDatabase>().eventTypeDao;
	final _navigation = locator<NavigationService>();

	final formKey = GlobalKey<FormState>();
	final scaffoldKey = GlobalKey<ScaffoldState>();

	String get type {
		if(event?.type != null && data.isNotEmpty)
		{
			return data[event.type].name;
		}

		return "Select an event type";
	} 


	ManageEventViewModel({
		@required this.context,
		@required this.team,
		Event event
	}) :
		this.isEdit = event != null,
		this.event = event ?? Event(currentHasConfirmed: false)
	{
		if(event?.start != null && event.start.isNotEmpty)
		{
			start = DateTime.parse(event.start);
		}

		if(event?.end != null && event.end.isNotEmpty)
		{
			end = DateTime.parse(event.end);
		}
	}

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

	void onChanged(bool value)
	{
		event.currentHasConfirmed = value;
		notifyListeners();
	}

	void manageEvent() async
	{

	}
}