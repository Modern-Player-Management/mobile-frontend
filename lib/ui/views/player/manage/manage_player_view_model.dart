import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';

class ManagePlayerViewModel extends BaseViewModel
{
	final Player player;

	ManagePlayerViewModel({
		this.player
	});

	final _minCharacters = 3;
	final formKey = GlobalKey<FormState>();

	String nameValidator(String str)
	{
		if(str.isEmpty || str.length < _minCharacters)
		{
			return "You must enter a name with at least 3 characters";
		}

		return null;
	}

	String descriptionValidator(String str)
	{
		if(str.isEmpty || str.length < _minCharacters)
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

		File file = await FilePicker.getFile(
			type: FileType.image
		);
	}

	void managePlayer()
	{

	}
}