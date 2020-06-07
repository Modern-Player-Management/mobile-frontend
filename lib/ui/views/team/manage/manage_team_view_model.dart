import 'dart:io';

import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/utils.dart';

class ManageTeamViewModel extends BaseViewModel
{
	final _storage = locator<SecureStorage>();
	final _teamManager = locator<TeamManager>();

	final formKey = GlobalKey<FormState>();

	Team team = Team();
	File image;

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

	void selectImage() async
	{
		if(!await Permission.storage.isGranted)
		{
			await Permission.storage.request();
		}

		if(!await Permission.storage.isGranted)
		{
			//todo: display error message
			return;
		}

		image = await FilePicker.getFile(
			type: FileType.image
		);

		notifyListeners();
	}

	void manageTeam()
	{
		if(formKey.currentState.validate())
		{
			formKey.currentState.save();
			team.managerId = _storage.player;
			
			_teamManager.insertTeam(team);
		}
	}
}