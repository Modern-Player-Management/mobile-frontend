import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'package:mpm/ui/views/team/create_team/create_team_view_model.dart';
import 'package:mpm/ui/widgets/button.dart';

class CreateTeamView extends ViewModelBuilderWidget<CreateTeamViewModel>
{
	@override
  	bool get reactive => false;

  	@override
  	Widget builder(context, model, child)
	{
		return Scaffold(
			appBar: AppBar(
				title: Text(
					"Create a team"
				),
			),
			body: Padding(
				padding: const EdgeInsets.all(8.0),
				child: Form(
					key: model.formKey,
					child: Column(
						children: <Widget>[
							_ImagePicker(),
							SizedBox(height: 8),
							_NameTextField(),
							_DescriptionTextField(),
						],
					),
				),
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
			floatingActionButton: Button(
				child: Text(
					"Create a team"
				),
				color: Colors.green,
				onPressed: model.createTeam,
			),
		);
	}
  
	@override
	CreateTeamViewModel viewModelBuilder(context)
	{
		return CreateTeamViewModel();
	}
}

class _ImagePicker extends HookViewModelWidget<CreateTeamViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return InkWell(
			child: CircleAvatar(
				radius: 32,
				child: Icon(
					Icons.star
				),
			),
			onTap: model.selectImage,
		);
	}
}

class _NameTextField extends HookViewModelWidget<CreateTeamViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.team.name,
			decoration: InputDecoration(
				labelText: "Name",
				prefixIcon: Icon(
					Icons.title,
					size: 32,
				),
			),
			validator: model.descriptionValidator,
			onChanged: (str) => model.team.name = str,
			onSaved: (str) => model.team.name = str,
		);
	}
}

class _DescriptionTextField extends HookViewModelWidget<CreateTeamViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.team.description,
			decoration: InputDecoration(
				labelText: "Name",
				prefixIcon: Icon(
					Icons.title,
					size: 32,
				),
			),
			validator: model.nameValidator,
			onChanged: (str) => model.team.description = str,
			onSaved: (str) => model.team.description = str,
		);
	}
}