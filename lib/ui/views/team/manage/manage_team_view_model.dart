import 'dart:io';

import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/utils.dart';

class ManageTeamViewModel extends BaseViewModel
{
	final _storage = locator<SecureStorage>();
	final _teamManager = locator<TeamManager>();
	final _fileApi = locator<FileApi>();
	final _navigation = locator<NavigationService>();

	final formKey = GlobalKey<FormState>();

	final Team team;
	final bool isEdit;
	File image;

	bool get hasImage => isEdit && team.image != null && image == null;

	ManageTeamViewModel({
		Team team
	}) :
		this.isEdit = team != null,
		this.team = team ?? Team();

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

	void manageTeam() async
	{
		if(formKey.currentState.validate())
		{
			formKey.currentState.save();
			team.managerId = _storage.player;

			if(image != null)
			{
				http.MultipartFile file = await http.MultipartFile.fromPath(
					'file',
					image.path,
					contentType: MediaType('image', 'png')
				);
				
				try
				{
					var res = await _fileApi.uploadFile(file);
					if(res.isSuccessful)
					{
						team.image = res.body["id"];
					}
				}
				catch(e)
				{
					print("Manage team, upload file: $e");
				}
			}
			
			if(isEdit)
			{
				if(await _teamManager.updateTeam(team))
				{
					_navigation.back(result: team);
				}
			}
			else
			{
				if(await _teamManager.insertTeam(team))
				{
					_navigation.back();
				}
			}
		}
	}
}