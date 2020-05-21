import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:mpm/ui/views/splash/splash_view_model.dart';

class SplashView extends ViewModelBuilderWidget<SplashViewModel>
{
	@override
	bool get reactive => false;

  	@override
  	Widget builder(context, model, child)
	{
		return Scaffold(
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						CircularProgressIndicator(),
						SizedBox(height: 32),
						Text(
							"Put a splash screen here !",
							style: TextStyle(
								fontSize: 20
							),
						)
					],
				),
			),
		);
	}
  
	@override
	SplashViewModel viewModelBuilder(context)
	{
		return SplashViewModel();
	}
}