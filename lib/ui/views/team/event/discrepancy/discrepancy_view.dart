import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'package:mpm/services/database/models/event.dart';
import 'package:mpm/ui/views/team/event/discrepancy/discrepancy_view_model.dart';
import 'package:mpm/ui/widgets/button.dart';

class DiscrepancyView extends ViewModelBuilderWidget<DiscrepancyViewModel>
{
	final Event event;

	DiscrepancyView({
		@required this.event
	});

	@override
	Widget builder(context, model, child)
	{
		return Scaffold(
			appBar: AppBar(
				title: Text(
					"Add a discrepancy"
				),
			),
			body: Padding(
				padding: const EdgeInsets.all(8.0),
				child: Form(
					key: model.formKey,
					child: Column(
						children: <Widget>[
							_ReasonTextField(),
							SizedBox(height: 8),
							_Delay()
						],
					),
				),
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
			floatingActionButton: Button(
				child: Text(
					"Create"
				),
				color: Colors.green,
				onPressed: model.save,
			),
		);
	}
  
	@override
	DiscrepancyViewModel viewModelBuilder(context)
	{
		return DiscrepancyViewModel(
			event: event,
			context: context
		);
	}
}

class _ReasonTextField extends HookViewModelWidget<DiscrepancyViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			decoration: InputDecoration(
				labelText: "Reason *",
				prefixIcon: Icon(
					Icons.text_fields,
					size: 32,
				),
			),
			validator: model.reasonValidator,
			onSaved: model.saveReason
		);
	}
}

class _Delay extends ViewModelWidget<DiscrepancyViewModel>
{	
	@override
	Widget build(context, model)
	{
		return Card(
			child: ListTile(
				leading: Icon(
					Icons.timelapse
				),
				title: Text(
					model.delay
				),
				onTap: model.pickDelay,
			),
		);
	}
}