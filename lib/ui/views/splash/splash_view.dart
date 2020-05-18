import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:mpm/ui/views/splash/splash_view_model.dart';

class SplashView extends ViewModelBuilderWidget<SplashViewModel>
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
			body: Center(
				child: CircularProgressIndicator(),
			),
		);
	}
  
	@override
	SplashViewModel viewModelBuilder(context)
	{
		return SplashViewModel();
	}
}