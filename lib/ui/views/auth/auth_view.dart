import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'package:mpm/ui/views/auth/auth_view_model.dart';

class AuthView extends ViewModelBuilderWidget<AuthViewModel>
{
	@override
	bool get reactive => false;

	@override
	Widget builder(context, model, child)
	{
		return Scaffold(
			body: Center(
			  	child: Padding(
					padding: const EdgeInsets.all(32),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Text(
								"MPM Logo",
								style: Theme.of(context).textTheme.headline4
							),
							SizedBox(height: 16),
							_LoginButton(),
							SizedBox(height: 8),
							_RegisterButton()
						],
					),
			  	),
			),
		);
	}
  
	@override
	AuthViewModel viewModelBuilder(context) 
	{
		return AuthViewModel();
	}
}

class _LoginButton extends ViewModelWidget<AuthViewModel>
{
	@override
	bool get reactive => true;

	@override
	Widget build(context, model)
	{
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				Expanded(
					child: RaisedButton(
						child: Text(
							"Login",
							style: TextStyle(
								color: Colors.white,
								fontSize: 16
							),
						),
						color: Theme.of(context).primaryColor,
						onPressed: model.toLogin
					),
				)
			],
		);
	}
}

class _RegisterButton extends ViewModelWidget<AuthViewModel>
{
	@override
	bool get reactive => true;

	@override
	Widget build(context, model)
	{
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: <Widget>[
				Expanded(
					child: RaisedButton(
						child: Text(
							"Signup",
							style: TextStyle(
								color: Colors.white,
								fontSize: 16
							),
						),
						color: Theme.of(context).primaryColor,
						onPressed: model.toRegister
					),
				)
			],
		);
	}
}