import 'package:flutter/material.dart';
import 'package:mpm/utils/toast_factory.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/utils.dart';

class ManageEventViewModel extends BaseViewModel
{
	final BuildContext context;
	final Team team;
	final Event event;
	final bool isEdit;

	DateTime start;
	DateTime end;

	final _navigation = locator<NavigationService>();

	final formKey = GlobalKey<FormState>();

	ManageEventViewModel({
		@required this.context,
		@required this.team,
		Event event
	}) :
		this.isEdit = event != null,
		this.event = event ?? Event()
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

	void manageEvent() async
	{

	}
}