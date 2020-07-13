import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'package:mpm/services/database/models/event.dart';
import 'package:mpm/services/database/models/team.dart';
import 'package:mpm/ui/views/team/event/manage/manage_event_view_model.dart';
import 'package:mpm/ui/widgets/button.dart';
import 'package:mpm/ui/widgets/date_picker.dart';

class ManageEventView extends ViewModelBuilderWidget<ManageEventViewModel>
{
	final Team team;
	final Event event;

	ManageEventView({
		@required this.team,
		this.event,
	});

	@override
	bool get reactive => false;

	@override
	Widget builder(context, model, child)
	{
		return Scaffold(
			resizeToAvoidBottomInset: false,
			appBar: AppBar(
				title: Text(
					"${model.isEdit ? "Edit" : "Create"} an event"
				),
			),
			body: Padding(
				padding: const EdgeInsets.all(8.0),
				child: Form(
					key: model.formKey,
					child: Column(
						children: <Widget>[
							_NameTextField(),
							_DescriptionTextField(),
							SizedBox(height: 4),
							_Dates(),
							_Type(),
						],
					),
				),
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
			floatingActionButton: Button(
				child: Text(
					model.isEdit ? "Edit" : "Create"
				),
				color: Colors.green,
				onPressed: model.manageEvent,
			),
		);
	}

	@override
	ManageEventViewModel viewModelBuilder(context)
	{
		return ManageEventViewModel(
			context: context,
			team: team,
			event: event
		);
	}
}

class _NameTextField extends HookViewModelWidget<ManageEventViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.event.name,
			decoration: InputDecoration(
				labelText: "Name",
				prefixIcon: Icon(
					Icons.title,
					size: 32,
				),
			),
			validator: model.descriptionValidator,
			onChanged: (str) => model.event.name = str,
			onSaved: (str) => model.event.name = str,
		);
	}
}

class _DescriptionTextField extends HookViewModelWidget<ManageEventViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.event.description,
			decoration: InputDecoration(
				labelText: "Description",
				prefixIcon: Icon(
					Icons.description,
					size: 32,
				),
			),
			validator: model.nameValidator,
			onChanged: (str) => model.event.description = str,
			onSaved: (str) => model.event.description = str,
		);
	}
}

class _Dates extends ViewModelWidget<ManageEventViewModel>
{
	@override
	Widget build(context, model)
	{
		return Column(
			mainAxisSize: MainAxisSize.min,
			children: <Widget>[
				DatePicker(
					initialDate: model.start,
					onSelectDate: model.onSelectStartDate,
					selectText: "Select a start date",
				),
				DatePicker(
					initialDate: model.end,
					onSelectDate: model.onSelectEndDate,
					selectText: "Select an end date",
				),
			],
		);
	}
}

class _Type extends ViewModelWidget<ManageEventViewModel>
{
	@override
	Widget build(context, model)
	{
		return Card(
			child: InkWell(
				child: Row(
					children: <Widget>[
						Padding(
							padding: const EdgeInsets.all(16),
							child: Text(
								model.type,
								style: Theme.of(context).textTheme.subtitle1,
							),
						),

					],
				),
				onTap: model.selectEventType,
			)
		);
	}
}