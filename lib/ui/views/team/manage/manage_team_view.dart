import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'package:mpm/ui/views/team/manage/manage_team_view_model.dart';
import 'package:mpm/ui/widgets/button.dart';

class ManageTeamView extends ViewModelBuilderWidget<ManageTeamViewModel>
{
	@override
  	bool get reactive => false;

  	@override
  	Widget builder(context, model, child)
	{
		return Scaffold(
			appBar: AppBar(
				title: Text(
					"Manage a team"
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
					"Manage a team"
				),
				color: Colors.green,
				onPressed: model.manageTeam,
			),
		);
	}
  
	@override
	ManageTeamViewModel viewModelBuilder(context)
	{
		return ManageTeamViewModel();
	}
}

class _ImagePicker extends HookViewModelWidget<ManageTeamViewModel>
{
	@override
  	bool get reactive => true;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return InkWell(
			child: CircleAvatar(
				backgroundColor: model.image == null ?
				null : Colors.transparent,
				radius: 32,
				child: model.image == null ?
				Icon(
					Icons.star
				) :
				Image.file(model.image)
			),
			onTap: model.selectImage,
		);
	}
}

class _NameTextField extends HookViewModelWidget<ManageTeamViewModel>
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

class _DescriptionTextField extends HookViewModelWidget<ManageTeamViewModel>
{
	@override
  	bool get reactive => false;

	@override
	Widget buildViewModelWidget(context, model) 
	{
		return TextFormField(
			initialValue: model.team.description,
			decoration: InputDecoration(
				labelText: "Description",
				prefixIcon: Icon(
					Icons.description,
					size: 32,
				),
			),
			validator: model.nameValidator,
			onChanged: (str) => model.team.description = str,
			onSaved: (str) => model.team.description = str,
		);
	}
}