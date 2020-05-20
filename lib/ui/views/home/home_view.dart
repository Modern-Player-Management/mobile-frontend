import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:mpm/ui/views/home/home_view_model.dart';

class HomeView extends ViewModelBuilderWidget<HomeViewModel>
{
	@override
	bool get reactive => false;
	
	@override
	bool get disposeViewModel => true;

  	@override
  	Widget builder(context, model, child)
	{
		return Scaffold(
			appBar: AppBar(),
			body: StreamBuilder(
				stream: null,
				builder: (context, snapshot){
					if(snapshot.hasData)
					{
						return ListView.builder(
							itemCount: 10,
							itemBuilder: (context, i){
								return Card(
									child: ListTile(
										title: Text(
											"Title"
										),
									),
								);
							},
						);
					}

					return Center(
						child: CircularProgressIndicator(),
					);
				},
			)
		);
	}
  
	@override
	HomeViewModel viewModelBuilder(context)
	{
		return HomeViewModel(
			context: context
		);
	}
}