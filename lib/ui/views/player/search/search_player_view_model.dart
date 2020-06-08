import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/app/locator.dart';
import 'package:mpm/utils/utils.dart';

class SearchPlayerViewModel extends BaseViewModel
{
	final Team team;
	final _playerApi = locator<PlayerApi>();

	SearchPlayerViewModel({
		@required this.team
	});

	Future<List<Player>> onSearch(String str) async
	{
		if(str.length > minCharacters)
		{
			try
			{
				var res = await _playerApi.searchPlayers(str);
				if(res.isSuccessful) 
				{
					return res.body;
				}
			}
			catch(e)
			{
				print(e);
			}
		}

		return [];
	}

	void managePlayer()
	{

	}
}