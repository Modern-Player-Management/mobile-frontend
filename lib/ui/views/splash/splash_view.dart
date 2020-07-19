import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:mpm/ui/views/splash/splash_view_model.dart';
import 'package:mpm/ui/widgets/logo.dart';

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
						Logo()
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